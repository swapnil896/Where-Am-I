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
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPress:)];
    longPress.minimumPressDuration = 2;
    [self.myMapView addGestureRecognizer:longPress];
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
    MKCoordinateSpan mySpan = MKCoordinateSpanMake(0.005, 0.005);
    MKCoordinateRegion myRegion = MKCoordinateRegionMake(location.coordinate, mySpan);
    
    [self.myMapView setRegion:myRegion animated:YES];
    
    if(location != nil)
    {
        [myLocation stopUpdatingLocation];
    }
}

- (IBAction)viewMapButton:(id)sender {
    
    [self startDetectingLocation];

}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        MKAnnotationView *pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"myPinView"];
        if(!pinView)
        {
            pinView = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"myPinView"];
            pinView.canShowCallout = YES;
            pinView.image = [UIImage imageNamed:@"placeholder.png"];
            pinView.calloutOffset = CGPointMake(0, 32);
        }
        else
        {
            pinView.annotation = annotation;
        }
        return pinView;
        
    }
    else
    {
        return 0;
    }
}









-(void)handleLongPress: (UILongPressGestureRecognizer *)gesture
{
    CLLocationCoordinate2D pressedCoordinate;
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        CGPoint pressLocation = [gesture locationInView:gesture.view];
        pressedCoordinate = [self.myMapView convertPoint:pressLocation toCoordinateFromView:gesture.view];
        MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc]init];
        myAnnotation.coordinate = pressedCoordinate;
        CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
        CLLocation *location = [[CLLocation alloc]initWithLatitude:pressedCoordinate.latitude longitude:pressedCoordinate.longitude];
        [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if(error)
            {
                myAnnotation.title = @"Unknown Place";
                [self.myMapView addAnnotation:myAnnotation];
            }
            else
            {
                if(placemarks.count > 0)
                {
                    CLPlacemark *myPlaceMark = placemarks.lastObject;
                    NSString *title = [myPlaceMark.subThoroughfare stringByAppendingString:myPlaceMark.thoroughfare];
                    NSString *subTitle =myPlaceMark.locality;
                    myAnnotation.title = title;
                    myAnnotation.subtitle = subTitle;
                    [self.myMapView addAnnotation:myAnnotation];
                    
                }
                else {
                    myAnnotation.title = @"Unknown Place";
                    [self.myMapView addAnnotation:myAnnotation];
                    
                }

                    
                }
        }];
         }
    else if(gesture.state == UIGestureRecognizerStateEnded)
    {
        
    }
}





@end
