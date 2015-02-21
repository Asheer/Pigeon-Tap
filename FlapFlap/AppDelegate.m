//
//  AppDelegate.m
//  FlapFlap

#import "AppDelegate.h"
#import "ViewController.h"
#import "iRate.h"
#import "Harpy.h"
#import <AVFoundation/AVFoundation.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

  ViewController *viewController = [[ViewController alloc] init];
  [_window setRootViewController:viewController];

  [_window setBackgroundColor:[UIColor whiteColor]];
  [_window makeKeyAndVisible];
    
    
    // Set the App ID for your app
    [[Harpy sharedInstance] setAppID:@"931045132"];
    
    // (Optional) Set the App Name for your app
    [[Harpy sharedInstance] setAppName:@"Pigeon Tap"];
    
    /* (Optional) Set the Alert Type for your app
     By default, Harpy is configured to use HarpyAlertTypeOption */
    // [[Harpy sharedInstance] setAlertType:<#alert_type#>];
    
    /* (Optional) If your application is not availabe in the U.S. App Store, you must specify the two-letter
     country code for the region in which your applicaiton is available. */
    //[[Harpy sharedInstance] setCountryCode:@"<#country_code#>"];
    
    /* (Optional) Overides system language to predefined language.
     Please use the HarpyLanguage constants defined inHarpy.h. */
    // [[Harpy sharedInstance] setForceLanguageLocalization<#HarpyLanguageConstant#>];
    
    // Perform check for new version of your app
    // [[Harpy sharedInstance] checkVersion];

  return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[Harpy sharedInstance] checkVersionDaily];
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [[AVAudioSession sharedInstance] setActive:NO error:nil];

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{   // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    [[AVAudioSession sharedInstance] setActive:YES error:nil];

}


+ (void)initialize
{
    //configure iRate
    [iRate sharedInstance].previewMode = NO;
    [iRate sharedInstance].appStoreID = 931045132;
    [iRate sharedInstance].daysUntilPrompt = 2;
    [iRate sharedInstance].usesUntilPrompt = 5;
}


@end
