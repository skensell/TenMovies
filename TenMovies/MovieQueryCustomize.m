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
#import "MinVotesCell.h"

@interface MovieQueryCustomize () <UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, SwitchGenreDelegate>

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

- (IBAction)minimumVotesValueChanged:(UIStepper *)sender {
    self.params.minNumberOfVotes = (NSUInteger)sender.value;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:1]]
                          withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - SwitchGenreDelegate

- (void)genre:(TMDBGenre *)genre shouldBeIncluded:(BOOL)shouldBeIncluded {
    if (shouldBeIncluded) {
        if ([self.params.genres containsObject:genre] == NO) {
            self.params.genres = [[self.params.genres arrayByAddingObject:genre] sortedArrayUsingComparator:^NSComparisonResult(TMDBGenre *genre1, TMDBGenre *genre2) {
                return [[genre1 asText] compare:[genre2 asText]];
            }];
        }
    } else {
        NSMutableArray *genres = [self.params.genres mutableCopy];
        [genres removeObject:genre];
        self.params.genres = genres;
    }
}

- (void)toggleAllGenres:(BOOL)includeAll {
    self.params.genres = (includeAll) ? [TMDBGenre allGenres] : @[];
    [self.tableView reloadData];
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
    static NSString *minVotesCellIdentifier = @"minVotesCellIdentifier";
    
    NSString *cellIdentifier;
    switch (indexPath.section) {
        case 0:
            cellIdentifier = releaseDateCellIdentifier;
            break;
        case 1:
            if (indexPath.row == 0) {
                cellIdentifier = sortByCellIdentifier;
            } else if (indexPath.row == 1) {
                cellIdentifier = minVotesCellIdentifier;
            }
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
            genreCell.label.text = kAllGenresString;
            genreCell.onSwitch.on = [self.params.genres count] == [[TMDBGenre allGenres] count];
        } else {
            TMDBGenre *genre = [TMDBGenre genreWithAlphabeticalIndex:indexPath.row-1];
            genreCell.label.text = [genre asText];
            genreCell.onSwitch.on = [self.params.genres containsObject:genre];
        }
        genreCell.delegate = self;
    
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
        
    } else if ([cellIdentifier isEqualToString:minVotesCellIdentifier]) {
        
        MinVotesCell *minVotesCell = (MinVotesCell *)cell;
        minVotesCell.numberOfVotesStepper.value = self.params.minNumberOfVotes;
        minVotesCell.numberOfVotesLabel.text = [NSString stringWithFormat:@"%d", (NSUInteger)minVotesCell.numberOfVotesStepper.value];
        minVotesCell.numberOfVotesStepper.minimumValue = 0;
        minVotesCell.numberOfVotesStepper.maximumValue = 1000;
        
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 2;
    } else if (section == 2) {
        return [TMDBGenre allGenres].count + 1;
    } else {
        return 0;
    }
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
