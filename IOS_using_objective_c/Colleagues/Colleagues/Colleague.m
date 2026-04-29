//
//  Colleague.m
//  Colleagues
//
//  Created by Thaowpsta Saiid on 20/04/2026.
//

#import "Colleague.h"

@implementation Colleague

- (instancetype)initWithName:(NSString *)name phone:(NSString *)phone age:(NSNumber *)age email:(NSString *)email address:(NSString *)address {
    self = [super init];
    if (self) {
        _name = name;
        _phone = phone;
        _age = age;
        _email = email;
        _address = address;
    }
    return self;
}

@end
