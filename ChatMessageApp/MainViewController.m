//
//  MainViewController.m
//  ChatMessageApp
//
//  Created by Anshumali Karna on 28/05/23.
//

#import "MainViewController.h"
#import <FirebaseAuth/FirebaseAuth.h>
#include "LoginViewController.h"
#include "SettingsViewController.h"
#include "ChatsMenuViewController.h"

@interface MainViewController () <UITabBarDelegate>
@property (nonatomic, strong) IBOutlet UIButton *signOut;
@property (nonatomic, strong) IBOutlet UIButton *convoButton;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.convoButton = [[UIButton alloc] init];
    [self.convoButton setImage:[UIImage systemImageNamed:@"square.and.pencil"] forState:UIControlStateNormal];
    
    [self.convoButton addTarget:self action:@selector(newConvo: ) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barConvoButton = [[UIBarButtonItem alloc] initWithCustomView:self.convoButton];
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"Chats";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
    
    [self.navigationItem setRightBarButtonItem:barConvoButton];
    ChatsMenuViewController *chatsMenu = [[ChatsMenuViewController alloc] init];
    SettingsViewController *settings = [[SettingsViewController alloc] init];

    
    chatsMenu.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Chats" image:[UIImage systemImageNamed:@"message"] tag:0];
    settings.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Settings" image:[UIImage systemImageNamed:@"gear"] tag:1];
    NSArray *viewControllers = @[chatsMenu, settings];
    UITabBarAppearance *appearance = [[UITabBarAppearance alloc] init];
    [appearance configureWithOpaqueBackground];
    [appearance setBackgroundColor:UIColor.whiteColor];
    self.viewControllers = viewControllers;
    self.tabBar.standardAppearance = appearance;
    self.tabBar.scrollEdgeAppearance = self.tabBar.standardAppearance;
    
    self.tabBarController.tabBar.delegate = self;
    //    self.tabBarController.tabBar.barTintColor = UIColor.redColor;
    //    self.tabBar.tintColor = [UIColor systemBlueColor];
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if (item.tag == 0){
        self.navigationItem.title = @"Chats";
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
    }
    else if (item.tag == 1){
        self.navigationItem.title = @"Settings";
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
    }
}



- (IBAction)newConvo:(id)sender{
    NSLog(@"Hello");
}


@end


