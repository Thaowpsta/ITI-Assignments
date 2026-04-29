//
//  CustomAnnotation.h
//  Day6
//
//  Created by Thaowpsta Saiid on 26/04/2026.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomAnnotation : NSObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end

NS_ASSUME_NONNULL_END
