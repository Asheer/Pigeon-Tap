//
//  Pipe.h
//  FlapFlap

#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(NSInteger, PipeStyle) {
  PipeStyleTop,
  PipeStyleBottom,
};

@interface Pipe : SKSpriteNode

+ (Pipe *)pipeWithHeight:(CGFloat)height withStyle:(PipeStyle)style;

- (void)setPipeCategory:(uint32_t)pipe playerCategory:(uint32_t)player;

@end
