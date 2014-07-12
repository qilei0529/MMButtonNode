//
//  GameScene.m
//  MMButtonNodeDemo
//

#import "GameScene.h"
#import "MMButtonNode.h"


#define RGBA(r, g, b, a) [SKColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface GameScene ()

@property (nonatomic) NSMutableArray * array;

@end
@implementation GameScene {
    int _count;
}

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    myLabel.text = @"Hello, World!";
    myLabel.fontSize = 65;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame));
    
    [self addChild:myLabel];
    
    
    _array = [NSMutableArray array];
    _count = 0;
}


-(void)addButton:(CGPoint)location
{
    MMButtonNode * btn;
    
    NSInteger count = _array.count;
    
    if (count > 100) {
        btn = [_array firstObject];
        [_array removeObject:btn];
        [btn removeFromParent];
        btn = nil;
    }
    
    btn = [MMButtonNode button:RGBA(255, 0, 100, 1) size:CGSizeMake(50, 50)];
    btn.text = [NSString stringWithFormat:@"%d" , rand() % 1000];
    
    
    NSInteger i = _array.count;
    btn.name = [NSString stringWithFormat:@"btn-%d", (int)i];
    
    [btn addAction:^{
        [self onBtnClick:i];
    }];
    
    btn.position = location;
    SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
    [btn runAction:[SKAction repeatActionForever:action]];
    [self addChild:btn];
    [_array addObject:btn];
    
}


-(void)onBtnClick:(NSInteger)i
{
    NSLog(@"btn-%d clicked" , (int)i);
    
    //remove btns when i%10 == 0
    if (i % 10 == 0) {
        while (_array.count > 0) {
            MMButtonNode * btn = [_array firstObject];
            [_array removeObject:btn];
            [btn removeFromParent];
            btn = nil;
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        [self addButton:location];
        
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
