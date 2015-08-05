//
//  CubicRootSolver.h
//  SKScrollNode
//
//  Created by Benny Khoo on 7/30/15.
//  Copyright (c) 2015 Benny Khoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface CubicRootSolver : NSObject

- (instancetype)initWithA:(CGFloat)A B:(CGFloat)B C:(CGFloat)C D:(CGFloat)D;
- (CGFloat)solveRootsFor:(CGFloat)z;
@end
