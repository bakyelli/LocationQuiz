//
//  AddLocationViewController.h
//  LocationQuiz
//
//  Created by Chemin Lin on 10/24/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
#import <MMDrawerController.h>
#import <CoreLocation/CoreLocation.h>
#import "Quiz+Methods.h"
#import "FSVenue.h"
@interface AddLocationViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *latitude;
@property (weak, nonatomic) IBOutlet UITextField *longitude;

@property (weak, nonatomic) IBOutlet UITextField *name;


- (IBAction)startRecording:(id)sender;
- (IBAction)longitude:(id)sender;
- (IBAction)latitude:(id)sender;
- (IBAction)name:(id)sender;
@property (strong, nonatomic) Quiz *quiz;
- (void) selectVenue:(FSVenue *)selectedVenue;
- (IBAction)cancel:(id)sender;




@end
