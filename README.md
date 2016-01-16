# RAC-GestureRecognizer
Implemented UIView gesture recognizer integration for ReactiveCocoa 2.5


## Configure

Directly drag [UIView+RACSignalSupport.h/UIView+RACSignalSupport.m] file into your project.

## Usage

```objc
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



//Quick implementation of draggable view
UIView* t = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
t.backgroundColor = [UIColor yellowColor];
[self.view addSubview:t];

RAC(t,center) = [[t rac_signalForGestureRecognizer:[UIPanGestureRecognizer class]] map:^id(UIPanGestureRecognizer* value) {
    CGPoint p = [value translationInView:self.view];
    [value setTranslation:CGPointZero inView:self.view];
    return [NSValue valueWithCGPoint:CGPointMake(t.center.x + p.x, t.center.y + p.y)];
}];

```

## Example Project

**Cocoapods is required for example project**

Under .xcworkspace folder, run
```
pod install
```
,then open RACGesutureExample.xcworkspace
