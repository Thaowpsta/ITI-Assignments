//
//  SecondVC.h
//  Day2
//
//  Created by Thaowpsta Saiid on 20/04/2026.
//

#import <UIKit/UIKit.h>
#import "ProtocolDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface SecondVC : UIViewController
@property id<ProtocolDelegate> delegate;
@property NSString *nameToDisplay;
@property IBOutlet UILabel *greetingLabel;
@end

NS_ASSUME_NONNULL_END
