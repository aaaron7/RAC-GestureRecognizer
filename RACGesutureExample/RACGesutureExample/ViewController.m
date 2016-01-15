//
//  ViewController.m
//  RACGesutureExample
//
//  Created by aaaron7 on 1/15/16.
//  Copyright (c) 2016 aaaron7. All rights reserved.
//


#import "ViewController.h"
#import "UIView+RACSignalSupport.h"


@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [[self.view rac_signalForGestureRecognizer:[UITapGestureRecognizer class]] subscribeNext:^(UITapGestureRecognizer * x) {
        NSLog(@"view tapped at %f,%f", [x locationInView:x.view].x,[x locationInView:x.view].y);
    }];

    [[self.view rac_signalForGestureRecognizer:[UIPanGestureRecognizer class]] subscribeNext:^(id x) {
        NSLog(@"view panned");
    }];

    [[self.view rac_signalForGestureRecognizer:[UIPinchGestureRecognizer class]] subscribeNext:^(id x) {
        NSLog(@"view pinched");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end