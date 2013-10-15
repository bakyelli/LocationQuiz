//
//  LandmarkInfoViewController.h
//  LocationQuiz
//
//  Created by Basar Akyelli on 10/10/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LandmarkInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblLandmarkName;
@property (weak, nonatomic) IBOutlet UILabel *lblLandmarkInterestingFacts;
@property(strong,nonatomic) NSString *strLandmarkName;
@property(strong,nonatomic) NSString *strLandmarkInterestingFacts;
- (IBAction)goBackBtnPressed:(id)sender;

@end
