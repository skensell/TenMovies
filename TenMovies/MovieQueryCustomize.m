//
//  MovieQueryCustomize.m
//  TenMovies
//
//  Created by Scott Kensell on 6/11/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "MovieQueryCustomize.h"

#import "TMDBDiscoverMovieQueryParameters.h"
#import "TMDBGenre.h"
#import "DefaultsManager.h"
#import "GenreCell.h"
#import "ReleaseDateCell.h"
#import "SortByCell.h"

@interface MovieQueryCustomize () <UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) TMDBDiscoverMovieQueryParameters *params;

@end

@implementation MovieQueryCustomize

- (void)viewWillDisappear:(BOOL)animated {
    [DefaultsManager setDiscoverMovieQueryParameters:self.params];
}

#pragma mark - Properties

- (TMDBDiscoverMovieQueryParameters *)params {
    if (!_params) {
        _params = [DefaultsManager discoverMovieQueryParameters];
    }
    return _params;
}


#pragma mark - Target-Action

- (IBAction)tapSortByTypeSegmentedControl:(id)sender {
    if ([sender isKindOfClass:[UISegmentedControl class]]) {
        
        UISegmentedControl *sortByTypeSegmentedControl = (UISegmentedControl *)sender;
        int index = sortByTypeSegmentedControl.selectedSegmentIndex;
        if (index == 0) {
            self.params.sortByType = SORT_BY_POPULARITY_DESC;
        } else {
            self.params.sortByType = SORT_BY_VOTE_AVERAGE_DESC;
        }
        
    }
}


#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSInteger year = row + kFirstYearToAllow;
    if (component == 0) {
        self.params.fromYear = year;
    } else if (component == 1) {
        self.params.toYear = year;
    }
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return kNumberOfYearsToAllow;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%d", row + kFirstYearToAllow];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *releaseDateCellIdentifier = @"ReleaseDateCellIdentifier";
    static NSString *sortByCellIdentifier = @"SortByCellIdentifier";
    static NSString *genreCellIdentifier = @"GenreCellIdentifier";
    
    NSString *cellIdentifier;
    switch (indexPath.section) {
        case 0:
            cellIdentifier = releaseDateCellIdentifier;
            break;
        case 1:
            cellIdentifier = sortByCellIdentifier;
            break;
        case 2:
            cellIdentifier = genreCellIdentifier;
            break;
        default:
            cellIdentifier = genreCellIdentifier;
            break;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ([cellIdentifier isEqualToString:genreCellIdentifier]) {
        
        GenreCell *genreCell = (GenreCell *)cell;
        if (indexPath.row == 0) {
            genreCell.label.text = @"All";
            genreCell.onSwitch.on = NO;
        } else {
            TMDBGenre *genre = [TMDBGenre genreWithAlphabeticalIndex:indexPath.row-1];
            genreCell.label.text = [genre asText];
            genreCell.onSwitch.on = YES;
        }
    
    } else if ([cellIdentifier isEqualToString:releaseDateCellIdentifier]) {
        
        ReleaseDateCell *releaseDateCell = (ReleaseDateCell *)cell;
        releaseDateCell.releaseDateYearPicker.dataSource = self;
        releaseDateCell.releaseDateYearPicker.delegate = self;
        [releaseDateCell.releaseDateYearPicker selectRow:(self.params.fromYear - kFirstYearToAllow) inComponent:0 animated:NO];
        [releaseDateCell.releaseDateYearPicker selectRow:(self.params.toYear - kFirstYearToAllow) inComponent:1 animated:NO];
        
    } else if ([cellIdentifier isEqualToString:sortByCellIdentifier]) {
        
        SortByCell *sortByCell = (SortByCell *)cell;
        if (self.params.sortByType == SORT_BY_POPULARITY_DESC) {
            sortByCell.sortByTypeSegmentedControl.selectedSegmentIndex = 0;
        } else if (self.params.sortByType == SORT_BY_VOTE_AVERAGE_DESC) {
            sortByCell.sortByTypeSegmentedControl.selectedSegmentIndex = 1;
        }
        
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (section == 2) ? [TMDBGenre allGenres].count + 1 : 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height;
    if (indexPath.section == 0) {
        height = 250.0f;
    } else {
        height = 60.0f;
    }
    
    return height;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = nil;
    switch (section) {
        case 0:
            title = @"Release date";
            break;
        case 1:
            title = @"Sort by";
            break;
        case 2:
            title = @"Genres to include";
            break;
        default:
            break;
    }
    return title;
}

#pragma mark - Private


@end
