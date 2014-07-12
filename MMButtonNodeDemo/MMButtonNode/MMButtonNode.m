//
//  MMButtonNode.m
//  Created by qilei on 14-7-12.
//

#import "MMButtonNode.h"

#define ButtonEdge 10

#define ScaleKey 0.5

@interface MMButtonNode()

@property (nonatomic) UIFont *font;

@property (nonatomic) SKLabelNode * label;

@end

@implementation MMButtonNode {
    BOOL _inside;
    
    dispatch_block_t _block;
    
    UITouch * currentTouch;
    
}

+(MMButtonNode *)button:(SKColor *)color size:(CGSize)size
{
    MMButtonNode * btn = [MMButtonNode spriteNodeWithColor:color size:size];
    [btn initNode];
    return btn;
}


-(void)initNode
{
    NSLog(@" init btn node");
    _block = nil;
}


-(void)setText:(NSString *)text
{
    if (_label == nil) {
        _label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        _label.fontColor = [UIColor whiteColor];
        _label.fontSize = 26;
        [self addChild:_label];
    }
    
    _label.text = text;
    
}


-(void)addAction:(dispatch_block_t)block
{
    _block = block;
    self.userInteractionEnabled = YES;
}

-(void)touchDown
{
    [self runAction:[SKAction scaleTo:ScaleKey duration:0.1]];
}
-(void)touchUp
{
    if (_inside) {
        [self runAction:[SKAction scaleTo:1 duration:0.1] completion: _block];
    }else{
        [self runAction:[SKAction scaleTo:1 duration:0.1]];
    }
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _inside = YES;
    currentTouch = [touches anyObject];
    [self touchDown];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_inside) {
        
        if ([touches containsObject:currentTouch])
        {
            CGPoint point = [currentTouch locationInNode:self];
            float x = self.size.width / 2;
            float y = self.size.height / 2;
            
            if ((point.x > x + ButtonEdge)|| (point.x < (-x - ButtonEdge)) || (point.y > y + ButtonEdge) || (point.y < (-y - ButtonEdge)))
            {
                [self touchesCancelled:touches withEvent:Nil];
            }
        }
        
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_inside) {
        NSLog(@" press inside");
        [self touchUp];
    }
}


-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    _inside = NO;
    currentTouch = nil;
    [self touchUp];
}




@end
