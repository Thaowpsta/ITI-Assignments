//
//  RegisterViewController.m
//  Colleagues
//
//  Created by Thaowpsta Saiid on 21/04/2026.
//

#import "RegisterViewController.h"

@implementation RegisterViewController


- (void)register:(id)sender {
    NSString *mail = self.mailTextField.text;
    NSString *password = self.passwordTextField.text;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:mail forKey:@"savedMail"];
    [defaults setObject:password forKey:@"savedPassword"];
    
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
