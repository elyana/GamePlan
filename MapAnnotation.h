//
//  MapAnnotation.h
//  GamePlan
//
//  Created by Jeremy Hintz on 2/25/14.
//  Copyright (c) 2014 Courtney Bohrer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapAnnotation : NSObject <MKAnnotation>{
    
    NSString *title;
    NSString *subtitle;
    CLLocationCoordinate2D coordinate;
}

@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * subtitle;
@property (nonatomic, assign)CLLocationCoordinate2D coordinate;

@end
