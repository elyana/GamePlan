//
//  PinnedLocation.h
//  GamePlan
//
//  Created by Jeremy Hintz on 2/28/14.
//  Copyright (c) 2014 Courtney Bohrer. All rights reserved.
//

#import <Parse/Parse.h>

@interface PinnedLocation : PFObject{
    
    PFGeoPoint *_point;
    NSString *_name;
    NSString *_description;
    NSString *_type;
    NSString *_privacy;
}

@property(weak,nonatomic) PFGeoPoint *point;
@property(weak,nonatomic) NSString *name;
@property(weak,nonatomic) NSString *description;
@property(weak,nonatomic) NSString *type;
@property(weak,nonatomic) NSString *privacy;

@end
