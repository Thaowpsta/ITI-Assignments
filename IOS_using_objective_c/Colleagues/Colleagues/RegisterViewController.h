//
//  RegisterViewController.h
//  Colleagues
//
//  Created by Thaowpsta Saiid on 21/04/2026.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RegisterViewController : UIViewController

@property IBOutlet UITextField *mailTextField;
@property IBOutlet UITextField *passwordTextField;

- (IBAction)register:(id)sender;

@end

NS_ASSUME_NONNULL_END
