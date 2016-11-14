//
//  ViewController.m
//  SWhereAmI
//
//  Created by Mac on 14/11/16.
//  Copyright © 2016 Swapnil Magar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self startDetectingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)startDetectingLocation{
    
    myLocation = [[CLLocationManager alloc]init];
    myLocation.delegate = self;
    [myLocation requestWhenInUseAuthorization];
    [myLocation setDesiredAccuracy:kCLLocationAccuracyBest];
    [myLocation startUpdatingLocation];
    
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    CLLocation *location = locations.lastObject;
    MKCoordinateSpan mySpan = MKCoordinateSpanMake(0.001, 0.001);
    MKCoordinateRegion myRegion = MKCoordinateRegionMake(location.coordinate, mySpan);
    
    [self.myMapView setRegion:myRegion animated:YES];
    
    if(location != nil)
    {
        [myLocation stopUpdatingLocation];
    }
}

@end
