//
//  DragMenuView.h
//  Drag Menu
//
//  Created by Philip Yu on 4/20/13.
//  Copyright (c) 2013 Philip Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DragMenuView : UIView
{
    UIView *contentView;
    CGPoint dragStartPoint;
    UIImageView *centerView;
}

- (id)initDragMenuView;
- (void) dragEvent:(UIPanGestureRecognizer *)panGR;

@end
