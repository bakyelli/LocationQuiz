//
//  AddLocationViewController.m
//  LocationQuiz
//
//  Created by Chemin Lin on 10/24/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import "AddLocationViewController.h"
#import "SharedStore.h"
#import "AddFactViewController.h"
#import <Foursquare2.h>
#import <SVProgressHUD.h>
#import "FSVenue.h"
#import "DrawerTableViewController.h"
#import <UIViewController+MMDrawerController.h>
#import "APISharedStore.h"
#import "Location+Methods.h"

@interface AddLocationViewController ()
@end

@implementation AddLocationViewController

- (Quiz *)quiz {
    if (!_quiz) {
        Location *location = [[Location alloc]initWithLatitude:@0 longitude:@0 name:@""];
        _quiz = [[Quiz alloc] initWithLocation:location];
    }
    return _quiz;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.longitude.delegate = self;
    self.latitude.delegate = self;
    self.name.delegate = self;

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    //This works! ViewDidLoad was too early!
    MMDrawerController *drawerController= self.mm_drawerController;
    DrawerTableViewController *dtvc = (DrawerTableViewController *)[drawerController leftDrawerViewController];
    [dtvc saySomething:@"I'm calling this from the center viewcontroller"];
    //[dtvc.tableView reloadData];

}

- (void)viewWillDisappear:(BOOL)animated{
   // [[SharedStore returnSharedStore] addLocationEntity:self.location];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startRecording:(id)sender {

    
        [self saveQuiz];
   }
- (void) selectVenue:(FSVenue *)selectedVenue;
{
    [self.latitude setText:[NSString stringWithFormat:@"%@",selectedVenue.latitude]];
    [self.longitude setText:[NSString stringWithFormat:@"%@",selectedVenue.longtitude]];
    [self.name setText:selectedVenue.name];


    
}

- (IBAction)cancel:(id)sender {

  [self dismissViewControllerAnimated:YES completion:nil];

}


- (IBAction)longitude:(id)sender {
    self.quiz.location.longitude = @([self.longitude.text doubleValue]);
}

- (IBAction)latitude:(id)sender {
    self.quiz.location.latitude = @([self.latitude.text doubleValue]);
}

- (IBAction)name:(id)sender {
    self.quiz.location.name = self.name.text;
}

- (void)saveQuiz {
    self.quiz.location.name = self.name.text;
    self.quiz.location.longitude = @([self.longitude.text doubleValue]);
    self.quiz.location.latitude = @([self.latitude.text doubleValue]);

    if ((self.quiz.location.longitude) &&
        (self.quiz.location.latitude) &&
        (![self.quiz.location.name isEqualToString:@""])) {
      
        [[APISharedStore sharedStore]createLocation:self.quiz.location withCompletion:^(Location *newLocation) {
            Quiz *newQuiz = [[Quiz alloc]initWithLocation:self.quiz.location];
            [[APISharedStore sharedStore] createQuiz:newQuiz withCompletion:^(Quiz *quiz) {
                NSLog(@"Added quiz.");
    
            }];

        }];

        NSLog(@"Saved quiz! %@", self.quiz.location);
        
        AddFactViewController *adfc = [[AddFactViewController alloc]init];
        
        adfc.quiz = self.quiz;
        [self presentViewController:adfc animated:YES completion:nil];
    }

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
