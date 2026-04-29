//
//  SecondVC.m
//  Day2
//
//  Created by Thaowpsta Saiid on 20/04/2026.
//

#import "SecondVC.h"

@implementation SecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.greetingLabel.text = [NSString stringWithFormat:@"Hello %@", self.nameToDisplay];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(donePressed:)];
    
    self.navigationItem.rightBarButtonItem = doneButton;
}

- (void)donePressed:(id)sender {
    [self.delegate didFinishViewing];
}
@end
