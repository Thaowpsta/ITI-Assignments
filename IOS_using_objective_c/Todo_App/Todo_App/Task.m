//
//  Task.m
//  Todo_App
//
//  Created by Thaowpsta Saiid on 28/04/2026.
//

#import "Task.h"

@implementation Task

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.descriptionData forKey:@"descriptionData"];
    [coder encodeInteger:self.priority forKey:@"priority"];
    [coder encodeInteger:self.status forKey:@"status"];
    [coder encodeObject:self.creationDate forKey:@"creationDate"];
    [coder encodeObject:self.lastUpdatedDate forKey:@"lastUpdatedDate"];
    [coder encodeObject:self.attachmentBase64 forKey:@"attachmentBase64"];
    [coder encodeObject:self.attachmentName forKey:@"attachmentName"];
    [coder encodeObject:self.reminderDate forKey:@"reminderDate"];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _name = [coder decodeObjectOfClass:[NSString class] forKey:@"name"];
        _descriptionData = [coder decodeObjectOfClass:[NSData class] forKey:@"descriptionData"];
        _priority = [coder decodeIntegerForKey:@"priority"];
        _status = [coder decodeIntegerForKey:@"status"];
        _creationDate = [coder decodeObjectOfClass:[NSDate class] forKey:@"creationDate"];
        _lastUpdatedDate = [coder decodeObjectOfClass:[NSDate class] forKey:@"lastUpdatedDate"];
        _attachmentBase64 = [coder decodeObjectOfClass:[NSString class] forKey:@"attachmentBase64"];
        _attachmentName = [coder decodeObjectOfClass:[NSString class] forKey:@"attachmentName"];
        _reminderDate = [coder decodeObjectOfClass:[NSDate class] forKey:@"reminderDate"];
    }
    return self;
}

-(BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[Task class]]) {
        return NO;
    }
    
    Task *otherTask = (Task *)object;
    
    // We use creationDate as a unique ID. If two tasks have the exact same creation timestamp, they are the same task.
    if (self.creationDate && otherTask.creationDate) {
        return [self.creationDate isEqualToDate:otherTask.creationDate];
    }
    
    // Fallback just in case creationDate is missing
    return [self.name isEqualToString:otherTask.name];
}

- (NSUInteger)hash {
    return [self.creationDate hash];
}

@end
