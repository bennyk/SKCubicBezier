//
//  GameScene.m
//  SKCubicBezier
//
//  Created by Benny Khoo on 8/5/15.
//  Copyright (c) 2015 Benny Khoo. All rights reserved.
//

#import "GameScene.h"

#import "SKBezierAction.h"

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    myLabel.text = @"Hello, World!";
    myLabel.fontSize = 65;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame));
    
    [self addChild:myLabel];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        sprite.xScale = 0.5;
        sprite.yScale = 0.5;
        sprite.position = location;
        
        // See web for visual
        // http://cubic-bezier.com/#.95,.05,.48,1.52
        CGPoint toPos = CGPointMake(self.size.width * .5, self.size.height * .5);
        SKAction *action = [SKAction moveTo:toPos duration:1 P1:CGPointMake(.95, .05) P2:CGPointMake(.48, 1.52)];
        
        [sprite runAction:action];
        
        [self addChild:sprite];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
