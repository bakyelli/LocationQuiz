//
//  Fact.h
//  LocationQuiz
//
//  Created by Chemin Lin on 10/31/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Location;

@interface Fact : NSManagedObject

@property (nonatomic, retain) NSDate * dateAdded;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSString * soundFilePath;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) Location *location;

@end
