//
//  ViewController.m
//  Day1
//
//  Created by Thaowpsta Saiid on 19/04/2026.
//

#import "ViewController.h"

@interface ViewController ()

@property IBOutlet UILabel *messageLabel;

@property IBOutlet UITextField *inputTextField;
@property IBOutlet UILabel *displayLabel;
@property IBOutlet UILabel *nameLabel;
@property IBOutlet UITextField *inputField;
@property IBOutlet UILabel *resultLabel;
@property NSArray *colleagues;
@property NSInteger currentIndex;

- (IBAction)sayHelloPressed:(UIButton *)sender;

- (IBAction)copyTextPressed:(UIButton *)sender;

- (IBAction)previousPressed:(UIButton *)sender;
- (IBAction)nextPressed:(UIButton *)sender;

- (IBAction)checkIfNumberPressed:(UIButton *)sender;
- (IBAction)checkIfTextPressed:(UIButton *)sender;

@end

@implementation ViewController

//======= Task 1 =======
- (IBAction)sayHelloPressed:(UIButton *)sender {
    self.messageLabel.text = @"Hello World!";
}

//======= Task 2 =======
- (void)loadView {
    [super loadView];
    NSLog(@"VC LifeCycle: loadView (Creating the view)");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"VC LifeCycle: viewDidLoad (View loaded into memory)");
    
    self.colleagues = @[@"Thaowpsta", @"Nardeen", @"Saiid", @"Fady", @"Demiana"];
    self.currentIndex = 0;
    self.nameLabel.text = self.colleagues[self.currentIndex];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"VC LifeCycle: viewWillAppear (View will appear on screen)");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"VC LifeCycle: viewDidAppear (View is now visible)");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"VC LifeCycle: viewWillDisappear (View will be removed or covered)");
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"VC LifeCycle: viewDidDisappear (View is hidden)");
}

//======= Task 3 =======
- (IBAction)copyTextPressed:(UIButton *)sender {
    self.displayLabel.text = self.inputTextField.text;
    
    [self.inputTextField resignFirstResponder];
}

//======= Task 4 =======
- (IBAction)nextPressed:(UIButton *)sender {
    self.currentIndex++;
    
    if (self.currentIndex >= self.colleagues.count) {
        self.currentIndex = 0;
    }
    self.nameLabel.text = self.colleagues[self.currentIndex];
}

- (IBAction)previousPressed:(UIButton *)sender {
    self.currentIndex--;
    
    if (self.currentIndex < 0) {
        self.currentIndex = self.colleagues.count - 1;
    }
    self.nameLabel.text = self.colleagues[self.currentIndex];
}

//======= Task 5 =======
- (IBAction)checkIfNumberPressed:(UIButton *)sender {
    NSString *input = self.inputField.text;
    NSCharacterSet *notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    
    if ([input rangeOfCharacterFromSet:notDigits].location == NSNotFound && input.length > 0) {
        self.resultLabel.text = @"Valid Number";
    } else {
        self.resultLabel.text = @"Not a Number";
    }
}

- (IBAction)checkIfTextPressed:(UIButton *)sender {
    NSString *input = self.inputField.text;
    
    // Allowing spaces
    NSMutableCharacterSet *lettersAndSpaces = [NSMutableCharacterSet letterCharacterSet];
    [lettersAndSpaces addCharactersInString:@" "];
    NSCharacterSet *invalidChars = [lettersAndSpaces invertedSet];
    
    if ([input rangeOfCharacterFromSet:invalidChars].location == NSNotFound && input.length > 0) {
        self.resultLabel.text = @"Valid Text";
    } else {
        self.resultLabel.text = @"Contains Numbers/Symbols";
    }
}

@end
