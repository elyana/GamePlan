//
//  ViewController.m
//  GamePlan
//
//  Created by Jeremy Hintz on 2/21/14.
//  Copyright (c) 2014 Jeremy Hintz. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import <Parse/Parse.h>
#import "ConfirmFBInfoViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Change button colors
    _sidebarButton.tintColor = [UIColor colorWithWhite:1.0f alpha:0.9f];
    _listButton.tintColor = [UIColor colorWithWhite:1.0f alpha:0.9f];
    
    // Set the side bar buttons' action. When it's tapped, it'll the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    _listButton.target = self.revealViewController;
    _listButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];
}


- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}

- (IBAction)loginButtonTouchHandler:(id)sender  {
    // The permissions requested from the user
    NSArray *permissionsArray = @[ @"user_about_me", @"email", @"user_birthday", @"user_location"];
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
//        [_activityIndicator stopAnimating]; // Hide loading indicator
        
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
            }
        } else if (user.isNew) {
            NSLog(@"User with facebook signed up and logged in!");
//            [self.navigationController pushViewController:[[ConfirmFBInfoViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
        } else {
            NSLog(@"User with facebook logged in!");
//            [self.navigationController pushViewController:[[ConfirmFBInfoViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
