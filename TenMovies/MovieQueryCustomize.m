//
//  MovieQueryCustomize.m
//  TenMovies
//
//  Created by Scott Kensell on 6/11/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "MovieQueryCustomize.h"

#import "TMDBDiscoverMovieQueryParameters.h"
#import "DefaultsManager.h"

static int kFirstYearToAllow = 1960;
static int kNumberOfYearsToAllow = 60;

@interface MovieQueryCustomize () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UIPickerView *releaseDateYearPicker;
@property (strong, nonatomic) IBOutlet UISegmentedControl *sortByTypeSegmentedControl;
@property (strong, nonatomic) IBOutlet UISwitch *isRandomSwitch;


@property (nonatomic, strong) TMDBDiscoverMovieQueryParameters *params;
@end

@implementation MovieQueryCustomize

- (void)viewDidLoad {
    [super viewDidLoad];
    _releaseDateYearPicker.dataSource = self;
    _releaseDateYearPicker.delegate = self;
    [_releaseDateYearPicker selectRow:(self.params.fromYear - kFirstYearToAllow) inComponent:0 animated:NO];
    [_releaseDateYearPicker selectRow:(self.params.toYear - kFirstYearToAllow) inComponent:1 animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [DefaultsManager setDiscoverMovieQueryParameters:self.params];
}

- (TMDBDiscoverMovieQueryParameters *)params {
    if (!_params) {
        _params = [DefaultsManager discoverMovieQueryParameters];
    }
    return _params;
}

#pragma mark - UIPickerView

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return kNumberOfYearsToAllow;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%d", row + kFirstYearToAllow];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSInteger year = row + kFirstYearToAllow;
    if (component == 0) {
        self.params.fromYear = year;
    } else if (component == 1) {
        self.params.toYear = year;
    }
}

#pragma mark - Private


@end
