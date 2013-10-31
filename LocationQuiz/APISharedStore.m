//
//  APISharedStore.m
//  LocationQuiz
//
//  Created by Joe Burgess on 10/30/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import "APISharedStore.h"
#import <AFNetworking.h>
#import "Location+Methods.h"
#import "SharedStore.h"

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

- (void)getLocationsWithCompletion:(void (^)(NSArray *locations))block {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@locations.json",BASEURL]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSDictionary *locationsDictionary = (NSDictionary *)JSON;
        NSMutableArray *locations = [[NSMutableArray alloc]init];
        for (NSDictionary *locationDictionary in locationsDictionary) {
            NSNumber *latitude = [NSNumber numberWithDouble:[locationDictionary[@"latitude"] doubleValue]];
            NSNumber *longitude = [NSNumber numberWithDouble:[locationDictionary[@"longitude"] doubleValue]];
            Location *location = [[Location alloc] initWithLatitude:latitude longitude:longitude name:locationDictionary[@"name"]];
                location.locationID = [NSNumber numberWithInteger:[locationDictionary[@"id"] integerValue]];

            [locations addObject:location];
        }
        block(locations);

    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"%@",error);
    }];
    
    [operation start];
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

    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Failed!");
    
    }];
                                         
    [operation start];
}


@end