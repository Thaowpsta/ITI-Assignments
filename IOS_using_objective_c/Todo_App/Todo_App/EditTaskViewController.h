//
//  EditTaskViewController.h
//  Todo_App
//
//  Created by Thaowpsta Saiid on 27/04/2026.
//

#import <UIKit/UIKit.h>
#import <UniformTypeIdentifiers/UniformTypeIdentifiers.h>
#import <QuickLook/QuickLook.h>
#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditTaskViewController : UIViewController <UIDocumentPickerDelegate, QLPreviewControllerDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *updatedDateLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextView *descTextView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *prioritySegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *statusSegment;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *attachmentButton;

@property (nonatomic) BOOL isEditingMode;
@property (strong, nonatomic) Task *taskToEdit;
@property (assign, nonatomic) NSUInteger taskIndex;

@property (weak, nonatomic) IBOutlet UIImageView *attachmentPreview;
@property (weak, nonatomic) IBOutlet UILabel *fileNameLabel;
@property (strong, nonatomic) NSData *attachmentData;
@property (strong, nonatomic) NSString *attachmentName;
@property (strong, nonatomic) NSURL *tempPreviewURL; 

@property (weak, nonatomic) IBOutlet UISwitch *reminderSwitch;
@property (weak, nonatomic) IBOutlet UIDatePicker *reminderDatePicker;

- (IBAction)reminderSwitchChanged:(UISwitch *)sender;
- (IBAction)saveTapped:(id)sender;
- (IBAction)attachFileTapped:(id)sender;

@end

NS_ASSUME_NONNULL_END
