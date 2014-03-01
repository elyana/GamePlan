//
//  DetailEntryViewController.h
//  GamePlan
//
//  Created by Jeremy Hintz on 3/1/14.
//  Copyright (c) 2014 Courtney Bohrer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Tailgate.h"

@interface DetailEntryViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *description;
@property (strong, nonatomic) PFGeoPoint *location;

- (IBAction)removeModal:(UIButton *)sender;

@end
