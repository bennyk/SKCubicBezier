//
//  BezierAction.h
//  SKScrollNode
//
//  Created by Benny Khoo on 7/30/15.
//  Copyright (c) 2015 Benny Khoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface SKAction (SKCubicBezier)

+ (SKAction *) moveTo:(CGPoint)location duration:(NSTimeInterval)duration P1:(CGPoint)p1 P2:(CGPoint)p2;

+ (SKAction *) easingOutTo:(CGPoint)location duration:(NSTimeInterval)duration;
+ (SKAction *) easingInTo:(CGPoint)location duration:(NSTimeInterval)duration;

@end
