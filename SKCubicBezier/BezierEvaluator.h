//
//  BezierEvaluator.h
//  SKScrollNode
//
//  Created by Benny Khoo on 7/30/15.
//  Copyright (c) 2015 Benny Khoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface BezierEvaluator : NSObject

- (instancetype)initWithP1:(CGPoint)p1 P2:(CGPoint)p2;
- (CGFloat)evaluate:(CGFloat)x;

@end
