//
//  DrawerTableViewController.h
//  LocationQuiz
//
//  Created by Chemin Lin on 10/25/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface DrawerTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *venues;
@property (strong, nonatomic) CLLocation *currentLocation;
-(void) saySomething:(NSString *)thing;

@end
