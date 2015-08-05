# SKCubicBezier

Implementation of Cubic Bezier tweening on SpriteKit framework similar to CSS style.

        #import "SKBezierAction.h"
        ...
        // See web for visual
        // http://cubic-bezier.com/#.95,.05,.48,1.52
        CGPoint toPos = CGPointMake(self.size.width * .5, self.size.height * .5);
        SKAction *action = [SKAction moveTo:toPos duration:1 P1:CGPointMake(.95, .05) P2:CGPointMake(.48, 1.52)];
        
        [sprite runAction:action];
