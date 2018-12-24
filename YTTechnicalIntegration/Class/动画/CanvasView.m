//
//  CanvasView.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/2/24.
//  Copyright © 2018年 hiteam. All rights reserved.
//

#import "CanvasView.h"

@implementation CanvasView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.pointArray = [[NSMutableArray alloc] initWithCapacity:0];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}


- (void)panAction:(UIPanGestureRecognizer *)pan{
    CGPoint point = [pan locationInView:self];
    NSLog(@"X:%f--Y:%f",point.x,point.y);
    [self.pointArray addObject:[NSValue valueWithCGPoint:point]];
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    if (self.pointArray.count>1) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        for (int i = 0; i<self.pointArray.count; i++) {
            CGPoint point = self.pointArray[i].CGPointValue;
            if (i == 0) {
                CGContextMoveToPoint(context, point.x, point.y);
            }else{
                CGContextAddLineToPoint(context, point.x, point.y);
            }
        }
        CGContextSetLineWidth(context, 1);
        CGFloat components[] = {221.0/255,221.0/255,221.0/255,1.0f};
        CGContextSetStrokeColor(context, components);
        CGContextStrokePath(context);
    }
}


@end
