//
//  APISharedStore.h
//  LocationQuiz
//
//  Created by Joe Burgess on 10/30/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"

extern NSString * const BASEURL;

@interface APISharedStore : NSObject

+ (APISharedStore *)sharedStore;

//- (void)getQuizzesWithCompletion:(void (^)(NSArray *quizzes))block;

- (void)getLocationWithID:(NSNumber *)location_id Completion:(void (^)(Location *location))block;

- (void)getLocationsWithCompletion:(void (^)(NSArray *locations))block;

- (void)createLocation:(Location *)newLocation withCompletion: (void (^)(Location* newLocation))block;

- (void)removeLocation:(Location *)location;


@end