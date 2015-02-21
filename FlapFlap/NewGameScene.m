//
//  NewGameScene.m
//  FlapFlap

#import "NewGameScene.h"
#import "GameScene.h"
static const CGFloat kGroundHeight = 56.0;

@interface NewGameScene()
@property (nonatomic) AVAudioPlayer *playerAudio;
@end

@implementation NewGameScene {
  SKSpriteNode *_button;
  SKSpriteNode *_ground;
}

- (id)initWithSize:(CGSize)size
{
  if (self = [super initWithSize:size]) {
    [self setBackgroundColor:[SKColor colorWithRed:.61 green:.74 blue:.86 alpha:1]];
      
      SKSpriteNode *name = [SKSpriteNode spriteNodeWithImageNamed:@"TitleLogo"];
      name.size = CGSizeMake(303, name.size.height);
      name.position = CGPointMake(self.size.width/2, self.size.height - 60);      [self addChild:name];

      SKSpriteNode *cloud1 = [SKSpriteNode spriteNodeWithImageNamed:@"Cloud"];
      [cloud1 setPosition:CGPointMake(100, self.size.height - (cloud1.size.height*3))];
      [self addChild:cloud1];
      
      SKSpriteNode *cloud2 = [SKSpriteNode spriteNodeWithImageNamed:@"Cloud"];
      [cloud2 setPosition:CGPointMake(self.size.width - (cloud2.size.width/2) + 50, self.size.height - (cloud2.size.height*5))];
      [self addChild:cloud2];
      
      _ground = [SKSpriteNode spriteNodeWithImageNamed:@"Ground"];
      [_ground setCenterRect:CGRectMake(26.0/kGroundHeight, 26.0/kGroundHeight, 4.0/kGroundHeight, 4.0/kGroundHeight)];
      [_ground setPosition:CGPointMake(self.size.width/2, _ground.size.height/2)];
      [self addChild:_ground];

      _button = [SKSpriteNode spriteNodeWithImageNamed:@"playButton"];
     [_button setPosition:CGPointMake(self.size.width/2, self.size.height/3)];
      _button.size = CGSizeMake(160, 100);

    [self addChild:_button];
      
      SKSpriteNode *bird1 = [SKSpriteNode spriteNodeWithImageNamed:@"pigeon"];
      bird1.position = CGPointMake(cloud1.position.x, cloud1.position.y + 40);
      bird1.size = CGSizeMake(38, 27);
      [self addChild:bird1];
      
      
      SKSpriteNode *bird2 = [SKSpriteNode spriteNodeWithImageNamed:@"pigeon2"];
      bird2.position = CGPointMake(cloud2.position.x - 20, cloud2.position.y + 40);
      bird2.size = CGSizeMake(38, 27);
     // bird2.zRotation = M_PI/12.0f;
      [self addChild:bird2];
      
      NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"sound_bird" ofType:@"mp3"]];
      self.playerAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
      
      [self.playerAudio play];

      
  }
  return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    if ([_button containsPoint:location]) {
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"button" ofType:@"mp3"]];
        self.playerAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        
        [self.playerAudio play];

        SKTransition *transition = [SKTransition doorsOpenHorizontalWithDuration:1.5];
        GameScene *game = [[GameScene alloc] initWithSize:self.size];
        [self.scene.view presentScene:game transition:transition];

    }
}

@end
