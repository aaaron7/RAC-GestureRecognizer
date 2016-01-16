//
// Created by aaaron7 on 1/15/16.
// Copyright (c) 2016 aaaron7. All rights reserved.
//

#import "UIView+RACSignalSupport.h"
#import <objc/runtime.h>

@implementation UIView (RACSignalSupport)

- (RACSignal *) rac_signalForGestureRecognizer:(Class)gestureClass{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        @strongify(self);


        UIGestureRecognizer *gr = [(UIGestureRecognizer *)[gestureClass alloc] initWithTarget:subscriber action:@selector(sendNext:)];
        [self addGestureRecognizer:gr];


        [self.rac_deallocDisposable addDisposable:[RACDisposable disposableWithBlock:^ {
            [subscriber sendCompleted];
        }]];
        return [RACDisposable disposableWithBlock:^ {
            @strongify(self);
            [self removeGestureRecognizer:gr];
        }];
    }];
}
@end