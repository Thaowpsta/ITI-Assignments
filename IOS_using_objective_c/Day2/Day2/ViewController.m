//
//  ViewController.m
//  Day2
//
//  Created by Thaowpsta Saiid on 20/04/2026.
//

#import "ViewController.h"
#import "SecondVC.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)sendButtonPressed:(id)sender {
    SecondVC *destinationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"showSecondVC"];

    destinationVC.nameToDisplay = self.nameTextField.text;
    destinationVC.delegate = self;
    
    [self.nameTextField resignFirstResponder];
    [self.navigationController pushViewController:destinationVC animated:YES];
}

- (void)didFinishViewing {
    [self.navigationController popViewControllerAnimated:YES];
    
    self.nameTextField.text = @"";
}

@end
