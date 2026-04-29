//
//  ViewController.m
//  Colleagues
//
//  Created by Thaowpsta Saiid on 20/04/2026.
//

#import "ViewController.h"
#import "Colleague.h"
#import "ColleagueDetails.h"

@interface ViewController ()

@property NSArray *males;
@property NSArray *females;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Colleagues";
        
        Colleague *m1 = [[Colleague alloc] initWithName:@"John Doe" phone:@"0100000000" age:@25 email:@"john@test.com" address:@"Cairo"];
        Colleague *m2 = [[Colleague alloc] initWithName:@"Mark Smith" phone:@"0111111111" age:@30 email:@"mark@test.com" address:@"Alexandria"];
        Colleague *f1 = [[Colleague alloc] initWithName:@"Jane Roe" phone:@"0122222222" age:@28 email:@"jane@test.com" address:@"Giza"];
        
        self.males = @[m1, m2];
        self.females = @[f1];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return self.males.count;
    return self.females.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) return @"Males";
    return @"Females";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Colleague *colleague;
    if (indexPath.section == 0) {
        colleague = self.males[indexPath.row];
    } else {
        colleague = self.females[indexPath.row];
    }
    
    cell.textLabel.text = colleague.name;
    cell.detailTextLabel.text = colleague.phone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Colleague *selectedColleague;
    if (indexPath.section == 0) {
        selectedColleague = self.males[indexPath.row];
    } else {
        selectedColleague = self.females[indexPath.row];
    }
    
    ColleagueDetails *detailsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ColleagueDetails"];
    detailsVC.colleague = selectedColleague;
    
    [self.navigationController pushViewController:detailsVC animated:YES];
}

@end
