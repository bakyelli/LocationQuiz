//
//  Fact.h
//  LocationQuiz
//
//  Created by Basar Akyelli on 10/23/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Location;

@interface Fact : NSManagedObject

@property (nonatomic, retain) NSString * soundFilePath;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSDate * dateAdded;
@property (nonatomic, retain) Location *location;

@end
