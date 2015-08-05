//
//  BezierAction.m
//  SKScrollNode
//
//  Created by Benny Khoo on 7/30/15.
//  Copyright (c) 2015 Benny Khoo. All rights reserved.
//

#import "SKBezierAction.h"
#import "BezierEvaluator.h"

@implementation SKAction (SKCubicBezier)

// for a standard list of predefined curve refer to
// http://cubic-bezier.com

+ (SKAction *) easingOutTo:(CGPoint)location duration:(NSTimeInterval)duration
{
    return [self moveTo:location duration:duration P1:CGPointMake(.0, .0) P2:CGPointMake(.58, 1.0)];
}

+ (SKAction *) easingInTo:(CGPoint)location duration:(NSTimeInterval)duration
{
    return [self moveTo:location duration:duration P1:CGPointMake(.42, .0) P2:CGPointMake(1.0, 1.0)];
}

+ (SKAction *) moveTo:(CGPoint)location duration:(NSTimeInterval)duration P1:(CGPoint)p1 P2:(CGPoint)p2
{
    __block BOOL init = NO;
    __block CGVector v, u;
    __block CGFloat distance;
    __block CGPoint initPos;
    
    BezierEvaluator *eval = [[BezierEvaluator alloc] initWithP1:p1 P2:p2];
    SKAction *result = [SKAction customActionWithDuration:duration actionBlock:^(SKNode *node, CGFloat elapsedTime) {
        if (!init) {
            v = CGVectorMake(location.x - node.position.x, location.y - node.position.y);
            distance = hypotf(v.dx, v.dy);
            u = CGVectorMake(v.dx/distance, v.dy/distance);
            initPos = node.position;
            init = YES;
        }
        
        CGFloat t = elapsedTime / duration;
        CGFloat frac = [eval evaluate:t];
        CGFloat d = frac * distance;
        CGVector delta = CGVectorMake(u.dx * d, u.dy * d);
//        NSLog(@"t %.2f elapsed %.2f delta %@", t, elapsedTime, NSStringFromCGVector(delta));
        node.position = CGPointMake(initPos.x + delta.dx, initPos.y + delta.dy);
    }];
    
    return result;
}
@end
