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

    //detect tap event
    [[self.view rac_signalForGestureRecognizer:[UITapGestureRecognizer class]] subscribeNext:^(UITapGestureRecognizer * x) {
        NSLog(@"view tapped at %f,%f", [x locationInView:x.view].x,[x locationInView:x.view].y);
    }];
    
    //detect pan event in Rect(100,100,200,200)
    [[[self.view rac_signalForGestureRecognizer:[UIPanGestureRecognizer class]] filter:^BOOL(id value) {
        UIPanGestureRecognizer* pgr = (UIPanGestureRecognizer*)value;
        CGRect rect = CGRectMake(100, 100, 200, 200);
        return CGRectContainsPoint(rect, [pgr locationInView:pgr.view]);
    }] subscribeNext:^(id x) {
        NSLog(@"panned in given rect");
    }];
    
    
    //detect pinch event
    [[self.view rac_signalForGestureRecognizer:[UIPinchGestureRecognizer class]] subscribeNext:^(id x) {
        NSLog(@"view pinched");
    }];
    
    
    
    //Quick imeplementation of draggable view
    UIView* t = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    t.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:t];
    
    RAC(t,center) = [[t rac_signalForGestureRecognizer:[UIPanGestureRecognizer class]] map:^id(UIPanGestureRecognizer* value) {
        CGPoint p = [value translationInView:self.view];
        [value setTranslation:CGPointZero inView:self.view];
        return [NSValue valueWithCGPoint:CGPointMake(t.center.x + p.x, t.center.y + p.y)];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end