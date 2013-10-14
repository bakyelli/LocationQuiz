//
//  MapViewController.m
//  LocationQuiz
//
//  Created by Basar Akyelli on 10/10/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import "MapViewController.h"
#import "PointOfInterestMapPoint.h"
#import "LandmarkInfoViewController.h"
#import "listTableViewController.h"
@interface MapViewController ()

@end

@implementation MapViewController


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
    
    UIBarButtonItem *listButton = [[UIBarButtonItem alloc]initWithTitle:@"List" style:UIBarButtonItemStylePlain target:self action:@selector(listBtnPressed:)];
    
    [self.navigationItem setRightBarButtonItem:listButton];
    
    self.title = @"Points of Interest";
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self findLocation];
    
    // Do any additional setup after loading the view.
}
-(void)listBtnPressed:(id)sender
{
    listTableViewController *ltvc = [[listTableViewController alloc]init];
    ltvc.locations = [[self.mapView annotations] mutableCopy];
    
    
    for(int i=0; i<[ltvc.locations count]; i++)
    {
        id<MKAnnotation> annotation = ltvc.locations[i];
        
        if([annotation isKindOfClass:[MKUserLocation class]])
        {
            NSLog(@"Listed my location!");
            [ltvc.locations removeObjectAtIndex:i];
        }
        
    }
    
    [self.navigationController pushViewController:ltvc animated:YES];
    
    
    NSLog(@"List button pressed");
}

-(void)findLocation
{
    [self.locationManager startUpdatingLocation];
    [self addPointsOfInterestOnTheMap];

}
-(void)addPointsOfInterestOnTheMap
{
    
    CLLocationCoordinate2D coordinateTimesSquare = CLLocationCoordinate2DMake(40.7577, -73.9857);
    CLLocationCoordinate2D coordinateMoma = CLLocationCoordinate2DMake(40.761424, -73.977625);
    CLLocationCoordinate2D coordinateToussads = CLLocationCoordinate2DMake(40.757173, -73.988414);
//    
   PointOfInterestMapPoint *pointTimesSquare = [[PointOfInterestMapPoint alloc]initWithCoordinate:coordinateTimesSquare title:@"Times Square"];
    PointOfInterestMapPoint *pointMoma = [[PointOfInterestMapPoint alloc]initWithCoordinate:coordinateMoma title:@"Museum of Modern Art"];
    pointMoma.interestingFacts = @"Interesting facts about MOMA";
    PointOfInterestMapPoint *pointToussads = [[PointOfInterestMapPoint alloc]initWithCoordinate:coordinateToussads title:@"Madame Toussads Museum"];
    
    pointToussads.interestingFacts = @"Interesting facts about Toussads";

    pointTimesSquare.interestingFacts = @"In Times Square, there are approximately 1,500,000 daily passers-by including 344,000 riders in or out of the Times Square subway station.";
    //
   // [self.mapView addAnnotation:pointMoma];
    [self.mapView addAnnotation:pointTimesSquare];
   // [self.mapView addAnnotation:pointToussads];
    
    [self startMonitoringLocationForPointsOfInterest];
    
    
}

-(void) startMonitoringLocationForPointsOfInterest
{
    
    for(int i=0; i<[self.mapView.annotations count]; i++)
    {
        id<MKAnnotation> annotation = [self.mapView.annotations objectAtIndex:i];
        
        if(![annotation isKindOfClass:[MKUserLocation class]])
        {
            PointOfInterestMapPoint *p = (PointOfInterestMapPoint *)annotation;
            CLCircularRegion *regionForMonitoring = [[CLCircularRegion alloc]initWithCenter:p.coordinate radius:200 identifier:p.title];
            
            [self.locationManager startMonitoringForRegion:regionForMonitoring];
        
        }
        
    }
    
}

-(void) locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@"I entered region: %@", region.identifier);
    UILocalNotification *quizNotification = [[UILocalNotification alloc]init];

    quizNotification.fireDate = [NSDate date];
    quizNotification.alertBody = [NSString stringWithFormat:@"You are near %@. Want to take the quiz?",region.identifier];
    quizNotification.alertAction = region.identifier;
    quizNotification.userInfo = @{@"LocationName":region.identifier};
    
    [[UIApplication sharedApplication] scheduleLocalNotification:quizNotification];
    
    
}

#pragma mark Delegate Methods

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    //id <MKAnnotation> annotation = [view annotation];
    
    PointOfInterestMapPoint *mapPoint = [view annotation];
    
    LandmarkInfoViewController *l = [[LandmarkInfoViewController alloc]init];
    l.strLandmarkInterestingFacts = mapPoint.interestingFacts;
    l.strLandmarkName = mapPoint.title;
    
    [self presentViewController:l animated:YES completion:nil];
    
    
    NSLog(@"Title: %@",mapPoint.title);
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{

    if([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;
    }
    else
    {
        // Try to dequeue an existing pin view first.
        MKPinAnnotationView *pinView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"PointOfInterestMapPoint"];
        if (!pinView)
        {
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"PointOfInterestMapPoint"];
            pinView.canShowCallout = YES;
            pinView.pinColor = MKPinAnnotationColorGreen;
            
            UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
            pinView.rightCalloutAccessoryView = rightButton;
            
            UIImageView *iconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loc.png"]];
            pinView.leftCalloutAccessoryView = iconView;
            
            
        } else {
            pinView.annotation = annotation;
        }
        return pinView;
    }
}

#pragma mark Zoom

- (IBAction)zoomToCurrentLocation:(UIBarButtonItem *)sender {
    float spanX = 0.00725;
    float spanY = 0.00725;
    MKCoordinateRegion region;
    region.center.latitude = self.mapView.userLocation.coordinate.latitude;
    region.center.longitude = self.mapView.userLocation.coordinate.longitude;
    region.span.latitudeDelta = spanX;
    region.span.longitudeDelta = spanY;
    [self.mapView setRegion:region animated:YES];
}



#pragma mark LocationManagerDelegate stuff

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    MKCoordinateRegion myLocationRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 1500.0, 1500.0);
    
//    PointOfInterestMapPoint *pointTimesSquare = [[PointOfInterestMapPoint alloc]initWithCoordinate:location.coordinate title:@"THIS IS US"];
//    [self.mapView addAnnotation:pointTimesSquare];

    
    [self.mapView setRegion:myLocationRegion];
    [self.locationManager stopUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
