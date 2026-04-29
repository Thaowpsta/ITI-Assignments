//
//  LoginViewController.h
//  Colleagues
//
//  Created by Thaowpsta Saiid on 21/04/2026.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController

@property IBOutlet UITextField *mailTextField;
@property IBOutlet UITextField *passwordTextField;

- (IBAction)loginClicked:(id)sender;
- (IBAction)registerClicked:(id)sender;

@end

NS_ASSUME_NONNULL_END
