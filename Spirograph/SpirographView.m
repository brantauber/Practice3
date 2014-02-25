//
//  SpirographView.m
//  Spirograph
//
//  Created by Brandon on 2/23/14.
//  Copyright (c) 2014 Michael Toth. All rights reserved.
//

#import "SpirographView.h"

@implementation SpirographView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.numberOfSteps = 2400;
        self.stepSize = 0.04;
        self.l = 0.5;
        self.k = 0.5;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGFloat x, y;
    UIBezierPath *bz = [[UIBezierPath alloc] init];
    CGFloat t = 0.0;
    x = 140 + 120 * ((1.0 - self.k)*cos(t) + (self.l)*(self.k)*cos(((1.0 - self.k)/self.k)*t));
    y = 140 + 120 * ((1.0 - self.k)*sin(t) - (self.l)*(self.k)*sin(((1.0 - self.k)/self.k)*t));
    CGPoint p = CGPointMake(x, y);
    [bz moveToPoint:p];
    for (t=0; t< (self.numberOfSteps * self.stepSize); t=t+self.stepSize) {
        x = 140 + 120 * ((1.0 - self.k)*cos(t) + (self.l)*(self.k)*cos(((1.0 - self.k)/self.k)*t));
        y = 140 + 120 * ((1.0 - self.k)*sin(t) - (self.l)*(self.k)*sin(((1.0 - self.k)/self.k)*t));
        p=CGPointMake(x, y);
        [bz addLineToPoint:p];
    }
    [bz stroke];

}


@end
