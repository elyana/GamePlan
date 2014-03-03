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
#import "MapViewController.h"

@interface MainViewController ()
@property (nonatomic) IBOutlet MapViewController *mapVC;
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
    //[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}


- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;

    NSLog(@"View will appear");
}

- (IBAction)loginButtonTouchHandler:(id)sender  {
    // The permissions requested from the user
    NSArray *permissionsArray = @[ @"user_about_me", @"email", @"user_birthday", @"user_location"];
    [self dismissViewControllerAnimated:NO completion:nil];

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
            //[self dismissViewControllerAnimated:NO completion:nil];
            // Create request for user's Facebook data
            FBRequest *request1 = [FBRequest requestForMe];
            FBRequest *request2 = [FBRequest requestForMyFriends];
            
            
            
            // Send request to Facebook
            [request1 startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                if (!error) {
                    // result is a dictionary with the user's Facebook data
                    NSDictionary *userData = (NSDictionary *)result;
                    
                    //get facebook id and pic URL
                    NSString *facebookID = userData[@"id"];
                    NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
                    
                    
                    //create user profile
                    NSMutableDictionary *userProfile = [NSMutableDictionary dictionaryWithCapacity:7];
                    
                    if (facebookID) {
                        userProfile[@"facebookId"] = facebookID;
                    }
                    
                    if (userData[@"name"]) {
                        userProfile[@"name"] = userData[@"name"];
                    }
                    
                    if (userData[@"location"][@"name"]) {
                        userProfile[@"location"] = userData[@"location"][@"name"];
                    }
                    
                    if (userData[@"gender"]) {
                        userProfile[@"gender"] = userData[@"gender"];
                    }
                    
                    if (userData[@"birthday"]) {
                        userProfile[@"birthday"] = userData[@"birthday"];
                    }
                    
                    if (userData[@"email"]) {
                        userProfile[@"email"] = userData[@"email"];
                    }
                    
                    if ([pictureURL absoluteString]) {
                        userProfile[@"pictureURL"] = [pictureURL absoluteString];
                    }
                    
                    [[PFUser currentUser] setObject:userProfile forKey:@"profile"];
                    [[PFUser currentUser] saveInBackground];
                    
                }
            }];
            
            // Send request to Facebook
            [request2 startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                if (!error) {
                    NSArray *friendObjects = [result objectForKey:@"data"];
                    [[PFUser currentUser] setObject:friendObjects forKey:@"friends"];
                    [[PFUser currentUser] saveInBackground];
                }
            }];

            
        } else {
            NSLog(@"User with facebook logged in!");
            //[self dismissViewControllerAnimated:NO completion:nil];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
