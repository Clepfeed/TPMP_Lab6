//
//  City.h
//  task2
//
//
//

#ifndef City_h
#define City_h

#import <Foundation/Foundation.h>

@interface City : NSObject
@property (nonatomic, strong) NSString *nameKey;
@property (nonatomic, assign) NSInteger temperature;
@property (nonatomic, strong) NSString *countryKey;
@property (nonatomic, strong) NSString *monumentImageName;

- (instancetype)initWithNameKey:(NSString *)nameKey
                  temperature:(NSInteger)temperature
                    countryKey:(NSString *)countryKey
            monumentImageName:(NSString *)monumentImageName;
@end
#endif /* City_h */
