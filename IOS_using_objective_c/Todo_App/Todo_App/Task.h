//
//  Task.h
//  Todo_App
//
//  Created by Thaowpsta Saiid on 28/04/2026.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Task : NSObject <NSSecureCoding>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong, nullable) NSData *descriptionData;
@property (nonatomic, assign) NSInteger priority;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSDate *creationDate;
@property (nonatomic, strong) NSDate *lastUpdatedDate;

@property (nonatomic, strong, nullable) NSString *attachmentBase64;
@property (nonatomic, strong, nullable) NSString *attachmentName;
@property (nonatomic, strong, nullable) NSDate *reminderDate;

@end

NS_ASSUME_NONNULL_END
