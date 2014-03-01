//
//  MapViewController.m
//  GamePlan
//
//  Created by Jeremy Hintz on 2/21/14.
//  Copyright (c) 2014 Jeremy Hintz. All rights reserved.
//

#import "MapViewController.h"
#import "SWRevealViewController.h"
//#import <Parse/Parse.h>
#import "Tailgate.h"
//#import "DetailEntryViewController.h"

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
    [self.myMapView setDelegate:self];
    [self addGestureRecogniserToMapView];
    
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
    _listButton.tintColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    _listButton.target = self.revealViewController;
    _listButton.action = @selector(rightRevealToggle:);
    
    self.dropPinModeOn = NO;
    
    // Set the gesture
    //[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
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

- (void)addGestureRecogniserToMapView{
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(addPinToMap:)];
    lpgr.minimumPressDuration = 0.5; //
    [self.myMapView addGestureRecognizer:lpgr];
    
}

/*
 Called from LongPress Gesture Recogniser, convert Screen X+Y to Longitude and Latitude then add a standard Pin at that Location.
 The pin has its Title and SubTitle set to Placeholder text, you can modify this as you wish, a good idea would be to run a Geocoding block and put the street address in the SubTitle.
 */
- (void)addPinToMap:(UIGestureRecognizer *)gestureRecognizer
{
    
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    
    if(self.dropPinModeOn)
    {
    CGPoint touchPoint = [gestureRecognizer locationInView:self.myMapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.myMapView convertPoint:touchPoint toCoordinateFromView:self.myMapView];
    
    
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:touchMapCoordinate.latitude longitude:touchMapCoordinate.longitude];
    CLLocationCoordinate2D coordinate = [location coordinate];
    _loc = [PFGeoPoint geoPointWithLatitude:coordinate.latitude
                                                  longitude:coordinate.longitude];
        
    [self performSegueWithIdentifier:@"TGDetails" sender:self];
    
    //Bring Tailgate in from Parse here
    
    /*MapAnnotation *toAdd = [[MapAnnotation alloc]init];
    toAdd.coordinate = touchMapCoordinate;
    toAdd.subtitle = description;
    toAdd.title = name;
    
    [self.myMapView addAnnotation:toAdd];*/
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"TGDetails"]){
        DetailEntryViewController *controller = (DetailEntryViewController *)segue.destinationViewController;
        controller.location = _loc;
    }
}

- (IBAction)switchMode:(UIButton *)sender {
    if(self.dropPinModeOn)
    {
        self.dropPinModeOn = NO;
    }
    else
    {
        self.dropPinModeOn = YES;
    }
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
