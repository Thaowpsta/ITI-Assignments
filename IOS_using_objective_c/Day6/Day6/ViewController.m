#import "ViewController.h"
#import "CustomAnnotation.h"

@interface ViewController ()

@property NSTimer *simulationTimer;
@property double currentLat;
@property double currentLon;
@property BOOL hasStartedSimulation;
@property BOOL didSetInitialZoom;

@property CLLocationManager *locationMgr;
@property CustomAnnotation *carAnnotation;
@property CustomAnnotation *tappedAnnotation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    
    self.locationMgr = [CLLocationManager new];
    [self.locationMgr setDesiredAccuracy:kCLLocationAccuracyBest];
    [self.locationMgr setDistanceFilter:kCLDistanceFilterNone];
    [self.locationMgr setDelegate:self];
    
    [self.locationMgr requestWhenInUseAuthorization];
    
    [self.locationMgr startUpdatingLocation];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleMapTap:)];
     
    [self.mapView addGestureRecognizer:tapGesture];
}

- (void)handleMapTap:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        CGPoint touchPoint = [sender locationInView:self.mapView];
        
        CLLocationCoordinate2D touchLocation = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
        
        if (self.tappedAnnotation != nil) {
            [self.mapView removeAnnotation:self.tappedAnnotation];
        }
        
        self.tappedAnnotation = [CustomAnnotation new];
        self.tappedAnnotation.coordinate = touchLocation;
        self.tappedAnnotation.title = @"New Annotation";
        
        [self.mapView addAnnotation:self.tappedAnnotation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *currentLocation = [locations lastObject];
    
    if (!self.didSetInitialZoom) {
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, 1000, 1000);
        [self.mapView setRegion:region animated:YES];
        self.didSetInitialZoom = YES;
    }
    
    if (!self.hasStartedSimulation) {
        self.hasStartedSimulation = YES;
        
        self.currentLat = currentLocation.coordinate.latitude;
        self.currentLon = currentLocation.coordinate.longitude;
        
        [self.locationMgr stopUpdatingLocation];
        
        [NSTimer scheduledTimerWithTimeInterval:3.0
                                         target:self
                                       selector:@selector(startDrivingSimulation)
                                       userInfo:nil
                                        repeats:NO];
        
        return;
    }
    
    // Handles the movement once the wait is up
    if (currentLocation.speed > 1.0) {
        self.mapView.showsUserLocation = NO;
        
        if (!self.carAnnotation) {
            self.carAnnotation = [CustomAnnotation new];
            self.carAnnotation.title = @"Driving";
            [self.mapView addAnnotation:self.carAnnotation];
        }
        
        //  Duration is now 0.1 to perfectly match the timer speed
        [UIView animateWithDuration:0.1 animations:^{
            self.carAnnotation.coordinate = currentLocation.coordinate;
        }];
        
        [self.mapView setCenterCoordinate:currentLocation.coordinate animated:YES];
        
    } else {
        self.mapView.showsUserLocation = YES;
        
        if (self.carAnnotation) {
            [self.mapView removeAnnotation:self.carAnnotation];
            self.carAnnotation = nil;
        }
    }
}

- (void)startDrivingSimulation {
    self.simulationTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                            target:self
                                                          selector:@selector(driveCarForward)
                                                          userInfo:nil
                                                           repeats:YES];
}

- (void)driveCarForward {
    self.currentLat += 0.00001;
    self.currentLon += 0.00001;
    
    CLLocationCoordinate2D newCoord = CLLocationCoordinate2DMake(self.currentLat, self.currentLon);
    
    // Create a fake location object
    CLLocation *fakeLocation = [[CLLocation alloc] initWithCoordinate:newCoord
                                                             altitude:0
                                                   horizontalAccuracy:5
                                                     verticalAccuracy:5
                                                               course:45.0
                                                                speed:5.0
                                                            timestamp:[NSDate date]];
    
    [self locationManager:self.locationMgr didUpdateLocations:@[fakeLocation]];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[CustomAnnotation class]]) {
        
        if ([annotation.title isEqualToString:@"Driving"]) {
            
            static NSString *carIdentifier = @"CarAnnotationIdentifier";
            MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:carIdentifier];
            
            if (annotationView == nil) {
                annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:carIdentifier];
                annotationView.canShowCallout = YES;
                annotationView.image = [UIImage imageNamed:@"car"];
            } else {
                annotationView.annotation = annotation;
            }
            return annotationView;
            
        } else {
            
            static NSString *pinIdentifier = @"RedPinIdentifier";
            
            MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pinIdentifier];
            
            if (pinView == nil) {
                pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pinIdentifier];
                pinView.canShowCallout = YES;
                
                pinView.pinTintColor = [MKPinAnnotationView redPinColor];                
            } else {
                pinView.annotation = annotation;
            }
            
            return pinView;
        }
    }
    
    return nil;
}

@end
