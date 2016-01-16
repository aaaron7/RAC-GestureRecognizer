# RAC-GestureRecognizer
Implemented UIView gesture recognizer integration for ReactiveCocoa 2.x


## Configure

Directly drag [UIView+RACSignalSupport.h/UIView+RACSignalSupport.m] file into your project.

## Usage

```objc
    [[self.view rac_signalForGestureRecognizer:[UITapGestureRecognizer class]] subscribeNext:^(UITapGestureRecognizer * x) {
        NSLog(@"view tapped at %f,%f", [x locationInView:x.view].x,[x locationInView:x.view].y);
    }];

    [[self.view rac_signalForGestureRecognizer:[UIPanGestureRecognizer class]] subscribeNext:^(id x) {
        NSLog(@"view panned");
    }];

    [[self.view rac_signalForGestureRecognizer:[UIPinchGestureRecognizer class]] subscribeNext:^(id x) {
        NSLog(@"view pinched");
    }];

```

## Example Project 

**Cocoapods is required for example project**

Under .xcworkspace folder, run 
```
pod install
```
,then open RACGesutureExample.xcworkspace

