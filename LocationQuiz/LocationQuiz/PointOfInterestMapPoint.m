//
//  PointOfInterestMapPoint.m
//  LocationQuiz
//
//  Created by Basar Akyelli on 10/10/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import "PointOfInterestMapPoint.h"
@implementation PointOfInterestMapPoint

@synthesize coordinate, title;


-(id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString*)t
{
    self = [super init];
    
    if(self)
    {
        coordinate = c;
        [self setTitle:t];

    }
    return self;
}
@end
