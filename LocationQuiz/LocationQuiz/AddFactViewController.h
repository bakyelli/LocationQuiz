//
//  AddFactViewController.h
//  LocationQuiz
//
//  Created by Basar Akyelli on 10/24/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Location.h"
@interface AddFactViewController : UIViewController <AVAudioRecorderDelegate, AVAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *recBtn;
- (IBAction)recButtonAction:(id)sender;
- (IBAction)playBtnPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (strong, nonatomic) Location *location;

@end
