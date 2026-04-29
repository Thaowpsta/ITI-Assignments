//
//  ProductsViewController.m
//  Day5
//
//  Created by Thaowpsta Saiid on 25/04/2026.
//

#import "ProductsViewController.h"

@interface ProductsViewController ()

@end

@implementation ProductsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Task 2: Products";
    
    [self fetchProducts];
}

- (void)fetchProducts {
    NSURL *url = [NSURL URLWithString:@"https://dummyjson.com/products"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//    [connection start];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError *error = nil;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingAllowFragments error:&error];
    
    if (!error) {
        self.productsArray = jsonDict[@"products"];
        [self.tableView reloadData];
    } else {
        NSLog(@"JSON Parsing Error: %@", error.localizedDescription);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.productsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ProductCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSDictionary *product = self.productsArray[indexPath.row];
    cell.textLabel.text = product[@"title"];
    
    NSString *thumbnailUrlString = product[@"thumbnail"];
    NSURL *imageUrl = [NSURL URLWithString:thumbnailUrlString];
    cell.imageView.image = [UIImage systemImageNamed:@"Placeholder"]; 
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
        if (imageData) {
            UIImage *image = [UIImage imageWithData:imageData];
            dispatch_async(dispatch_get_main_queue(), ^{
                UITableViewCell *updateCell = [tableView cellForRowAtIndexPath:indexPath];
                if (updateCell) {
                    updateCell.imageView.image = image;
                    [updateCell setNeedsLayout];
                }
            });
        }
    });
    
    return cell;
}

@end
