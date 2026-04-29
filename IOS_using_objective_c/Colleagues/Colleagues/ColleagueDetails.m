//
//  ColleagueDetails.m
//  Colleagues
//
//  Created by Thaowpsta Saiid on 20/04/2026.
//

#import "ColleagueDetails.h"

@implementation ColleagueDetails

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.colleague.name;
    self.nameLabel.text = [NSString stringWithFormat:@"Name: %@", self.colleague.name];
    self.phoneLabel.text = [NSString stringWithFormat:@"Phone: %@", self.colleague.phone];
    self.ageLabel.text = [NSString stringWithFormat:@"Age: %@", self.colleague.age];
    self.emailLabel.text = [NSString stringWithFormat:@"Email: %@", self.colleague.email];
    self.addressLabel.text = [NSString stringWithFormat:@"Address: %@", self.colleague.address];
}
@end
