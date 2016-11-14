//
//  ViewController.h
//  SWhereAmI
//
//  Created by Mac on 14/11/16.
//  Copyright © 2016 Swapnil Magar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface ViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>
{
    CLLocationManager *myLocation;
}
@property (weak, nonatomic) IBOutlet MKMapView *myMapView;


@end

