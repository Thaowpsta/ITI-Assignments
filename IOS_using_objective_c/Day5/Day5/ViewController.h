//
//  ViewController.h
//  Day5
//
//  Created by Thaowpsta Saiid on 25/04/2026.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface ViewController : UIViewController <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property IBOutlet WKWebView *webView;
@property NSMutableData *responseData;

- (IBAction)loadSynchronously:(id)sender;
- (IBAction)loadAsynchronously:(id)sender;

- (IBAction)goToTask2:(id)sender;
@end

