//
//  GameOver.m
//  FlapFlap

#import "GameOver.h"
#import "NewGameScene.h"
#import "GameScene.h"
#import <Social/Social.h>
#import <AVFoundation/AVFoundation.h>

@interface GameOver()
@property (nonatomic) SKSpriteNode *background;
@property (nonatomic) SKLabelNode *bestScoreEver;
@property (nonatomic) SKSpriteNode *gameOver;
@property (nonatomic) SKSpriteNode *retry;
@property (nonatomic) SKSpriteNode *done;
@property (nonatomic) SKSpriteNode *bestMenu;
@property (nonatomic) SKSpriteNode *fb;
@property (nonatomic) SKSpriteNode *twitter;
@property (nonatomic) UIImage *screenshot;
@property (nonatomic) SKAction *movePlayer;
@property (nonatomic) SKAction *moveMenu;
@property (nonatomic) SKSpriteNode *player;
@property (nonatomic) NSString *scoreString;
@property (nonatomic) NSString *bestString;
@property (nonatomic) SKLabelNode *scoreLabel;
@property (nonatomic) SKLabelNode *bestScoreLabel;
@property (nonatomic) AVAudioPlayer *playerAudio;

@end
@implementation GameOver
-(instancetype) initWithSize:(CGSize)size {
    
    if(self == [super initWithSize:size]) {
        
        [self setBackgroundColor:[SKColor colorWithRed:.69 green:.84 blue:.97 alpha:1]];
    }
    
    return self;
}

-(void)didMoveToView:(SKView *)view
{
    
    self.scoreString = [[NSUserDefaults standardUserDefaults] valueForKey:@"score"];
    self.bestString = [[NSUserDefaults standardUserDefaults] valueForKey:@"highScore"];
    [self gameOverStuff];
    [self addPlayer:self.size];
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"gameoversound" ofType:@"mp3"]];
    self.playerAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    
    [self.playerAudio play];
    
}

-(void) gameOverStuff {
    
    [self best];
    
    self.gameOver = [SKSpriteNode spriteNodeWithImageNamed:@"gameover.png"];
    
    self.done = [SKSpriteNode spriteNodeWithImageNamed:@"Done.png"];
    
    self.retry = [SKSpriteNode spriteNodeWithImageNamed:@"Retry.png"];
    
    self.fb = [SKSpriteNode spriteNodeWithImageNamed:@"facebook.png"];
    self.twitter = [SKSpriteNode spriteNodeWithImageNamed:@"sharetwitter.png"];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        self.gameOver.size = CGSizeMake(self.gameOver.size.width + 400, self.gameOver.size.height + 100);
        self.gameOver.position = CGPointMake(self.size.width/2,self.size.height - 80);
        self.done.size = CGSizeMake(200, 50);
        self.retry.size = CGSizeMake(200, 50);
        self.done.position = CGPointMake(self.bestMenu.position.x - 80, self.bestMenu.position.y + 240);
        
        self.fb.size = CGSizeMake(200, 60);
        self.twitter.size = CGSizeMake(200, 60);
        
        self.fb.position = CGPointMake(110, 40);
        self.twitter.position = CGPointMake(self.size.width - 110, 40);
        
    } else {
        self.done.position = CGPointMake(self.bestMenu.position.x - 40, self.bestMenu.position.y + 180);
        self.gameOver.position = CGPointMake(self.size.width/2,self.size.height - 40);
        self.fb.size = CGSizeMake(100, 30);
        self.twitter.size = CGSizeMake(100, 30);
        
        self.fb.position = CGPointMake(60, 25);
        self.twitter.position = CGPointMake(self.size.width - 60, 25);
    }
    
    self.retry.position = CGPointMake(self.done.position.x + self.done.size.width, self.done.position.y);
    
    [self addChild:self.gameOver];
    [self addChild:self.done];
    [self addChild:self.retry];
    [self addChild:self.fb];
    [self addChild:self.twitter];
}

-(void) addPlayer:(CGSize)size{
    
    self.player = [SKSpriteNode spriteNodeWithImageNamed:@"pigeonGame"];
    self.player.size = CGSizeMake(38, 27);
    self.player.position = CGPointMake(self.retry.position.x - 10, self.retry.position.y + 260);
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        self.player.size = CGSizeMake(158, 160);
        self.movePlayer = [SKAction moveToY:self.retry.position.y + 80 duration:1.0];
    }else
    {
        self.player.size = CGSizeMake(70, 76);
        self.movePlayer = [SKAction moveToY:self.retry.position.y + 58 duration:1.0];
    }
    
    
    [self.player runAction:self.movePlayer];
    
    [self addChild:self.player];
}

-(void) best {
    
    self.bestMenu = [SKSpriteNode spriteNodeWithImageNamed:@"bestScore.png"];
    
    self.bestMenu.position = CGPointMake(self.size.width/2, -50);
    
    self.scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"TimesNewRomanPS-BoldItalicMT"];
    NSInteger score = [self.scoreString integerValue];
    self.scoreLabel.text = @(score).stringValue;
    self.scoreLabel.fontColor = [SKColor redColor];
    
    self.scoreLabel.zPosition = 200;
    self.scoreLabel.position = CGPointMake(62, -10);
    
    self.bestScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Verdana-BoldItalic"];
    NSInteger bestScore = [self.bestString integerValue];
    self.bestScoreLabel.text = @(bestScore).stringValue;
    self.bestScoreLabel.position = CGPointMake(240, 0);
    self.bestScoreLabel.fontColor = [SKColor blueColor];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        SKAction *moveScore = [SKAction moveToY:self.size.height/2 + 40 duration:0.7];
        SKAction *moveBestScore = [SKAction moveToY:self.size.height/2 + 40 duration:0.9];
        self.moveMenu = [SKAction moveToY:self.size.height/2 + 40 duration:0.5];
        self.bestMenu.size = CGSizeMake(720, 400);
        self.scoreLabel.fontSize = 60;
        self.bestScoreLabel.fontSize = 50;
        self.scoreLabel.position = CGPointMake(160, -10);
        self.bestScoreLabel.position = CGPointMake(570, 0);
        [self.scoreLabel runAction:moveScore];
        [self.bestScoreLabel runAction:moveBestScore];
    }else
    {
        SKAction *moveScore = [SKAction moveToY:self.size.height/2 + 20 duration:0.7];
        SKAction *moveBestScore = [SKAction moveToY:self.size.height/2 + 20 duration:0.9];
        self.moveMenu = [SKAction moveToY:self.size.height/2 + 20 duration:0.5];
        self.bestMenu.size = CGSizeMake(300, 160);
        self.scoreLabel.fontSize = 30;
        self.bestScoreLabel.fontSize = 30;
        self.scoreLabel.position = CGPointMake(62, -10);
        self.bestScoreLabel.position = CGPointMake(240, 0);
        [self.scoreLabel runAction:moveScore];
        [self.bestScoreLabel runAction:moveBestScore];
    }
    
    [self.bestMenu runAction:self.moveMenu];
    
    [self addChild:self.bestMenu];
    [self addChild:self.scoreLabel];
    [self addChild:self.bestScoreLabel];
    
}
- (void)postToFacebook:(id)sender : (UIImage*) image{ // fb post with image
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Facebook" message:@"Posted successfully." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    SLComposeViewController *controller;
    
    controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [controller setInitialText:[NSString stringWithFormat:@"My high score of %@!\n#pigeontap",self.bestScoreLabel.text]];
    [controller addImage:image];
    UIViewController *vc = self.view.window.rootViewController;
    [vc presentViewController:controller animated:YES completion:Nil];
    [controller setCompletionHandler:^(SLComposeViewControllerResult result) {
        
        switch(result) {
            case SLComposeViewControllerResultDone:
                [alert show];
                break;
            default:
                break;
        }
    }];
}

- (void) postToTwitter:(id)sender :(UIImage*)image{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Twitter" message:@"Tweeted successfully." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    SLComposeViewController *tweetSheet;
    tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [tweetSheet setInitialText:[NSString stringWithFormat:@"My high score of %@!\n#pigeontap",self.bestScoreLabel.text]];
    [tweetSheet addImage:image];
    UIViewController *vc = self.view.window.rootViewController;
    [vc presentViewController:tweetSheet animated:YES completion:Nil];
    
    [tweetSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        
        switch(result) {
            case SLComposeViewControllerResultDone:
                [alert show];
                break;
            default:
                break;
        }
    }];
}

-(UIImage*)snapshotUsingDrawHierarchy
{
    // Captures SpriteKit content!
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale);
    [self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:YES];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshotImage;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    if ([self.done containsPoint:location]) {
        NewGameScene *firstScene = [NewGameScene sceneWithSize:self.size];
        [self.view presentScene:firstScene transition:[SKTransition doorsOpenHorizontalWithDuration:2.0]];
    }
    
    if ([self.retry containsPoint:location]) {
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"water" ofType:@"mp3"]];
        self.playerAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        
        [self.playerAudio play];
        GameScene *retryScene= [GameScene sceneWithSize:self.size];
        [self.view presentScene:retryScene transition:[SKTransition doorsOpenHorizontalWithDuration:1.6]];
    }
    
    if([self.fb containsPoint:location]) {
        self.screenshot = [self snapshotUsingDrawHierarchy];
        [self postToFacebook:self :self.screenshot];
    }
    
    if([self.twitter containsPoint:location]) {
        self.screenshot = [self snapshotUsingDrawHierarchy];
        [self postToTwitter:self :self.screenshot];
    }
}




@end
