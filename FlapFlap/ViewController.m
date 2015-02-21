//
//  ViewController.m
//  FlapFlap

#import "ViewController.h"
#import "NewGameScene.h"

@implementation ViewController

- (void)loadView
{
  self.view  = [[SKView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  [self.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];

  SKView *view = (SKView *)[self view];
  [view setShowsFPS:NO];
  [view setShowsNodeCount:NO];

  SKScene *scene = [NewGameScene sceneWithSize:view.bounds.size];
  [scene setScaleMode:SKSceneScaleModeAspectFill];

  [view presentScene:scene];
}

@end
