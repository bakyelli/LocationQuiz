//
//  DrawTableViewController.m
//  LocationQuiz
//
//  Created by Chemin Lin on 10/25/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import "DrawerTableViewController.h"
#import "FSVenue.h"
#import <Foursquare2.h>
#import <SVProgressHUD.h>

@interface DrawerTableViewController ()

@end

@implementation DrawerTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self populateFoursquareVenues];
    
    
	// Do any additional setup after loading the view.
}

- (void)populateFoursquareVenues {
    NSLog(@"Calling Foursquare!");
    [Foursquare2 venueSearchNearByLatitude:@(self.currentLocation.coordinate.latitude)
                                 longitude:@(self.currentLocation.coordinate.longitude)
                                     query:nil
                                     limit:nil
                                    intent:intentCheckin
                                    radius:@500
                                categoryId:nil
                                  callback:^(BOOL success, id result){
                                      if (success) {
                                          NSDictionary *resultDict = result;
                                          NSArray *venues = [FSVenue convertToVenues:resultDict[@"response"][@"venues"]];
                                          self.venues = venues;
                                          [self.tableView reloadData];
                                          
                                      }
                                      [SVProgressHUD dismiss];
                                      
                                  }];
    
    [SVProgressHUD show];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"TableView delegate methods run!");
    if (self.venues) {
        return [self.venues count];
    }
    else return 0;
}
-(void) saySomething:(NSString *)thing
{
    NSLog(@"%@",thing);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.venues) {
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"venueCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"venueCell"];
        }
        FSVenue *venue = [self.venues objectAtIndex:indexPath.row];
        cell.textLabel.text = venue.name;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d meters",[venue.distance intValue]];
        
        return cell;
    }
    else {
        return nil;
    }
}
@end
