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

@interface AddLocationViewController ()
@property (strong, nonatomic) Location *newLocation;
@end

@implementation AddLocationViewController

- (Location *)newLocation{
    if (!_newLocation) _newLocation = [[SharedStore returnSharedStore] newLocation];
    return _newLocation;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.longitude.delegate = self;
    self.latitude.delegate = self;
    self.name.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [[SharedStore returnSharedStore] addLocationEntity:self.newLocation];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startRecording:(id)sender {
    NSLog(@"started recording");
}

- (IBAction)longitude:(id)sender {
    self.newLocation.longitude = @([self.longitude.text doubleValue]);
}

- (IBAction)latitude:(id)sender {
    self.newLocation.latitude = @([self.latitude.text doubleValue]);
}

- (IBAction)name:(id)sender {
    self.newLocation.name = self.name.text;
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
