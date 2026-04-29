//
//  SecondViewController.m
//  Colleagues
//
//  Created by Thaowpsta Saiid on 21/04/2026.
//

#import "SecondViewController.h"

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(goBack)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
}

- (void)goBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
