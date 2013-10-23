//
//  Quiz.h
//  LocationQuiz
//
//  Created by Jay Abdallah on 10/9/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Card.h"

@interface Quiz : NSObject

@property (strong, nonatomic) NSArray *cards;
@property (strong, nonatomic) CLPlacemark *location;        //From Apple's documentation: A CLPlacemark object stores placemark data for a given latitude and longitude. Placemark data includes information such as the country, state, city, and street address associated with the specified coordinate. It can also include points of interest and geographically related data.
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *finishedUsers;


-(BOOL)isNearCoordinate:(CLLocationCoordinate2D*)coordinate;
-(id)initWithLocation:(CLLocationCoordinate2D*)location andName:(NSString*)name;
-(id)initWithLocation:(CLLocationCoordinate2D *)location;
-(void)moveCardFromIndex:(NSIndexPath*)fromIndexPath toIndex:(NSIndexPath*)toIndexPath;
-(NSNumber*)averageDifficulty;
-(Card*)randomCard;






@end
