//
//  ViewController.m
//  Calculator
//
//  Created by Thaowpsta Saiid on 19/04/2026.
//

#import "ViewController.h"

@interface ViewController ()

@property IBOutlet UILabel *displayLabel;
@property BOOL userIsInTheMiddleOfTyping;
@property double firstOperand;
@property NSString *pendingOperation;
@property NSInteger operationCount;

- (IBAction)digitPressed:(UIButton *)sender;

- (IBAction)operationPressed:(UIButton *)sender;

- (IBAction)calculatePressed:(UIButton *)sender;

- (IBAction)clearPressed:(UIButton *)sender;

- (IBAction)historyPressed:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.displayLabel.text = @"0";
    self.displayLabel.textColor = [UIColor whiteColor];
    
    for (UIView *subview in self.view.subviews) {
            if ([subview isKindOfClass:[UIButton class]]) {
                UIButton *button = (UIButton *)subview;
                
                button.layer.cornerRadius = button.frame.size.height / 2.0;
                button.clipsToBounds = YES;
            }
        }
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = sender.titleLabel.text;
    
    if (self.userIsInTheMiddleOfTyping) {
        if ([digit isEqualToString:@"."] && [self.displayLabel.text containsString:@"."]) {
            return;
        }
        self.displayLabel.text = [self.displayLabel.text stringByAppendingString:digit];
    } else {
        if ([digit isEqualToString:@"."]) {
            self.displayLabel.text = @"0.";
        } else {
            self.displayLabel.text = digit;
        }
        self.userIsInTheMiddleOfTyping = YES;
    }
}

- (IBAction)operationPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfTyping) {
        [self performCalculation];
    }
    
    self.firstOperand = [self.displayLabel.text doubleValue];
    self.pendingOperation = sender.titleLabel.text;
    self.userIsInTheMiddleOfTyping = NO;
}

- (IBAction)calculatePressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfTyping) {
        [self performCalculation];
        self.pendingOperation = nil;
        self.userIsInTheMiddleOfTyping = NO;
    }
}

- (void)performCalculation {
    if (!self.pendingOperation) return;
    
    double secondOperand = [self.displayLabel.text doubleValue];
    double result = 0.0;
    
    if ([self.pendingOperation isEqualToString:@"+"]) {
        result = self.firstOperand + secondOperand;
    } else if ([self.pendingOperation isEqualToString:@"-"]) {
        result = self.firstOperand - secondOperand;
    } else if ([self.pendingOperation isEqualToString:@"x"]) {
        result = self.firstOperand * secondOperand;
    } else if ([self.pendingOperation isEqualToString:@"/"]) {
        if (secondOperand != 0) {
            result = self.firstOperand / secondOperand;
        } else {
            self.displayLabel.text = @"Error";
            return;
        }
    }
    
    if (result == (long)result) {
        self.displayLabel.text = [NSString stringWithFormat:@"%ld", (long)result];
    } else {
        self.displayLabel.text = [NSString stringWithFormat:@"%g", result];
    }
    
    self.firstOperand = result;
    self.operationCount++;
}

- (IBAction)historyPressed:(UIButton *)sender {
    NSLog(@"History: You have made %ld operations.", (long)self.operationCount);
    
    NSString *historyMessage = [NSString stringWithFormat:@"Operations: %ld", (long)self.operationCount];
    self.displayLabel.text = historyMessage;
    self.userIsInTheMiddleOfTyping = NO;
}

- (IBAction)clearPressed:(UIButton *)sender {
    self.displayLabel.text = @"0";
    self.userIsInTheMiddleOfTyping = NO;
    self.firstOperand = 0.0;
    self.pendingOperation = nil;
    self.operationCount = 0;
}

@end
