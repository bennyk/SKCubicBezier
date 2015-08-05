//
//  BezierEvaluator.m
//  SKScrollNode
//
//  Created by Benny Khoo on 7/30/15.
//  Copyright (c) 2015 Benny Khoo. All rights reserved.
//

#import "BezierEvaluator.h"
#import "CubicRootSolver.h"

static const CGPoint Origin = {.0, .0};
static const CGPoint Destination = {1.0, 1.0};

@interface BezierEvaluator ()

@property CGPoint P1;
@property CGPoint P2;
@property CubicRootSolver *rootSolver;
@end


@implementation BezierEvaluator

- (instancetype)initWithP1:(CGPoint)p1 P2:(CGPoint)p2
{
    self = [super init];
    if (self != nil) {
        self.rootSolver = [[CubicRootSolver alloc] initWithA:Origin.x B:p1.x C:p2.x D:Destination.x];
        self.P1 = p1;
        self.P2 = p2;
    }
    
    return self;
}

- (CGFloat)evaluate:(CGFloat)x
{
    // FIXME: bezier equation has no solution for x >= 1.0.
    if (x >= 1.0) {
        return x;
    }
    CGFloat t = [self.rootSolver solveRootsFor:x];
//    NSLog(@"roots for %.2f is %.4f", x, t);
    
    // x = A*(1-t)**3 + B*3*(1-t)**2 * t + C*3*(1-t)*t**2 + D*t**3
    return Origin.y * powf(1-t, 3) + self.P1.y * 3 * powf(1-t, 2) * t + self.P2.y * 3 * (1-t) * t*t + Destination.y * powf(t, 3);
}

@end
