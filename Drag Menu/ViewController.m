//
//  ViewController.m
//  Drag Menu
//
//  Created by Philip Yu on 4/19/13.
//  Copyright (c) 2013 Philip Yu. All rights reserved.
//

#import "ViewController.h"

#define indexMenuView 9999

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    demoDMView = [[DragMenuView alloc] initDragMenuView];
    [self.view insertSubview:demoDMView atIndex:indexMenuView];
    
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragEvent:)];
    [panGR setMaximumNumberOfTouches:1];
    [panGR setMinimumNumberOfTouches:1];
    [self.view addGestureRecognizer:panGR];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dragEvent:(UIPanGestureRecognizer *)panGR
{
    [demoDMView dragEvent:panGR];
}


@end
