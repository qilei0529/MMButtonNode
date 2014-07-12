//
//  ButtonNode.h
//  Created by qilei on 14-7-12.
//

#import <SpriteKit/SpriteKit.h>

@interface MMButtonNode : SKSpriteNode

@property (nonatomic) NSString * text;

+ (instancetype)button:(SKColor *)color size:(CGSize)size;

- (void)addAction:(dispatch_block_t)block;

@end