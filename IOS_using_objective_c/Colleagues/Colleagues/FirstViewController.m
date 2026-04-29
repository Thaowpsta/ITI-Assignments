//
//  FirstViewController.m
//  Colleagues
//
//  Created by Thaowpsta Saiid on 21/04/2026.
//

#import "FirstViewController.h"
#import "SecondViewController.h"

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(goToNext)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
}

- (void)goToNext {
    SecondViewController *secondVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondViewController"];
    secondVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:secondVC animated:YES completion:nil];
}
@end
