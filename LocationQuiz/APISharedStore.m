//
//  APISharedStore.m
//  LocationQuiz
//
//  Created by Joe Burgess on 10/30/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import "APISharedStore.h"
#import "SharedStore.h"
#import <AFNetworking.h>
#import "Location+Methods.h"
#import "Quiz+Methods.h"
#import "Card+Methods.h"


NSString * const BASEURL = @"http://locationquiz-ios000-gryffindor.herokuapp.com/";

@implementation APISharedStore

+ (APISharedStore *)sharedStore {
    static APISharedStore *sharedAPIDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAPIDataStore = [[self alloc] init];
    });
    return sharedAPIDataStore;
}

- (void)getQuizzesWithCompletion:(void (^)(NSArray *))block {
    NSURL *url = [NSURL URLWithString:@"http://locationquiz-ios000.herokuapp.com/quizzes.json"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"%@",JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"%@",error);
    }];
    
    [operation start];
}

#pragma mark - Location API Calls

- (void)removeLocation:(Location *)location {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@locations/%@.json",BASEURL,location.locationID]];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSURLRequest *request = [httpClient requestWithMethod:@"DELETE" path:nil parameters:nil];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation start];
    
}
- (void)getLocationWithID:(NSNumber *)location_id Completion:(void (^)(Location *))block {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@locations/%@.json",BASEURL,location_id]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSDictionary *locationDictionary = (NSDictionary *)JSON;
        
        NSNumber *latitude = [NSNumber numberWithDouble:[locationDictionary[@"latitude"] doubleValue]];
        
        NSNumber *longitude = [NSNumber numberWithDouble:[locationDictionary[@"longitude"] doubleValue]];
        
        Location *location = [[Location alloc] initWithLatitude:latitude longitude:longitude name:locationDictionary[@"name"]];
        location.locationID = [NSNumber numberWithInteger:[locationDictionary[@"id"] integerValue]];
        
        
        block(location);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"%@",error);
    }];
    
    [operation start];
}

- (Location *)ParseLocationFromDictionary:(NSDictionary *)locationDictionary {
    //NSLog(@"loc: %@", locationDictionary);
    NSNumber *latitude = [NSNumber numberWithDouble:[locationDictionary[@"latitude"] doubleValue]];
    
    NSNumber *longitude = [NSNumber numberWithDouble:[locationDictionary[@"longitude"] doubleValue]];
    
    Location *location = [[Location alloc] initWithLatitude:latitude longitude:longitude name:locationDictionary[@"name"]];
    location.locationID = [NSNumber numberWithInteger:[locationDictionary[@"id"] integerValue]];
    return location;
}

- (NSSet *)ParseCardsFromArrayOfDictionaries:(NSArray *)cardsArray forQuiz:(Quiz *)theQuiz
{
    NSMutableSet *cards = [[NSMutableSet alloc]init];
    
    for(NSDictionary *cardDictionary in cardsArray)
    {
        Card *card = [[Card alloc]initWithTitle:cardDictionary[@"title"] andOrder:cardDictionary[@"order"] onQuiz:theQuiz withAttachment:cardDictionary[@"attachment"][@"url"]];
        
        [cards addObject:card];
    }

    return (NSSet *)cards;
}


- (void)getLocationsWithCompletion:(void (^)(NSArray *locations))block {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@locations.json",BASEURL]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSDictionary *locationsDictionary = (NSDictionary *)JSON;
        NSMutableArray *locations = [[NSMutableArray alloc]init];
        //NSLog(@"json: %@, %d", locationsDictionary, [locationsDictionary count]);
        for (NSDictionary *locationDictionary in locationsDictionary) {
            Location *location;
            location = [self ParseLocationFromDictionary:locationDictionary];

            [locations addObject:location];
        }
        block(locations);
        NSLog(@"my array%@", locations);

    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"%@",error);
    }];
    
    [operation start];
}

- (void)getQuizzezWithCompletion:(void (^)(NSArray *quizzes))block {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@quizzes.json",BASEURL]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSLog(@"I entered getQuizzesWithCompletion");

    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        NSLog(@"I started getQuizzesWithCompletion BLOCK");

        
        NSDictionary *quizzesDictionary = (NSDictionary *)JSON;
        NSMutableArray *quizzes = [[NSMutableArray alloc]init];
        for (NSDictionary *quizDictionary in quizzesDictionary) {

            
            NSDictionary *locationDictionary = quizDictionary[@"location"];
            Location *associatedLocation = [self ParseLocationFromDictionary:locationDictionary];
            
            NSLog(@"I parsed location on getQuizzesWithCompletion BLOCK");
            
            NSNumber *quiz_ID = [NSNumber numberWithDouble:[quizDictionary[@"id"] doubleValue]];
            NSString *quizName = quizDictionary[@"name"];
            
            Quiz *quiz = [[Quiz alloc]initWithQuizID:quiz_ID name:quizName];
            quiz.location = associatedLocation;
            
            NSArray *cardsArray = quizDictionary[@"cards"];
            [quiz addCards:[self ParseCardsFromArrayOfDictionaries:cardsArray forQuiz:quiz]];

            [quizzes addObject:quiz];
        }
        block(quizzes);
        NSLog(@"I finished getQuizzesWithCompletion BLOCK");

        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"%@",error);
    }];
    
    [operation start];
    NSLog(@"I started operation");

}




- (void)createLocation:(Location *)newLocation withCompletion: (void (^)(Location* newLocation))block {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@locations.json",BASEURL]];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSString *name = newLocation.name;
    
    NSDictionary *dict = @{@"location[name]":name, @"location[longitude]":newLocation.longitude, @"location[latitude]":newLocation.latitude};
    
    NSURLRequest *request = [httpClient requestWithMethod:@"POST" path:nil parameters:dict];
    
    //    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    //
    //    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
    //        NSLog(@"%@",responseObject);
    //        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //        NSLog(@"Object not created!");
    //
    //    }];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSDictionary *newItemDict = (NSDictionary *)JSON;
        
        newLocation.locationID = [NSNumber numberWithInteger:[newItemDict[@"id"] integerValue]];
        NSLog(@"Location ID of the new location is: %@",newLocation.locationID);
    
        [[SharedStore returnSharedStore] addLocationEntity:newLocation];
        block(newLocation);
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Failed!");
        
    }];
    
    [operation start];
}


- (void)createQuiz:(Quiz *)quiz withCompletion: (void (^)(Quiz *quiz))block {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@quizzes",BASEURL]];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSDictionary *dict = @{@"quiz[location_id]":quiz.location.locationID, @"quiz[name]":quiz.name};
    
    NSURLRequest *request = [httpClient requestWithMethod:@"POST" path:nil parameters:dict];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];

    [operation start];
    
    [[SharedStore returnSharedStore] addQuizEntity:quiz];
}


- (void)createCard:(Card *)card withAudioFile:(NSData *)audioFile withCompletion: (void (^)(Card *card))block{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@cards",BASEURL]];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSDictionary *dict = @{@"card[quiz_id]":card.quiz.quizID, @"card[difficulty]":card.difficulty, @"card[title]":card.title, @"card[order]":card.order};
    
    NSURLRequest *request = [httpClient requestWithMethod:@"POST" path:nil parameters:dict];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation start];
}


@end