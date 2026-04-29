//
//  ColleagueDetails.h
//  Colleagues
//
//  Created by Thaowpsta Saiid on 20/04/2026.
//

#import <UIKit/UIKit.h>
#import "Colleague.h"

NS_ASSUME_NONNULL_BEGIN

@interface ColleagueDetails : UIViewController
@property Colleague *colleague;
@property IBOutlet UILabel *nameLabel;
@property IBOutlet UILabel *phoneLabel;
@property IBOutlet UILabel *ageLabel;
@property IBOutlet UILabel *emailLabel;
@property IBOutlet UILabel *addressLabel;
@end

NS_ASSUME_NONNULL_END
