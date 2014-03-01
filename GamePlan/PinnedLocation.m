//
//  PinnedLocation.m
//  GamePlan
//
//  Created by Jeremy Hintz on 2/28/14.
//  Copyright (c) 2014 Courtney Bohrer. All rights reserved.
//

#import "PinnedLocation.h"

@implementation PinnedLocation

@synthesize point;
@synthesize name;
@synthesize description;
@synthesize type;
@synthesize privacy;

-(void)setPoint:(PFGeoPoint *)geoPoint
{
    _point = geoPoint;
}

@end
