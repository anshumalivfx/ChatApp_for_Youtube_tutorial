//
//  ChatsMenuViewController.m
//  ChatMessageApp
//
//  Created by Anshumali Karna on 28/05/23.
//

#import "ChatsMenuViewController.h"
#import <FirebaseAuth/FirebaseAuth.h>
#import <FirebaseDatabase/FirebaseDatabase.h>
#import "ChatMessageApp-Swift.h"

@interface ChatsMenuViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) IBOutlet UITableView *chatsMenu;
@end

@implementation ChatsMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.chatsMenu = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.chatsMenu.delegate = self;
    self.chatsMenu.dataSource = self;
    self.chatsMenu.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:self.chatsMenu];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        // Create a circular image view
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        imageView.layer.cornerRadius = imageView.frame.size.width / 2;
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.tag = 100; // Set a unique tag to retrieve the image view later
        
        [cell.contentView addSubview:imageView];
    }
    
    // Retrieve the circular image view using the tag
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:100];
    imageView.image = [UIImage imageNamed:@"avatar"]; // Set the desired image
    cell.textLabel.text = @"Fuck You";
    cell.textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    [NSLayoutConstraint activateConstraints:@[
        [cell.textLabel.leadingAnchor constraintEqualToAnchor:imageView.trailingAnchor constant:20],
        [cell.textLabel.centerYAnchor constraintEqualToAnchor:imageView.centerYAnchor]
    ]];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatMessageViewController *chatMessageView = [[ChatMessageViewController alloc] init];
    NSArray *cells = [tableView visibleCells];
    UITableViewCell *selectedCell = [cells objectAtIndex:[indexPath item]];
    chatMessageView.view.backgroundColor = UIColor.whiteColor;
    chatMessageView.navigationItem.title = selectedCell.textLabel.text;
    
    [self.navigationController pushViewController:chatMessageView animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}

@end


@interface ChatOption : UIView

@end

@implementation ChatOption



@end
