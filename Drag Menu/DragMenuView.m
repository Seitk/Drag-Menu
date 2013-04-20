//
//  DragMenuView.m
//  Drag Menu
//
//  Created by Philip Yu on 4/20/13.
//  Copyright (c) 2013 Philip Yu. All rights reserved.
//

#import "DragMenuView.h"
#import "UIView+Positioning.h"

#define lolMode 1

#define lolmaxControlRadius 100
#define lolcenterViewRadius 25
#define maxControlRadius 60
#define centerViewRadius 25

#define lolpadActive 0.9
#define lolpadDeactive 1.0
#define padActive 1.0
#define padDeactive 0.3

#define tagCenterView 250
#define tagPointerView 255
#define tagOptions 240
#define tagPadSelected 400

#define indexCenterView 9500

@implementation DragMenuView

- (id)initDragMenuView
{
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    
    self = [super initWithFrame:screenBound];
    if (self) {
        // Initialization code
        [self setHidden:YES];
        self.backgroundColor = [UIColor clearColor];
        
        // Configure your custom interface here
        float centerRadius = (lolMode ? lolcenterViewRadius : centerViewRadius);
        float controlRadius = (lolMode ? lolmaxControlRadius : maxControlRadius);
        
        centerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, centerRadius * 2, centerRadius * 2)];
        centerView.center = CGPointMake(0, 0);
        centerView.backgroundColor = [UIColor clearColor];
        centerView.tag = tagCenterView;
        
        if (lolMode)
        {
            centerView.image = [UIImage imageNamed:@"lolpadBg.png"];
        } else {
            centerView.image = [UIImage imageNamed:@"padBg.png"];
        }
        
        [self insertSubview:centerView atIndex:indexCenterView];
        
        for (int i = 0; i < 4; i++) {
            UIImageView *option1 = [[UIImageView alloc] initWithFrame:CGRectMake(dragStartPoint.x, dragStartPoint.y, controlRadius, controlRadius)];
            [option1 setOrigin:0 :0];
            [option1 setCenter:CGPointMake(dragStartPoint.x , dragStartPoint.y)];
            option1.transform = CGAffineTransformMakeRotation((45 + 45 * i * 2) * M_PI / 180);
            option1.tag = tagOptions+i;
            
            if (lolMode)
            {
                option1.image = [UIImage imageNamed:[NSString stringWithFormat:@"loloption%d.png", i]];
                option1.alpha = lolpadActive;
                UIImageView *selectedOverlay = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, controlRadius, controlRadius)];
                selectedOverlay.image = [UIImage imageNamed:@"lolpadSelected.png"];
                selectedOverlay.tag = tagPadSelected;
                [selectedOverlay setHidden:YES];
                
                [option1 addSubview:selectedOverlay];
                
            } else {
                option1.backgroundColor = [UIColor grayColor];
            }
            
            [self insertSubview:option1 belowSubview:centerView];
        }

    }
    
    return self;
}

- (void) dragEvent:(UIPanGestureRecognizer *)panGR
{
    // Drag event start
    if (panGR.state == UIGestureRecognizerStateBegan)
    {
        [self setHidden:NO];
        
        dragStartPoint = CGPointMake([panGR locationInView:self].x, [panGR locationInView:self].y);
        centerView.center = CGPointMake(dragStartPoint.x, dragStartPoint.y);
        for (UIView *view in [self subviews]) {
            if (view.tag >= tagOptions && view.tag < tagOptions+4)
            {
                [view setCenter:CGPointMake(dragStartPoint.x , dragStartPoint.y)];
            }
        }
        
    }
    
    // Get current touch point in view
    float curX = [panGR locationInView:self].x;
    float curY = [panGR locationInView:self].y;
    
    // Get derivative, distance and angle to current touch point
    float dX = curX - dragStartPoint.x;
    float dY = curY - dragStartPoint.y;
    float distance = sqrt(dX * dX + dY * dY);
    float angle = atan(dX / dY);
    
    // Restrict the pointer in a circle, update location of pointer
    // can be used for draw line, joystick pointer, etc.
    //
    //    int quadrant = (dY >= 0 ? 1: -1);
    //    float updatedX = dragStartPoint.x + dX; // By default updatedX = current touch position X
    //    float updatedY = dragStartPoint.y + dY; // By default updatedY = current touch position Y
    //    
    //    if (distance > maxControlRadius)
    //    {
    //        updatedX = dragStartPoint.x + (sin(angle) * maxControlRadius) * quadrant;
    //        updatedY = dragStartPoint.y + (cos(angle) * maxControlRadius) * quadrant;
    //    }
    
    // Reset all highlighted options
    for (UIView *view in [self subviews]) {
        if (view.tag >= tagOptions && view.tag < tagOptions+4)
        {
            [self optionResetHighlight:view.tag - tagOptions];
        }
    }
    
    //  Highlight touch over option
    if (distance > centerViewRadius)
    {
        // Trigger option event by angle
        [self optionTouchOver:[self angleToOption:angle derivative:CGPointMake(dX, dY)]];        
    }
    
    if (panGR.state == UIGestureRecognizerStateEnded)
    {
        if (distance <= centerViewRadius)
        {
            // Center Option
            // Do nothing by default
        } else {
            // option selected
            [self optionSelected:[self angleToOption:angle derivative:CGPointMake(dX, dY)]];
        }
        
        [self setHidden:YES];
    }
}

- (int) angleToOption:(float)angle derivative:(CGPoint)derivative
{
    if (derivative.y >= 0 && angle <= 0.75 && angle > -0.75)
    {
        return 0;
    } else if (derivative.y < 0 && angle <= 0.75 && angle > -0.75)
    {
        return 2;
    } else if (derivative.x >= 0) {
        return 3;
    } else {
        return 1;
    }
}

- (void) optionTouchOver:(int)idx
{
    // Trigger touch over
    [[self viewWithTag:tagOptions + idx] setAlpha:(lolMode ? lolpadActive : padActive)];
    [[[self viewWithTag:tagOptions + idx] viewWithTag:tagPadSelected] setHidden:NO];
}

- (void) optionResetHighlight:(int)idx
{
    [[self viewWithTag:tagOptions + idx] setAlpha:(lolMode ? lolpadDeactive : padDeactive)];
    [[[self viewWithTag:tagOptions + idx] viewWithTag:tagPadSelected] setHidden:YES];
}

- (void) optionSelected:(int)idx
{
    // Trigger selected action
    // You can find viewController from superview and call it's function here
}




@end
