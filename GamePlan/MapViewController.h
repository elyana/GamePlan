//
//  MapViewController.h
//  GamePlan
//
//  Created by Jeremy Hintz on 2/21/14.
//  Copyright (c) 2014 Jeremy Hintz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MapAnnotation.h"

@interface MapViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *listButton;
@property (strong, nonatomic) IBOutlet MKMapView *myMapView;

- (void)addGestureRecogniserToMapView;
- (void)addPinToMap:(UIGestureRecognizer *)gestureRecognizer;


@end
