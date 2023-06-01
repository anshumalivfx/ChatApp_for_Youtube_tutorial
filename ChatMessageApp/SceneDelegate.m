//
//  SceneDelegate.m
//  ChatMessageApp
//
//  Created by Anshumali Karna on 27/05/23.
//

#import "SceneDelegate.h"
#import "LoginViewController.h"
#import "MainViewController.h"
#import <FirebaseAuth/FirebaseAuth.h>

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    UIWindowScene *windowScene = (UIWindowScene *)scene;
        
        
        // Set up your root view controller
    if ([FIRAuth auth].currentUser){
        NSLog(@"Successfull Sign In");
        self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
        MainViewController *rootViewController = [[MainViewController alloc] init];
        UINavigationController *navvc = [[UINavigationController alloc] initWithRootViewController:rootViewController];
        self.window.rootViewController = navvc;
    } else {
        self.window = [[UIWindow alloc] initWithWindowScene:windowScene];

        LoginViewController *rootViewController = [[LoginViewController alloc] init];
        UINavigationController *navvc = [[UINavigationController alloc] initWithRootViewController:rootViewController];
        self.window.rootViewController = navvc;
        
    }
    
    
    
        
        
        
        // Add a UILabel
        
        
    [self.window makeKeyAndVisible];
    
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
