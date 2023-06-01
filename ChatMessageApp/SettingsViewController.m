//
//  SettingsViewController.m
//  ChatMessageApp
//
//  Created by Anshumali Karna on 28/05/23.
//

#import "SettingsViewController.h"
#import <FirebaseAuth/FirebaseAuth.h>
#include "LoginViewController.h"

@interface SettingsViewController ()
@property (nonatomic, strong) IBOutlet UIButton *signOut;
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.signOut = [[UIButton alloc] init];
    self.signOut.frame = CGRectMake(0, 0, 300, 100);
    self.signOut.center = self.view.center;
    self.signOut.backgroundColor = [UIColor blueColor];
    [self.signOut setTitle:@"SignOut" forState:UIControlStateNormal];

    [self.signOut addTarget:self action:@selector(signout: ) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:_signOut];
}


- (IBAction)signout:(id)sender{
    NSError *error;
    BOOL signOutSuccess = [[FIRAuth auth] signOut:&error];

    if (signOutSuccess) {
        // User sign-out successful
        NSLog(@"User signed out successfully");
        self.navigationController.viewControllers = [NSArray arrayWithObject:[[LoginViewController alloc] init]];
    } else {
        // An error occurred during sign-out
        NSLog(@"Error signing out: %@", error);
        
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
