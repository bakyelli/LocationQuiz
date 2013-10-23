//
//  Location.h
//  LocationQuiz
//
//  Created by Basar Akyelli on 10/23/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Fact;

@interface Location : NSManagedObject

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *facts;
@end

@interface Location (CoreDataGeneratedAccessors)

- (void)addFactsObject:(Fact *)value;
- (void)removeFactsObject:(Fact *)value;
- (void)addFacts:(NSSet *)values;
- (void)removeFacts:(NSSet *)values;

@end
