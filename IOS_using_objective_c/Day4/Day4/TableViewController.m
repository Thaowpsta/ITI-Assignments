//
//  TableViewController.m
//  Day4
//
//  Created by Thaowpsta Saiid on 22/04/2026.
//

#import "TableViewController.h"
@import SDWebImage;

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 150;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ImageCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImageCell" forIndexPath:indexPath];
    
    NSInteger imageNumber = indexPath.row + 1;
    NSString *urlString = [NSString stringWithFormat:@"https://yavuzceliker.github.io/sample-images/image-%ld.jpg", (long)imageNumber];
    NSURL *imageUrl = [NSURL URLWithString:urlString];
    
    [cell.imageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cell.textLabel.text = [NSString stringWithFormat:@"Image %ld", (long)imageNumber];
    
    return cell;
}

@end
