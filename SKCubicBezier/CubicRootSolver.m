//
//  CubicRootSolver.m
//  SKScrollNode
//
//  Created by Benny Khoo on 7/30/15.
//  Copyright (c) 2015 Benny Khoo. All rights reserved.
//

#import "CubicRootSolver.h"

#define fequal(a,b) (fabs((a) - (b)) < FLT_EPSILON)
#define fequalzero(a) (fabs(a) < FLT_EPSILON)
#define flessthan(a,b) (fabs(a) < fabs(b)+FLT_EPSILON)

@interface CubicRootSolver ()

@property CGFloat a, b, c, d;
@property NSPredicate *realPredicate;
@end

CGFloat cuberoot(CGFloat v)
{
//     return -math.pow(-v, 1/3) if v < 0 else math.pow(v, 1/3)
    return v < 0 ? -powf(-v, 1/3.0f) : powf(v, 1/3.0f);
}


@implementation CubicRootSolver
- (instancetype)initWithA:(CGFloat)A B:(CGFloat)B C:(CGFloat)C D:(CGFloat)D
{
    self = [super init];
    if (self != nil) {
        
        self.d = -A + 3 * B - 3 * C + D;
        self.a = (3 * A - 6 * B + 3 * C) / self.d;
        self.b = (-3 * A + 3 * B) / self.d;
        self.c = A / self.d;
        
        self.realPredicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
            return [evaluatedObject floatValue] >= 0.f && [evaluatedObject floatValue] <= 1.0f;
        }];
    }
    
    return self;
}

- (CGFloat)solveRootsFor:(CGFloat)z
{
    NSArray *roots;
    
    CGFloat a = self.a;
    CGFloat b = self.b;
    CGFloat c = self.c;
    CGFloat d = self.d;
    
    c -= z / d;
    
    CGFloat p = (3*b - a*a)/3;
    CGFloat p3 = p/3;
    CGFloat q = (2*a*a*a - 9*a*b + 27*c)/27;
    CGFloat q2 = q/2;
    CGFloat discriminant = q2*q2 + p3*p3*p3;
    
    if (discriminant < 0) {
        CGFloat mp3  = -p/3;
        CGFloat mp33 = mp3*mp3*mp3;
        CGFloat r    = sqrtf( mp33 );
        CGFloat t    = -q / (2*r);
        CGFloat cosphi = t < -1 ? -1 : t > 1 ? 1 : t;
        CGFloat phi  = acosf(cosphi);
        CGFloat crtr = cuberoot(r);
        CGFloat t1   = 2*crtr;
        CGFloat root1 = t1 * cosf(phi/3) - a/3;
        CGFloat root2 = t1 * cosf((phi+2*M_PI)/3) - a/3;
        CGFloat root3 = t1 * cosf((phi+4*M_PI)/3) - a/3;
        
//        NSLog(@"bezier equation produces three roots: %.2f %.2f %.2f", root1, root2, root3);
        
        roots = [@[@(root1), @(root2), @(root3)] filteredArrayUsingPredicate:self.realPredicate];
    }
    else if (fequal(discriminant, 0.f)) {
        CGFloat u1 = q2 < 0 ? cuberoot(-q2) : -cuberoot(q2);
        CGFloat root1 = 2*u1 - a/3;
        CGFloat root2 = -u1 - a/3;
        
//        NSLog(@"bezier equation produces two roots: %.2f %.2f", root1, root2);
        
        roots = [@[@(root1), @(root2)] filteredArrayUsingPredicate:self.realPredicate];
    }
    else {
        CGFloat sd = sqrtf(discriminant);
        CGFloat u1 = cuberoot(sd - q2);
        CGFloat v1 = cuberoot(sd + q2);
        CGFloat root1 = u1 - v1 - a/3;
        
        // FIXME: temp fix for numerical error.
        if (fequal(root1, 0.0)) {
            root1 = 0;
        }
        
        roots = [@[@(root1)] filteredArrayUsingPredicate:self.realPredicate];
    }
    
    NSAssert([roots count] <= 1, @"bezier equation yields multiple roots!");
    NSAssert([roots count] > 0, @"Failed to find any roots in bezier equation for z %.2f", z);
    
    return [[roots firstObject] floatValue];
}


@end
