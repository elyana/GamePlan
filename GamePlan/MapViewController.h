//
//  MapViewController.h
//  GamePlan
//
//  Created by Jeremy Hintz on 2/21/14.
//  Copyright (c) 2014 Jeremy Hintz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>
#import <CoreLocation/CoreLocation.h>
#import "MapAnnotation.h"
#import "DetailEntryViewController.h"
#import "Tailgate.h"
#import "SWRevealViewController.h"

@interface MapViewController : UIViewController <MKMapViewDelegate, SWRevealViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *listButton;
@property (strong, nonatomic) IBOutlet MKMapView *myMapView;
@property (nonatomic) BOOL dropPinModeOn;
@property (nonatomic, strong) PFGeoPoint *loc;

- (void)addGestureRecogniserToMapView;
- (void)addPinToMap:(UIGestureRecognizer *)gestureRecognizer;
- (IBAction)switchMode:(UIButton *)sender;

@end
