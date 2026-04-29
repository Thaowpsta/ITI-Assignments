//
//  ViewController.h
//  Day6
//
//  Created by Thaowpsta Saiid on 26/04/2026.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property IBOutlet MKMapView *mapView;

@end

