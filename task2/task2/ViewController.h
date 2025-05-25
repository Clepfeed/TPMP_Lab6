//
//  ViewController.h
//  task2
//
//   
//

#import <UIKit/UIKit.h>
#import "City.h"

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) NSArray<City *> *cities;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *searchButton;
@property (nonatomic, strong) UIImageView *monumentImageView;
@property (nonatomic, strong) UILabel *cityLabel;
@property (nonatomic, strong) UILabel *countryLabel;
@property (nonatomic, strong) UILabel *tempLabel;
@property (nonatomic, strong) UIView *colorView;

@end

