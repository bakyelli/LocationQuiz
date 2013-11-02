//
//  APISharedStore.h
//  LocationQuiz
//
//  Created by Joe Burgess on 10/30/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location+Methods.h"
#import "Quiz+Methods.h"
#import "Card+Methods.h"

extern NSString * const BASEURL;

@interface APISharedStore : NSObject

+ (APISharedStore *)sharedStore;

//- (void)getQuizzesWithCompletion:(void (^)(NSArray *quizzes))block;

- (void)getLocationWithID:(NSNumber *)location_id Completion:(void (^)(Location *location))block;

- (void)getLocationsWithCompletion:(void (^)(NSArray *locations))block;

- (void)createLocation:(Location *)newLocation withCompletion: (void (^)(Location* newLocation))block;

- (void)removeLocation:(Location *)location;

- (void)getQuizzezWithCompletion:(void (^)(NSArray *quizzes))block;
-(Quiz *)returnQuizForLocation:(Location *)location;

- (void)createQuiz:(Quiz *)quiz withCompletion: (void (^)(Quiz *quiz))block;

- (void)createCard:(Card *)card withAudioFile:(NSData *)audioFile withCompletion: (void (^)(Card *card))block;

@end