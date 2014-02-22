//
//  MapViewController.m
//  GamePlan
//
//  Created by Jeremy Hintz on 2/21/14.
//  Copyright (c) 2014 Jeremy Hintz. All rights reserved.
//

#import "MapViewController.h"
#import "SWRevealViewController.h"

@interface MapViewController ()

@end


//Coordinates of Bob Bullock Museum
#define BB_LAT 30.2804859;
#define BB_LONG -97.7386164;

//Span
#define ZOOM 0.02f;

@implementation MapViewController
@synthesize myMapView;

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
    
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    //Create the region
    MKCoordinateRegion myRegion;
    
    //Center
    CLLocationCoordinate2D center;
    center.latitude = BB_LAT;
    center.longitude = BB_LONG;
    
    //Span
    MKCoordinateSpan span;
    span.latitudeDelta = ZOOM;
    span.longitudeDelta = ZOOM;
    
    myRegion.center = center;
    myRegion.span = span;
    
    //Set mapview
    [myMapView setRegion:myRegion animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
