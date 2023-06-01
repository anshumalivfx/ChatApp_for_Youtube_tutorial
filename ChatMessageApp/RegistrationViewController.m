//
//  RegistrationViewController.m
//  ChatMessageApp
//
//  Created by Anshumali Karna on 27/05/23.
//

#import "RegistrationViewController.h"
#import "LoginViewController.h"
#import <FirebaseAuth/FirebaseAuth.h>
#import <FirebaseDatabase/FirebaseDatabase.h>
@import FirebaseStorage;

@interface RegistrationViewController () <UINavigationControllerDelegate ,UIImagePickerControllerDelegate>

@property (nonatomic, strong) IBOutlet UITextField *emailTextField;
@property (nonatomic, strong) IBOutlet UITextField *usernameTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordTextField;
@property (nonatomic, strong) IBOutlet UITextField *confirmPasswordTextField;
@property (nonatomic, strong) IBOutlet UIButton *profilePictureView;
@property (nonatomic, strong) UIImage *profilePicture;
@property (nonatomic, strong) IBOutlet UIButton *registrationButton;


@property (nonatomic, strong) UIImagePickerController *imagePicker;

@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"Registration";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
    self.emailTextField = [[UITextField alloc] init];
    self.usernameTextField = [[UITextField alloc] init];
    self.passwordTextField = [[UITextField alloc] init];
    self.confirmPasswordTextField = [[UITextField alloc] init];
    self.profilePicture = [UIImage imageNamed:@"avatar"];
    self.registrationButton = [[UIButton alloc] init];
    self.profilePictureView = [[UIButton alloc] init];
    self.emailTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.usernameTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.confirmPasswordTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.registrationButton setTitle:@"Register" forState:UIControlStateNormal];
    self.registrationButton.backgroundColor = UIColor.systemBlueColor;
    self.registrationButton.layer.cornerRadius = 20;
    [self.profilePictureView setImage:self.profilePicture forState:UIControlStateNormal];
    [self.passwordTextField setSecureTextEntry:YES];
    [self.confirmPasswordTextField setSecureTextEntry:YES];
    UIView *block = [[UIView alloc] init];
    //    block.backgroundColor = [UIColor colorWithRed: 0.83 green: 0.77 blue: 0.98 alpha: 1.00];
    block.backgroundColor = UIColor.whiteColor;
    block.layer.cornerRadius = 10;
    block.layer.borderColor = [UIColor redColor].CGColor;
    block.layer.shadowColor = UIColor.blackColor.CGColor;
    block.layer.shadowOpacity = 0.25;
    block.layer.shadowRadius = 3;
    block.layer.shadowOffset = CGSizeMake(1,1);
    [self.emailTextField setPlaceholder:@"Email"];
    [self.usernameTextField setPlaceholder:@"Username"];
    [self.passwordTextField setPlaceholder:@"Password"];
    [self.confirmPasswordTextField setPlaceholder:@"Confirm Password"];
    
    self.profilePictureView.clipsToBounds = YES;
    self.profilePictureView.layer.cornerRadius = 100/2;
    self.profilePictureView.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.profilePictureView.layer.borderWidth = 2;
    self.profilePictureView.layer.borderColor = [UIColor blueColor].CGColor;
    
    [self.profilePictureView addTarget:self action:@selector(uploadPicture: ) forControlEvents:UIControlEventTouchUpInside];
    [self.registrationButton addTarget:self action:@selector(registerUser: ) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:block];
    [block addSubview:self.profilePictureView];
    [block addSubview:self.emailTextField];
    [block addSubview:self.usernameTextField];
    [block addSubview:self.passwordTextField];
    [block addSubview:self.confirmPasswordTextField];
    [block addSubview:self.registrationButton];
    
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    
    block.translatesAutoresizingMaskIntoConstraints = NO;
    self.profilePictureView.translatesAutoresizingMaskIntoConstraints = NO;
    self.emailTextField.translatesAutoresizingMaskIntoConstraints = NO;
    self.usernameTextField.translatesAutoresizingMaskIntoConstraints = NO;
    self.passwordTextField.translatesAutoresizingMaskIntoConstraints = NO;
    self.registrationButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.emailTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.usernameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.passwordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.confirmPasswordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    
    
    [NSLayoutConstraint activateConstraints:@[
        [block.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [block.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:50],
        [block.heightAnchor constraintEqualToConstant:(55*UIScreen.mainScreen.bounds.size.height)/100],
        [block.widthAnchor constraintEqualToConstant:(UIScreen.mainScreen.bounds.size.width - 50)],
        
        [self.profilePictureView.centerXAnchor constraintEqualToAnchor:block.centerXAnchor],
        [self.profilePictureView.topAnchor constraintEqualToAnchor:block.topAnchor constant:-40],
        //        [self.profilePictureView.centerYAnchor constraintEqualToAnchor:block.centerYAnchor constant:block.frame.size.height],
        [self.profilePictureView.heightAnchor constraintEqualToConstant:100],
        [self.profilePictureView.widthAnchor constraintEqualToConstant:100],
        
        [self.emailTextField.centerXAnchor constraintEqualToAnchor:block.centerXAnchor],
        [self.emailTextField.centerYAnchor constraintEqualToAnchor:self.profilePictureView.centerYAnchor constant:75],
        [self.emailTextField.heightAnchor constraintEqualToConstant:44],
        [self.emailTextField.widthAnchor constraintEqualToAnchor:block.widthAnchor constant:-20],
        
        [self.usernameTextField.centerXAnchor constraintEqualToAnchor:block.centerXAnchor],
        [self.usernameTextField.centerYAnchor constraintEqualToAnchor:self.emailTextField.centerYAnchor constant:60],
        [self.usernameTextField.heightAnchor constraintEqualToConstant:44],
        [self.usernameTextField.widthAnchor constraintEqualToAnchor:block.widthAnchor constant:-20],
        
        [self.passwordTextField.centerXAnchor constraintEqualToAnchor:block.centerXAnchor],
        [self.passwordTextField.centerYAnchor constraintEqualToAnchor:self.usernameTextField.centerYAnchor constant:60],
        [self.passwordTextField.heightAnchor constraintEqualToConstant:44],
        [self.passwordTextField.widthAnchor constraintEqualToAnchor:block.widthAnchor constant:-20],
        
        [self.confirmPasswordTextField.centerXAnchor constraintEqualToAnchor:block.centerXAnchor],
        [self.confirmPasswordTextField.centerYAnchor constraintEqualToAnchor:self.passwordTextField.centerYAnchor constant:60],
        [self.confirmPasswordTextField.heightAnchor constraintEqualToConstant:44],
        [self.confirmPasswordTextField.widthAnchor constraintEqualToAnchor:block.widthAnchor constant:-20],
        
        [self.registrationButton.centerXAnchor constraintEqualToAnchor:block.centerXAnchor],
        [self.registrationButton.bottomAnchor constraintEqualToAnchor:block.bottomAnchor constant:-10],
        [self.registrationButton.heightAnchor constraintEqualToConstant:44],
        [self.registrationButton.widthAnchor constraintEqualToConstant:200]
    ]];
    
}


- (IBAction)uploadPicture:(id)sender{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Upload Profile Picture"
                                                                   message:@"Upload Picture from Camera or Library"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cameraButton = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }];
    
    UIAlertAction *photoLibrary = [UIAlertAction actionWithTitle:@"Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }];
    
    [alert addAction:cameraButton];
    [alert addAction:photoLibrary];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)registerUser:(id)sender{
    if ([self.emailTextField.text isEqual: @""] && [self.usernameTextField.text  isEqual: @""] && [self.passwordTextField.text  isEqual: @""] && [self.confirmPasswordTextField.text  isEqual: @""]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Failed!" message:@"Please Fill all the Fields" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        
        if ([self.passwordTextField.text isEqual:self.confirmPasswordTextField.text]){
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
                
                [FIRAuth.auth createUserWithEmail:self.emailTextField.text password:self.passwordTextField.text completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
                    if (error){
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Failed!" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                            [alert dismissViewControllerAnimated:YES completion:nil];
                        }];
                        [alert addAction:action];
                        [self presentViewController:alert animated:YES completion:nil];
                    } else {
                        NSString *uuid = [authResult user].uid;
                        FIRStorage *storage = [FIRStorage storage];
                        FIRStorageReference *storageRef = [storage reference];
                        FIRStorageReference *imageRef = [storageRef child:[NSString stringWithFormat:@"images/%@.jpg", uuid]];
                        
                        NSData *imageData = UIImageJPEGRepresentation(self.profilePicture, 0.8);
                        
                       [imageRef putData:imageData metadata:nil completion:^(FIRStorageMetadata * result, NSError * error) {
                           
                           if (error){
                               UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Failed!" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                               UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                                   [alert dismissViewControllerAnimated:YES completion:nil];
                               }];
                               [alert addAction:action];
                               [self presentViewController:alert animated:YES completion:nil];
                           } else {
                               [imageRef downloadURLWithCompletion:^(NSURL * url, NSError * error) {
                                   if (error){
                                       UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Failed!" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                                       UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                                           [alert dismissViewControllerAnimated:YES completion:nil];
                                       }];
                                       [alert addAction:action];
                                       [self presentViewController:alert animated:YES completion:nil];
                                   } else {
                                       NSString *downloadUrl = url.absoluteString;
                                       FIRDatabaseReference *ref = [[FIRDatabase database] reference];
                                       NSDictionary *user = @{
                                           @"uuid": authResult.user.uid,
                                           @"username": self.usernameTextField.text,
                                           @"email": authResult.user.email,
                                           @"profilePicture": downloadUrl
                                       };
                                       
                                       [[[ref child:@"users"] child:uuid] setValue:user withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
                                           if (error){
                                               UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Failed!" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                                               UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                                                   [alert dismissViewControllerAnimated:YES completion:nil];
                                               }];
                                               [alert addAction:action];
                                               [self presentViewController:alert animated:YES completion:nil];
                                           } else {
                                               UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Success!" message:@"Successfully Registered" preferredStyle:UIAlertControllerStyleAlert];
                                               UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                                                   [alert dismissViewControllerAnimated:YES completion:nil];
                                               }];
                                               [alert addAction:action];
                                               [self presentViewController:alert animated:YES completion:nil];
                                               
                                               
                                           }
                                       }];
                                   }
                               }];
                           }
                           
                            
                        }];
                        [alertController dismissViewControllerAnimated:YES completion:nil];
                        
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    }
                }];
            });
            
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Failed!" message:@"Password does not match" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [alert dismissViewControllerAnimated:YES completion:nil];
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    }
//    [self.navigationController popViewControllerAnimated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.profilePicture = image;
    [self.profilePictureView setImage:image forState:UIControlStateNormal];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

@end
