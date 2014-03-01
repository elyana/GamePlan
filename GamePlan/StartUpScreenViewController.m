//
//  StartUpScreenViewController.m
//  GamePlan
//
//  Created by Courtney Bohrer on 2/28/14.
//  Copyright (c) 2014 Courtney Bohrer. All rights reserved.
//

#import "StartUpScreenViewController.h"

@interface StartUpScreenViewController ()

@end

@implementation StartUpScreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self performSelector:@selector(startUpToMap) withObject:nil afterDelay:2.5];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startUpToMap {
    [self performSegueWithIdentifier:@"StartUpToMap" sender:self];
}

@end
