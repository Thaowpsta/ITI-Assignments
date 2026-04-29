//
//  ViewController.m
//  Day5
//
//  Created by Thaowpsta Saiid on 25/04/2026.
//

#import "ViewController.h"
#import "ProductsViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)loadSynchronously:(id)sender {
    NSURL *url = [NSURL URLWithString:@"https://www.yahoo.com"];

    NSString *myData = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    if (myData) {
        [self.webView loadHTMLString:myData baseURL:url];
    }
}

- (IBAction)loadAsynchronously:(id)sender {
    NSURL *url = [NSURL URLWithString:@"https://www.yahoo.com"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
//    [connection start];
}

- (IBAction)goToTask2:(id)sender {
    ProductsViewController *productsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductsVC"];
    
    [self.navigationController pushViewController:productsVC animated:YES];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *htmlString = [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
    
    [self.webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:@"https://www.yahoo.com"]];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failed: %@", [error localizedDescription]);
}

@end
