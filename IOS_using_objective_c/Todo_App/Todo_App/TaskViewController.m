//
//  TaskViewController.m
//  Todo_App
//
//  Created by Thaowpsta Saiid on 27/04/2026.
//

#import <UserNotifications/UserNotifications.h>
#import "TaskViewController.h"
#import "EditTaskViewController.h"
#import "TaskManager.h"
#import "Task.h"

@interface TaskViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *filterSegment;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSArray *filteredTasks;
@property (strong, nonatomic) NSArray *highPriorityTasks;
@property (strong, nonatomic) NSArray *medPriorityTasks;
@property (strong, nonatomic) NSArray *lowPriorityTasks;
@end

@implementation TaskViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self filterTasks];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)addTaskTapped:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    EditTaskViewController *editVC = [storyboard instantiateViewControllerWithIdentifier:@"EditTaskViewController"];
    
    editVC.isEditingMode = NO;
    
    [self.navigationController pushViewController:editVC animated:YES];
}

-(IBAction)segmentChanged:(UISegmentedControl *)sender {
    [self filterTasks];
}

- (void)filterTasks {
    NSArray *allTasks = [[TaskManager sharedManager] getAllTasks];
    NSString *searchText = [self.searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    // Segment Mapping: 0 = All, 1 = To-Do, 2 = In Progress, 3 = Done, 4 = Priority
    NSInteger selectedSegment = self.filterSegment.selectedSegmentIndex;
    
    NSMutableArray *tempTasks = [NSMutableArray array];
    
    //    for (NSDictionary *task in allTasks) {
    //        BOOL matchesSearch = searchText.length == 0 || [task[@"name"] localizedCaseInsensitiveContainsString:searchText];
    //        BOOL matchesSegment = YES;
    //
    //        if (selectedSegment == 1 && [task[@"status"] integerValue] != 0) matchesSegment = NO; // To-Do
    //        if (selectedSegment == 2 && [task[@"status"] integerValue] != 1) matchesSegment = NO; // In Progress
    //        if (selectedSegment == 3 && [task[@"status"] integerValue] != 2) matchesSegment = NO; // Done
    //
    //        if (matchesSearch && matchesSegment) {
    //            [tempTasks addObject:task];
    //        }
    //    }
    
    for (Task *task in allTasks) {
        BOOL matchesSearch = searchText.length == 0 || [task.name localizedCaseInsensitiveContainsString:searchText];
        BOOL matchesSegment = YES;
        
        if (selectedSegment == 1 && task.status != 0) matchesSegment = NO; // To-Do
        if (selectedSegment == 2 && task.status != 1) matchesSegment = NO; // In Progress
        if (selectedSegment == 3 && task.status != 2) matchesSegment = NO; // Done
        
        if (matchesSearch && matchesSegment) {
            [tempTasks addObject:task];
        }
    }
    
    if (selectedSegment == 4) {
        NSMutableArray *high = [NSMutableArray array];
        NSMutableArray *med = [NSMutableArray array];
        NSMutableArray *low = [NSMutableArray array];
        
        for (Task *task in tempTasks) {
            //            NSInteger p = [task[@"priority"] integerValue];
            NSInteger p = task.priority;
            if (p == 0) [high addObject:task];
            else if (p == 1) [med addObject:task];
            else [low addObject:task];
        }
        self.highPriorityTasks = high;
        self.medPriorityTasks = med;
        self.lowPriorityTasks = low;
    }
    
    self.filteredTasks = tempTasks;
    [self.tableView reloadData];
    
    if (self.filteredTasks.count == 0) {
        UILabel *emptyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, self.tableView.bounds.size.height)];
        emptyLabel.text = (searchText.length > 0) ? [NSString stringWithFormat:@"No results for \"%@\"", searchText] : @"No tasks here yet!";
        emptyLabel.textColor = [UIColor systemGrayColor];
        emptyLabel.textAlignment = NSTextAlignmentCenter;
        emptyLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
        emptyLabel.numberOfLines = 0;
        
        self.tableView.backgroundView = emptyLabel;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    } else {
        self.tableView.backgroundView = nil;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self filterTasks];
}

- (Task *)taskAtIndexPath:(NSIndexPath *)indexPath {
    if (self.filterSegment.selectedSegmentIndex == 4) {
        if (indexPath.section == 0) return self.highPriorityTasks[indexPath.row];
        if (indexPath.section == 1) return self.medPriorityTasks[indexPath.row];
        return self.lowPriorityTasks[indexPath.row];
    }
    return self.filteredTasks[indexPath.row];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return (self.filterSegment.selectedSegmentIndex == 4) ? 3 : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.filterSegment.selectedSegmentIndex == 4) {
        if (section == 0) return self.highPriorityTasks.count;
        if (section == 1) return self.medPriorityTasks.count;
        return self.lowPriorityTasks.count;
    }
    return self.filteredTasks.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.filterSegment.selectedSegmentIndex == 4) {
        if (section == 0 && self.highPriorityTasks.count > 0) return @"High Priority";
        if (section == 1 && self.medPriorityTasks.count > 0) return @"Medium Priority";
        if (section == 2 && self.lowPriorityTasks.count > 0) return @"Low Priority";
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell"];
    
    Task *task = [self taskAtIndexPath:indexPath];
    
    cell.textLabel.text = task.name;
    //    NSDate *date = task.lastUpdatedDate ?: task.creationDate;
    //
    //    if (date) {
    //        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //        formatter.dateStyle = NSDateFormatterMediumStyle;
    //        formatter.timeStyle = NSDateFormatterShortStyle;
    //        cell.detailTextLabel.text = [NSString stringWithFormat:@"Updated: %@", [formatter stringFromDate:date]];
    //        cell.detailTextLabel.textColor = [UIColor systemGrayColor];
    //    }
    
    NSInteger priority = task.priority;
    if (priority == 0) {
        cell.imageView.image = [UIImage imageNamed:@"high_priority.png"];
    } else if (priority == 1) {
        cell.imageView.image = [UIImage imageNamed:@"med_priority.png"];
    } else {
        cell.imageView.image = [UIImage imageNamed:@"low_priority.png"];
    }
    
    cell.imageView.userInteractionEnabled = YES;
    for (UIGestureRecognizer *recognizer in cell.imageView.gestureRecognizers) {
        [cell.imageView removeGestureRecognizer:recognizer];
    }
    UITapGestureRecognizer *priorityTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(priorityImageTapped:)];
    [cell.imageView addGestureRecognizer:priorityTap];
    
    UIButton *statusButton = [UIButton buttonWithType:UIButtonTypeSystem];
    statusButton.frame = CGRectMake(0, 0, 95, 26);
    statusButton.layer.cornerRadius = 13;
    statusButton.clipsToBounds = YES;
    statusButton.titleLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightBold];
    [statusButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    NSInteger status = task.status;
    NSMutableArray *menuActions = [NSMutableArray array];
    
    if (status == 0) {
        [statusButton setTitle:@"TO-DO" forState:UIControlStateNormal];
        statusButton.backgroundColor = [UIColor systemGrayColor];
        
        UIAction *inProgress = [UIAction actionWithTitle:@"Mark In Progress" image:nil identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
            [self updateTask:task toNewStatus:1];
        }];
        UIAction *done = [UIAction actionWithTitle:@"Mark Done" image:nil identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
            [self updateTask:task toNewStatus:2];
        }];
        [menuActions addObjectsFromArray:@[inProgress, done]];
        
    } else if (status == 1) {
        [statusButton setTitle:@"IN PROGRESS" forState:UIControlStateNormal];
        statusButton.backgroundColor = [UIColor systemCyanColor];
        
        UIAction *done = [UIAction actionWithTitle:@"Mark Done" image:nil identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
            [self updateTask:task toNewStatus:2];
        }];
        [menuActions addObject:done];
        
    } else {
        [statusButton setTitle:@"DONE" forState:UIControlStateNormal];
        statusButton.backgroundColor = [UIColor systemGreenColor];
        
        statusButton.userInteractionEnabled = NO;
        
        UIAction *completed = [UIAction actionWithTitle:@"Task Completed" image:nil identifier:nil handler:^(__kindof UIAction * _Nonnull action) {}];
        completed.attributes = UIMenuElementAttributesDisabled;
        [menuActions addObject:completed];
    }
    
    statusButton.menu = [UIMenu menuWithTitle:@"" children:menuActions];
    statusButton.showsMenuAsPrimaryAction = YES;
    cell.accessoryView = statusButton;
    
    return cell;
}

- (void)updateTask:(Task *)originalTask toNewStatus:(NSInteger)newStatus {
    NSArray *allTasks = [[TaskManager sharedManager] getAllTasks];
    NSUInteger originalIndex = [allTasks indexOfObject:originalTask];
    
    if (originalIndex != NSNotFound) {
        //        NSMutableDictionary *updatedTask = [originalTask mutableCopy];
        //        updatedTask[@"status"] = @(newStatus);
        originalTask.status = newStatus;
        originalTask.lastUpdatedDate = [NSDate date];
        
        if (newStatus == 2) {
            NSString *identifier = [NSString stringWithFormat:@"task_%lu", (unsigned long)originalTask.hash];
            [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:@[identifier]];
        }
        
        [[TaskManager sharedManager] updateTask:originalTask atIndex:originalIndex];
        [self filterTasks];
    }
}

- (void)priorityImageTapped:(UITapGestureRecognizer *)sender {
    CGPoint tapLocation = [sender locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:tapLocation];
    
    if (indexPath) {
        Task *originalTask = [self taskAtIndexPath:indexPath];
        
        if (originalTask.status == 2) {
            return;
        }
        
        NSArray *allTasks = [[TaskManager sharedManager] getAllTasks];
        NSUInteger originalIndex = [allTasks indexOfObject:originalTask];
        
        //        NSMutableDictionary *updatedTask = [originalTask mutableCopy];
        
        NSInteger currentPriority = originalTask.priority;
        NSInteger newPriority = (currentPriority + 1) % 3;
        
        //        updatedTask[@"priority"] = @(newPriority);
        //        updatedTask[@"lastUpdatedDate"] = [NSDate date];
        originalTask.priority = newPriority;
        originalTask.lastUpdatedDate = [NSDate date];
        
        [[TaskManager sharedManager] updateTask:originalTask atIndex:originalIndex];
        [self filterTasks];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EditTaskViewController *editVC = [storyboard instantiateViewControllerWithIdentifier:@"EditTaskViewController"];
    
    Task *selectedTask = [self taskAtIndexPath:indexPath];
    
    NSArray *allTasks = [[TaskManager sharedManager] getAllTasks];
    NSUInteger originalIndex = [allTasks indexOfObject:selectedTask];
    
    editVC.isEditingMode = YES;
    editVC.taskToEdit = selectedTask;
    editVC.taskIndex = originalIndex;
    
    [self.navigationController pushViewController:editVC animated:YES];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Delete Task"
                                                                       message:@"Are you sure you want to delete this task? This cannot be undone."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                               style:UIAlertActionStyleCancel
                                                             handler:nil];
        
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete"
                                                               style:UIAlertActionStyleDestructive
                                                             handler:^(UIAlertAction * _Nonnull action) {
            
            Task *taskToRemove = [self taskAtIndexPath:indexPath];
            
            NSString *identifier = [NSString stringWithFormat:@"task_%lu", (unsigned long)taskToRemove.hash];
            [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:@[identifier]];
            
            NSArray *allTasks = [[TaskManager sharedManager] getAllTasks];
            NSUInteger originalIndex = [allTasks indexOfObject:taskToRemove];
            
            [[TaskManager sharedManager] removeTaskAtIndex:originalIndex];
            [self filterTasks];
        }];
        
        [alert addAction:cancelAction];
        [alert addAction:deleteAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

@end
