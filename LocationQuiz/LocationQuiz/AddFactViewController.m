//
//  AddFactViewController.m
//  LocationQuiz
//
//  Created by Basar Akyelli on 10/24/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import "AddFactViewController.h"

@interface AddFactViewController ()
{
    AVAudioRecorder *recorder;
    AVAudioPlayer *player;
}

@end

@implementation AddFactViewController

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
    
    NSString *fileName = @"MyAudioMemo.m4a";
    NSArray *pathComponents = [NSArray arrayWithObjects:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject], fileName,nil];
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    
    AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,sizeof (audioRouteOverride),&audioRouteOverride);


    
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc]init];
    
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
    
    recorder = [[AVAudioRecorder alloc]initWithURL:outputFileURL settings:recordSetting error:nil];
    recorder.delegate = self;
    recorder.meteringEnabled = YES;
    [recorder prepareToRecord];
    
    [self.lblMessage setText:@"Ready to record..."];



}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)recButtonAction:(id)sender {

    if(player.playing)
    {
        [player stop];
        [self.lblMessage setText:@"Ready to record..."];

    }
    
    if(!recorder.recording)
    {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        
        [recorder record];
        [self.recBtn setTitle:@"STOP" forState:UIControlStateNormal];
        [self.lblMessage setText:@"Recording..."];

        
    } else{
        [recorder stop];
        [self.recBtn setTitle:@"REC" forState:UIControlStateNormal];
        
        AVAudioSession *audioSesson = [AVAudioSession sharedInstance];
        [audioSesson setActive:NO error:nil];
    }
}

- (IBAction)playBtnPressed:(id)sender {
    if(!recorder.recording)
    {
        player = [[AVAudioPlayer alloc]initWithContentsOfURL:recorder.url error:nil];
        
        [player setDelegate:self];
        [player play];
    }
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self.lblMessage setText:@"Ready to record..."];

}

-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    [self.recBtn setTitle:@"REC" forState:UIControlStateNormal];
    [self.lblMessage setText:@"Ready to play!"];
}
@end
