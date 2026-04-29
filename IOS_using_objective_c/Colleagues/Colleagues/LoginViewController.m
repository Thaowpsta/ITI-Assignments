//
//  LoginViewController.m
//  Colleagues
//
//  Created by Thaowpsta Saiid on 21/04/2026.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "SceneDelegate.h"

@implementation LoginViewController

- (IBAction)loginClicked:(id)sender {
    NSString *mail = self.mailTextField.text;
    NSString *password = self.passwordTextField.text;

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *savedMail = [defaults stringForKey:@"savedMail"];
    NSString *savedPassword = [defaults stringForKey:@"savedPassword"];

    if ([mail isEqualToString:savedMail] && [password isEqualToString:savedPassword]) {
        UITabBarController *tabBarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MainTabBarController"];
        
        UIViewController *navController = tabBarVC.viewControllers[0];
        UIViewController *swipeVC = tabBarVC.viewControllers[1];
                
        navController.tabBarItem.title = @"Colleagues";
        navController.tabBarItem.image = [UIImage imageNamed:@"people"];
        
        swipeVC.tabBarItem.title = @"Swipe Lab";
        swipeVC.tabBarItem.image = [UIImage imageNamed:@"swipe"];
        
        UIWindowScene *windowScene = (UIWindowScene *)self.view.window.windowScene;
        SceneDelegate *sceneDelegate = (SceneDelegate *)windowScene.delegate;
        sceneDelegate.window.rootViewController = tabBarVC;
        
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Incorrect Data" message:@"The phone or password you entered is incorrect." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (IBAction)registerClicked:(id)sender {
    RegisterViewController *registerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisterViewController"];
    
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
