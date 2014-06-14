//
//  ReleaseDateCell.h
//  TenMovies
//
//  Created by Scott Kensell on 6/13/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import <UIKit/UIKit.h>

static int kFirstYearToAllow = 1960;
static int kNumberOfYearsToAllow = 60;

@interface ReleaseDateCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIPickerView *releaseDateYearPicker;

@end
