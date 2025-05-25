//
//  ViewController.m
//  task2
//
//   
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Инициализация данных
    _cities = @[
        [[City alloc] initWithNameKey:@"city_rome" temperature:25 countryKey:@"country_italy" monumentImageName:@"colosseum"],
        [[City alloc] initWithNameKey:@"city_milan" temperature:18 countryKey:@"country_italy" monumentImageName:@"duomo"],
        [[City alloc] initWithNameKey:@"city_paris" temperature:12 countryKey:@"country_france" monumentImageName:@"eiffel"],
        [[City alloc] initWithNameKey:@"city_marseille" temperature:20 countryKey:@"country_france" monumentImageName:@"notre_dame"],
        [[City alloc] initWithNameKey:@"city_berlin" temperature:8 countryKey:@"country_germany" monumentImageName:@"brandenburg"],
        [[City alloc] initWithNameKey:@"city_munich" temperature:15 countryKey:@"country_germany" monumentImageName:@"frauenkirche"]
    ];
    
    [self setupUI];
}

- (void)setupUI {
    // Text Field
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 60, 200, 40)];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.placeholder = NSLocalizedString(@"enter_city", nil);
    _textField.delegate = self;
    
    // Search Button
    _searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_searchButton setTitle:NSLocalizedString(@"search", nil) forState:UIControlStateNormal];
    _searchButton.frame = CGRectMake(240, 60, 100, 40);
    [_searchButton addTarget:self action:@selector(handleSearch) forControlEvents:UIControlEventTouchUpInside];
    
    // Monument Image
    _monumentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 120, 300, 200)];
    _monumentImageView.contentMode = UIViewContentModeScaleAspectFit;
    _monumentImageView.center = CGPointMake(self.view.center.x, _monumentImageView.center.y);
    
    // Labels
    _cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 340, 300, 30)];
    _countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 380, 300, 30)];
    _tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 420, 300, 30)];
    
    for (UILabel *label in @[_cityLabel, _countryLabel, _tempLabel]) {
        label.textAlignment = NSTextAlignmentCenter;
        label.center = CGPointMake(self.view.center.x, label.center.y);
    }
    
    // Color View
    _colorView = [[UIView alloc] initWithFrame:CGRectMake(0, 460, 50, 50)];
    _colorView.center = CGPointMake(self.view.center.x, _colorView.center.y);
    _colorView.layer.cornerRadius = 8;
    
    // Создаем массив subviews и добавляем через цикл
    NSArray<UIView *> *views = @[
        _textField,
        _searchButton,
        _monumentImageView,
        _cityLabel,
        _countryLabel,
        _tempLabel,
        _colorView
    ];

    for (UIView *view in views) {
        [self.view addSubview:view];
    }
}

- (void)handleSearch {
    [self.textField resignFirstResponder];
    NSString *input = [self.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    City *foundCity;
    for (City *city in self.cities) {
        NSString *localizedName = NSLocalizedString(city.nameKey, nil);
        if ([localizedName caseInsensitiveCompare:input] == NSOrderedSame) {
            foundCity = city;
            break;
        }
    }
    
    if (foundCity) {
        [self updateUIWithCity:foundCity];
    } else {
        [self showErrorAlert];
    }
}

- (void)updateUIWithCity:(City *)city {
    self.monumentImageView.image = [UIImage imageNamed:city.monumentImageName];
    self.cityLabel.text = NSLocalizedString(city.nameKey, nil);
    self.countryLabel.text = NSLocalizedString(city.countryKey, nil);
    self.tempLabel.text = [NSString stringWithFormat:@"%@: %ld°C", NSLocalizedString(@"temperature", nil), city.temperature];
    self.colorView.backgroundColor = [self colorForTemperature:city.temperature];
}

- (UIColor *)colorForTemperature:(NSInteger)temp {
    if (temp < 10) return [UIColor systemBlueColor];
    if (temp < 20) return [UIColor systemTealColor];
    if (temp < 30) return [UIColor systemOrangeColor];
    return [UIColor systemRedColor];
}

- (void)showErrorAlert {
    UIAlertController *alert = [UIAlertController
        alertControllerWithTitle:NSLocalizedString(@"error", nil)
        message:NSLocalizedString(@"city_not_found", nil)
        preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self handleSearch];
    return YES;
}

@end
