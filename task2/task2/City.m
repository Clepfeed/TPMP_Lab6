//
//  City.m
//  task2
//
//  
//

#import <Foundation/Foundation.h>
#import "City.h"

@implementation City

- (instancetype)initWithNameKey:(NSString *)nameKey
                   temperature:(NSInteger)temperature
                     countryKey:(NSString *)countryKey
             monumentImageName:(NSString *)monumentImageName {
    self = [super init];
    if (self) {
        _nameKey = nameKey;
        _temperature = temperature;
        _countryKey = countryKey;
        _monumentImageName = monumentImageName;
    }
    return self;
}

@end
