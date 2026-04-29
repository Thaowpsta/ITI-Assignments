//
//  Colleague.h
//  Colleagues
//
//  Created by Thaowpsta Saiid on 20/04/2026.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Colleague : NSObject

@property NSString *name;
@property NSString *phone;
@property NSNumber *age;
@property NSString *email;
@property NSString *address;

- (instancetype)initWithName:(NSString *)name phone:(NSString *)phone age:(NSNumber *)age email:(NSString *)email address:(NSString *)address;

@end

NS_ASSUME_NONNULL_END
