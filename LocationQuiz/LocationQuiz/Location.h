//
//  Location.h
//  LocationQuiz
//
//  Created by Jay Abdallah on 10/9/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Quiz.h"

@interface Location : NSObject


@property (nonatomic) CLLocationCoordinate2D *coordinates;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) Quiz *quiz;
@property (strong, nonatomic) CLPlacemark *address;




@end
