//
//  MoviesCDTVC.m
//  TenMovies
//
//  Created by Scott Kensell on 5/4/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "MoviesCDTVC.h"

static NSString *kTableViewCellIdentifier = @"";

@implementation MoviesCDTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchMovies];
}


#pragma mark - TableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
//    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kTableViewCellIdentifier];
//    Photo *photo = [self.fetchedResultsController objectAtIndexPath:indexPath];
//    cell.textLabel.text = photo.title;
//    cell.detailTextLabel.text = photo.subtitle;
//    if (photo.thumbnail) {
//        cell.imageView.image = [[UIImage alloc] initWithData:photo.thumbnail];
//    } else {
//        [self fetchThumbnailForPhoto:photo];
//    }
    return cell;
}

#pragma mark - Navigation

//- (void)prepareNextViewController:(UIViewController *)vc
//          afterSelectingIndexPath:(NSIndexPath *)indexPath
//                  segueIdentifier:(NSString *)segueIdentifier {
//    Photo *photoToShow = [self.fetchedResultsController objectAtIndexPath:indexPath];
//    photoToShow.lastViewed = [NSDate date];
//    if ([vc isKindOfClass:[ImageViewController class]]) {
//        ImageViewController *ivc = (ImageViewController *)vc;
//        ivc.imageURL = [NSURL URLWithString:photoToShow.imageURL];
//        ivc.title = photoToShow.title;
//    }
//}

#pragma mark - Thumbnail fetch

//- (void)fetchThumbnailForPhoto:(Photo *)photo {
//    if (photo.thumbURL && photo.thumbURL.length) {
//        DEBUG(@"Thumbnail fetch started for %@", photo.title);
//        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:photo.thumbURL]];
//        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
//        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
//        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request
//                                                        completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
//                                                            NSData *thumbData = [NSData dataWithContentsOfFile:[location path]];
//                                                            DEBUG(@"Thumbnail fetch finished for %@", photo.title);
//                                                            photo.thumbnail = thumbData;
//                                                        }];
//        [task resume];
//    }
//}

@end
