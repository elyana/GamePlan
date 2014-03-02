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
    
    //Get existing objects
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;

    [self performSelector:@selector(loadPins) withObject:nil afterDelay:0.5];
}

- (void)loadPins
{
    PFQuery *query = [PFQuery queryWithClassName:@"Tailgates"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded. The first 100 objects are available in objects
            NSMutableArray *annotations = [[self.myMapView annotations] mutableCopy];
            
            for (Tailgate *tg in objects) {
                
                BOOL addIt = true;
                // See if it is already added
                for (int i = 0 ; i < annotations.count ; i++) {
                    MapAnnotation *an = (MapAnnotation *)[annotations objectAtIndex:i];
                    
                    if ( an.parseId == tg.objectId ) {
                        addIt = false;
                        
                        [annotations removeObject:an];
                    }
                }
                
                //add it if not already on the map
                if ( addIt ) {
                    PFGeoPoint *pfgp = [tg objectForKey:@"Location"];
                    MapAnnotation *toAdd = [[MapAnnotation alloc]init];
                    toAdd.parseId = tg.objectId;
                    toAdd.coordinate = CLLocationCoordinate2DMake(pfgp.latitude, pfgp.longitude);
                    toAdd.subtitle = [tg objectForKey:@"Description"];
                    toAdd.title = [tg objectForKey:@"EventName"];
                    [self.myMapView addAnnotation:toAdd];
                }
            }
            
            //remove the annotations of inactive tgs
            if ( annotations.count > 0 ) {
                [self.myMapView removeAnnotations:annotations];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
