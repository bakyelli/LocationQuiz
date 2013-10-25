//
//  AddLocationViewController.m
//  LocationQuiz
//
//  Created by Chemin Lin on 10/24/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import "AddLocationViewController.h"
#import "Location.h"
#import "SharedStore.h"
#import "AddFactViewController.h"
#import <Foursquare2.h>
#import <SVProgressHUD.h>
#import "FSVenue.h"
#import "DrawerTableViewController.h"

@interface AddLocationViewController ()
@end

@implementation AddLocationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.longitude.delegate = self;
    self.latitude.delegate = self;
    self.name.delegate = self;
    [self populateFoursquareVenues];
}

- (void)viewWillDisappear:(BOOL)animated{
    [[SharedStore returnSharedStore] addLocationEntity:self.location];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startRecording:(id)sender {
    
    AddFactViewController *adfc = [[AddFactViewController alloc]init];
    
    adfc.location = self.location;
    
    [self.navigationController pushViewController:adfc animated:YES];
    

}

- (IBAction)longitude:(id)sender {
    self.location.longitude = @([self.longitude.text doubleValue]);
}

- (IBAction)latitude:(id)sender {
    self.location.latitude = @([self.latitude.text doubleValue]);
}

- (IBAction)name:(id)sender {
    self.location.name = self.name.text;
}

- (void)populateFoursquareVenues {
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
                                          NSLog(@"%@", venues);
                                          DrawerTableViewController *dtvc = (DrawerTableViewController *)self.drawerController.leftDrawerViewController;
                                          dtvc.venues = venues;
                                      }
                                      [SVProgressHUD dismiss];
        
                                  }];
    
    [SVProgressHUD show];

}

#pragma textfield delegates

- (BOOL) textFieldShouldEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
