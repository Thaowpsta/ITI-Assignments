//
//  EditTaskViewController.m
//  Todo_App
//
//  Created by Thaowpsta Saiid on 27/04/2026.
//

#import <UniformTypeIdentifiers/UniformTypeIdentifiers.h>
#import <UserNotifications/UserNotifications.h>
#import "EditTaskViewController.h"
#import "TaskManager.h"


@interface EditTaskViewController ()
@end

@implementation EditTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.updatedDateLabel.hidden = YES;
    
    // ==========================================
        // PROGRAMMATIC REMINDER UI (No Storyboard needed!)
        // ==========================================
        
        // 1. Create the Reminder Label
        UILabel *reminderLabel = [[UILabel alloc] init];
        reminderLabel.text = @"Set Reminder";
        reminderLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
        
        // 2. Create the Switch
        UISwitch *tempSwitch = [[UISwitch alloc] init];
        [tempSwitch addTarget:self action:@selector(reminderSwitchChanged:) forControlEvents:UIControlEventValueChanged];
        
        // 3. Group Label and Switch in a Horizontal Stack View
        UIStackView *reminderStack = [[UIStackView alloc] initWithArrangedSubviews:@[reminderLabel, tempSwitch]];
        reminderStack.axis = UILayoutConstraintAxisHorizontal;
        reminderStack.distribution = UIStackViewDistributionEqualSpacing;
        
        // 4. Create the Date Picker
        UIDatePicker *tempPicker = [[UIDatePicker alloc] init];
        tempPicker.datePickerMode = UIDatePickerModeDateAndTime;
        tempPicker.preferredDatePickerStyle = UIDatePickerStyleCompact;
        
        // 5. Find your main vertical Stack View
        // (We know statusSegment is inside a horizontal stack, which is inside the main vertical stack)
        UIStackView *mainStack = (UIStackView *)self.statusSegment.superview.superview;
        
        // 6. Insert the new views between the Status Segments and the Description Box (Index 3 and 4)
        [mainStack insertArrangedSubview:reminderStack atIndex:3];
        [mainStack insertArrangedSubview:tempPicker atIndex:4];
        
        // 7. Assign them to your properties so the rest of your code can use them
        self.reminderSwitch = tempSwitch;
        self.reminderDatePicker = tempPicker;
        
        // ==========================================
    
    if (self.isEditingMode && self.taskToEdit != nil) {
        //        self.nameTextField.text = self.taskToEdit[@"name"];
        self.nameTextField.text = self.taskToEdit.name;
        //        self.descTextView.text = self.taskToEdit[@"description"];
        self.prioritySegment.selectedSegmentIndex = self.taskToEdit.priority;
        self.statusSegment.selectedSegmentIndex = self.taskToEdit.status;
        
        if (self.taskToEdit.status == 2) {
            
            self.nameTextField.enabled = NO;
            self.descTextView.editable = NO;
            self.prioritySegment.enabled = NO;
            self.statusSegment.enabled = NO;
            self.saveButton.hidden = YES;
        }
        
        NSDate *date = self.taskToEdit.lastUpdatedDate ?: self.taskToEdit.creationDate;
        
        if (date) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateStyle = NSDateFormatterMediumStyle;
            formatter.timeStyle = NSDateFormatterShortStyle;
            
            self.updatedDateLabel.text = [NSString stringWithFormat:@"Last Updated: %@", [formatter stringFromDate:date]];
            self.updatedDateLabel.hidden = NO;
        }
    }
    
    if (self.isEditingMode && self.taskToEdit.reminderDate != nil) {
        self.reminderSwitch.on = YES;
        self.reminderDatePicker.date = self.taskToEdit.reminderDate;
        self.reminderDatePicker.hidden = NO;
    } else {
        self.reminderSwitch.on = NO;
        self.reminderDatePicker.hidden = YES;
    }
    
    if (self.isEditingMode && self.taskToEdit.attachmentBase64 != nil) {
        self.attachmentName = self.taskToEdit.attachmentName;
        self.attachmentData = [[NSData alloc] initWithBase64EncodedString:self.taskToEdit.attachmentBase64 options:0];
        
        self.fileNameLabel.text = self.attachmentName;
        if ([self.attachmentName.lowercaseString hasSuffix:@".pdf"]) {
            self.attachmentPreview.image = [UIImage systemImageNamed:@"doc.richtext"];
        } else {
            self.attachmentPreview.image = [UIImage imageWithData:self.attachmentData];
        }
    }
    
    if (self.taskToEdit.descriptionData) {
        self.descTextView.attributedText = [[NSAttributedString alloc] initWithData:self.taskToEdit.descriptionData
                                                                            options:@{NSDocumentTypeDocumentAttribute: NSRTFDTextDocumentType}
                                                                 documentAttributes:nil
                                                                              error:nil];
    }
    
    self.attachmentPreview.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(previewTapped:)];
    [self.attachmentPreview addGestureRecognizer:tap];
}
- (IBAction)saveTapped:(id)sender {
    NSString *nameText = [self.nameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *descText = [self.descTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (nameText.length == 0 || descText.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Missing Information" message:@"Please fill in both the task name and description to continue." preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    if (self.isEditingMode) {
        UIAlertController *confirmAlert = [UIAlertController alertControllerWithTitle:@"Confirm Edit" message:@"Are you sure you want to save these changes to the task?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self performSaveTaskWithName:nameText description:descText];
        }];
        UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        
        [confirmAlert addAction:noAction];
        [confirmAlert addAction:yesAction];
        
        [self presentViewController:confirmAlert animated:YES completion:nil];
    } else {
        [self performSaveTaskWithName:nameText description:descText];
    }
}

- (void)performSaveTaskWithName:(NSString *)name description:(NSString *)desc {
    NSInteger newStatus = self.statusSegment.selectedSegmentIndex;
    
    if (self.isEditingMode) {
        NSInteger oldStatus = self.taskToEdit.status;
        if (oldStatus == 1 && newStatus == 0) {
            [self showError:@"In Progress tasks cannot be marked as To-Do."];
            return;
        }
        if (oldStatus == 2 && newStatus == 1) {
            [self showError:@"Done tasks cannot be marked as In Progress."];
            return;
        }
        if (oldStatus == 2 && newStatus == 0) {
            [self showError:@"Done tasks cannot be marked as To-Do."];
            return;
        }
    }
    
    Task *taskToSave;
    
    if (self.isEditingMode) {
        taskToSave = self.taskToEdit;
    } else {
        taskToSave = [[Task alloc] init];
        taskToSave.creationDate = [NSDate date];
    }
    
    taskToSave.name = name;
    
    NSData *rtfdData = [self.descTextView.attributedText dataFromRange:NSMakeRange(0, self.descTextView.attributedText.length)
                                                    documentAttributes:@{NSDocumentTypeDocumentAttribute: NSRTFDTextDocumentType}
                                                                 error:nil];
    taskToSave.descriptionData = rtfdData;
    taskToSave.priority = self.prioritySegment.selectedSegmentIndex;
    taskToSave.status = newStatus;
    taskToSave.lastUpdatedDate = [NSDate date];
    
    if (self.attachmentData && self.attachmentName) {
        NSString *base64String = [self.attachmentData base64EncodedStringWithOptions:0];
        taskToSave.attachmentBase64 = base64String;
        taskToSave.attachmentName = self.attachmentName;
    } else if (self.isEditingMode && self.taskToEdit.attachmentBase64) {
        taskToSave.attachmentBase64 = self.taskToEdit.attachmentBase64;
        taskToSave.attachmentName = self.taskToEdit.attachmentName;
    }
    
    if (self.reminderSwitch.isOn) {
            taskToSave.reminderDate = self.reminderDatePicker.date;
        } else {
            taskToSave.reminderDate = nil;
        }
        
        [self scheduleNotificationForTask:taskToSave];
    
    if (self.isEditingMode) {
        taskToSave.creationDate = self.taskToEdit.creationDate;
        [[TaskManager sharedManager] updateTask:taskToSave atIndex:self.taskIndex];
    } else {
        [[TaskManager sharedManager] addTask:taskToSave];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)attachFileTapped:(id)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Add Attachment"
                                                                         message:@"Where would you like to attach from?"
                                                                  preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
    }];
    
    UIAlertAction *fileAction = [UIAlertAction actionWithTitle:@"Files App (PDFs)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSArray *types = @[UTTypePDF, UTTypeImage];
        UIDocumentPickerViewController *picker = [[UIDocumentPickerViewController alloc] initForOpeningContentTypes:types];
        picker.delegate = self;
        picker.allowsMultipleSelection = NO;
        [self presentViewController:picker animated:YES completion:nil];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [actionSheet addAction:photoAction];
    [actionSheet addAction:fileAction];
    [actionSheet addAction:cancelAction];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *selectedImage = info[UIImagePickerControllerOriginalImage];
    
    if (selectedImage) {
        self.attachmentData = UIImageJPEGRepresentation(selectedImage, 0.8);
        
        self.attachmentName = [NSString stringWithFormat:@"photo_%d.jpg", (int)[[NSDate date] timeIntervalSince1970]];
        
        self.fileNameLabel.text = self.attachmentName;
        self.fileNameLabel.hidden = NO;
        self.attachmentPreview.hidden = NO;
        self.attachmentPreview.image = selectedImage;
        self.attachmentPreview.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls {
    NSURL *fileURL = urls.firstObject;
    if (!fileURL) return;
    
    BOOL canAccess = [fileURL startAccessingSecurityScopedResource];
    
    self.attachmentData = [NSData dataWithContentsOfURL:fileURL];
    self.attachmentName = fileURL.lastPathComponent;
    
    if (canAccess) {
        [fileURL stopAccessingSecurityScopedResource];
    }
    
    if (!self.attachmentData) {
        [self showError:@"Error: Could not read the selected file."];
        return;
    }
    
    self.fileNameLabel.text = self.attachmentName;
    self.fileNameLabel.hidden = NO;
    self.attachmentPreview.hidden = NO;
    
    if ([self.attachmentName.lowercaseString hasSuffix:@".pdf"]) {
        self.attachmentPreview.image = [UIImage systemImageNamed:@"doc.richtext"];
        self.attachmentPreview.contentMode = UIViewContentModeScaleAspectFit;
    } else {
        self.attachmentPreview.image = [UIImage imageWithData:self.attachmentData];
        self.attachmentPreview.contentMode = UIViewContentModeScaleAspectFill;
    }
}

- (void)previewTapped:(UITapGestureRecognizer *)sender {
    if (!self.attachmentData || !self.attachmentName) return;
    
    NSString *tempDir = NSTemporaryDirectory();
    NSString *filePath = [tempDir stringByAppendingPathComponent:self.attachmentName];
    self.tempPreviewURL = [NSURL fileURLWithPath:filePath];
    
    [self.attachmentData writeToURL:self.tempPreviewURL atomically:YES];
    
    QLPreviewController *previewController = [[QLPreviewController alloc] init];
    previewController.dataSource = self;
    [self presentViewController:previewController animated:YES completion:nil];
}

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller {
    return 1;
}

- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
    return self.tempPreviewURL;
}

- (IBAction)reminderSwitchChanged:(UISwitch *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.reminderDatePicker.hidden = !sender.isOn;
        [self.view layoutIfNeeded];
    }];
}

- (void)scheduleNotificationForTask:(Task *)task {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    NSString *identifier = [NSString stringWithFormat:@"task_%lu", (unsigned long)task.hash];
    
    [center removePendingNotificationRequestsWithIdentifiers:@[identifier]];
    
    if (task.reminderDate && task.status != 2 && [task.reminderDate timeIntervalSinceNow] > 0) {
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = @"Task Reminder";
        content.body = task.name;
        content.sound = [UNNotificationSound defaultSound];
        
        NSDateComponents *triggerDate = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:task.reminderDate];
        
        UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:triggerDate repeats:NO];
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
        
        [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            if (error) NSLog(@"Error scheduling notification: %@", error.localizedDescription);
        }];
    }
}

- (void)showError:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Status Error" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
