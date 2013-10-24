//
//  PointOfInterestMapPoint.h
//  LocationQuiz
//
//  Created by Basar Akyelli on 10/10/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "Location.h"


@interface PointOfInterestMapPoint : NSObject <MKAnnotation>

-(id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString*)t;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSString *interestingFacts;
@property (nonatomic, strong) Location *location;
@property int pointID;
@end
