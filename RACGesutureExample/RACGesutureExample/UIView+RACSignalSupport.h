//
// Created by aaaron7 on 1/15/16.
// Copyright (c) 2016 aaaron7. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>


@interface UIView (RACSignalSupport)

- (RACSignal *) rac_signalForGestureRecognizer:(Class)gestureClass;
@end