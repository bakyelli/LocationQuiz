//
//  MapViewController.h
//  LocationQuiz
//
//  Created by Basar Akyelli on 10/10/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface MapViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
-(void)findLocation;
-(void)foundLocation:(CLLocation *)loc; 

@end
