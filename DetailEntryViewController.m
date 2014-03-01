//
//  DetailEntryViewController.m
//  GamePlan
//
//  Created by Jeremy Hintz on 3/1/14.
//  Copyright (c) 2014 Courtney Bohrer. All rights reserved.
//

#import "DetailEntryViewController.h"
#import "MapViewController.h"

@interface DetailEntryViewController ()

@end

@implementation DetailEntryViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)removeModal:(UIButton *)sender {
    Tailgate *tg = [Tailgate objectWithClassName:@"Tailgates"];    
    
    NSString *namePassed = [NSString stringWithFormat:@"%@", _name.text];
    NSString *descriptionPassed = [NSString stringWithFormat:@"%@", _description.text];
    
    [tg setObject:namePassed forKey:@"EventName"];
    [tg setObject:descriptionPassed forKey:@"Description"];
    [tg setObject:_location forKey:@"Location"];
    
    [tg saveInBackground];
    
    //[self.navigationController dismissModalViewControllerAnimated:YES];
    
    if(tg!=NULL)
    {
        NSLog(@"foo");
    }

    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
