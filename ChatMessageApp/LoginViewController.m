//
//  ViewController.m
//  ChatMessageApp
//
//  Created by Anshumali Karna on 27/05/23.
//

#import "LoginViewController.h"
#import "RegistrationViewController.h"
#import <FirebaseAuth/FirebaseAuth.h>
#include "MainViewController.h"

@interface LoginViewController ()
@property (nonatomic, strong) IBOutlet UIButton *loginButton;
@property (nonatomic, strong) IBOutlet UITextField *emailTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordTextField;
@property (nonatomic, strong) IBOutlet UIButton *goToRegistrationButton;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.goToRegistrationButton = [[UIButton alloc] init];
    self.loginButton = [[UIButton alloc] init];
    self.emailTextField = [[UITextField alloc] init];
    self.passwordTextField = [[UITextField alloc] init];
    [self.emailTextField setPlaceholder:@"Email"];
    self.passwordTextField.placeholder = @"Password";
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.emailTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.navigationItem.title = @"Login";
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    self.loginButton.backgroundColor = UIColor.systemBlueColor;
    [self.loginButton setTitle:@"Login" forState:UIControlStateNormal];
    self.loginButton.layer.cornerRadius = 20;
    [self.loginButton setUserInteractionEnabled:YES];
    [self.loginButton addTarget:self action:@selector(loginSelected: ) forControlEvents:UIControlEventTouchUpInside];
    
    self.emailTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.passwordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    [self.goToRegistrationButton setTitle:@"Not a User? Register Here" forState:UIControlStateNormal];
    [self.goToRegistrationButton setTitleColor:UIColor.systemBlueColor forState:UIControlStateNormal];
    [self.goToRegistrationButton addTarget:self action:@selector(registrationPage: ) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.emailTextField];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.goToRegistrationButton];
    
    self.passwordTextField.translatesAutoresizingMaskIntoConstraints = NO;
    self.emailTextField.translatesAutoresizingMaskIntoConstraints = NO;
    self.loginButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.goToRegistrationButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.emailTextField.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.emailTextField.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:-100],
        [self.emailTextField.heightAnchor constraintEqualToConstant:44],
        [self.emailTextField.widthAnchor constraintEqualToConstant:UIScreen.mainScreen.bounds.size.width - 50],
        
        [self.passwordTextField.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.passwordTextField.centerYAnchor constraintEqualToAnchor:self.emailTextField.centerYAnchor constant:60],
        [self.passwordTextField.heightAnchor constraintEqualToConstant:44],
        [self.passwordTextField.widthAnchor constraintEqualToConstant:UIScreen.mainScreen.bounds.size.width - 50],
        
        [self.loginButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.loginButton.centerYAnchor constraintEqualToAnchor:self.passwordTextField.centerYAnchor constant:60],
        [self.loginButton.heightAnchor constraintEqualToConstant:44],
        [self.loginButton.widthAnchor constraintEqualToConstant:200],
        
        [self.goToRegistrationButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.goToRegistrationButton.centerYAnchor constraintEqualToAnchor:self.loginButton.centerYAnchor constant:100],
        [self.goToRegistrationButton.heightAnchor constraintEqualToConstant:44],
        [self.goToRegistrationButton.widthAnchor constraintEqualToConstant:UIScreen.mainScreen.bounds.size.width - 50],
    ]];
}


- (IBAction)loginSelected:(id)sender{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        // Create a spinner progress view
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
        spinner.translatesAutoresizingMaskIntoConstraints = NO;
        [spinner startAnimating];
        
        // Add the spinner to the alert controller
        [alertController.view addSubview:spinner];
        
        // Center the spinner within the alert controller's view
        [spinner.centerXAnchor constraintEqualToAnchor:alertController.view.centerXAnchor].active = YES;
        [spinner.centerYAnchor constraintEqualToAnchor:alertController.view.centerYAnchor].active = YES;
        
        // Present the alert controller
        [self presentViewController:alertController animated:YES completion:nil];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // Code to be executed after the delay
        if ([self.emailTextField.text isEqual:@""] && [self.emailTextField.text isEqual:@""]){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Failed!" message:@"Please Fill all the Fields" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [alert dismissViewControllerAnimated:YES completion:nil];
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            [FIRAuth.auth signInWithEmail:self.emailTextField.text password:self.passwordTextField.text completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
                if (error){
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Failed!" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                        [alert dismissViewControllerAnimated:YES completion:nil];
                    }];
                    [alert addAction:action];
                    [self presentViewController:alert animated:YES completion:nil];
                } else {
                    NSLog(@"Success");
                    self.navigationController.viewControllers = [NSArray arrayWithObject:[[MainViewController alloc] init]];
                }
            }];
            
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }
        
        
        
    });
    
}

- (IBAction)registrationPage:(id)sender{
    RegistrationViewController *regvc = [[RegistrationViewController alloc] init];
    [self.navigationController pushViewController:regvc animated:YES];
}

@end
