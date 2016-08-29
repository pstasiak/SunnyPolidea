//
// Created by Maciej Oczko on 22/05/15.
// Copyright (c) 2015 Polidea. All rights reserved.
//

#import <objc/objc.h>
#import "WeatherViewController.h"
#import "Metamacros.h"
#import "UIScrollView+EmptyDataSet.h"
#import "WeatherDataSource.h"

@interface WeatherViewController () <DZNEmptyDataSetDelegate, DZNEmptyDataSetSource, UICollectionViewDelegateFlowLayout>
@end

@implementation WeatherViewController

- (instancetype)initWithDataSource:(WeatherDataSource *)dataSource {
    self = [super init];
    if (self) {
        _dataSource = dataSource;
        self.title = NSLocalizedString(@"Sunny", @"Sunny");
    }

    return self;
}

CastView(UICollectionView, collectionView)

- (void)loadView {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.alwaysBounceVertical = YES;

    UIRefreshControl *refreshControl = [UIRefreshControl new];
    [refreshControl addTarget:self action:@checkselector(self, refresh:) forControlEvents:UIControlEventValueChanged];
    [collectionView addSubview:refreshControl];

    self.view = collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configureCollectionView];
    [self configureDataSourceUpdates];
    [self updateWeather:nil];
}

- (void)configureDataSourceUpdates {
    @weakify(self)
    self.dataSource.updateCompletionBlock = ^(NSError *error) {
        @strongify(self)
        [self handlerRefreshWithError:error refreshControl:nil];
    };
}

#pragma mark - Collection View configuration & UICollectionViewDelegate

- (void)configureCollectionView {
    self.collectionView.delegate = self;
    [self.dataSource bindWithView:self.collectionView];
    self.collectionView.emptyDataSetDelegate = self;
    self.collectionView.emptyDataSetSource = self;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth(collectionView.bounds), 50.f);
}

#pragma mark - Refresh

- (void)refresh:(UIRefreshControl *)refreshControl {
    [self updateWeather:refreshControl];
}

- (void)updateWeather:(UIRefreshControl *)refreshControl {
    @weakify(self)
    [self.dataSource updateWeatherWithCompletion:^(NSError *error) {
        @strongify(self)
        [self handlerRefreshWithError:error refreshControl:refreshControl];
    }];
}

- (void)handlerRefreshWithError:(NSError *)error refreshControl:(UIRefreshControl *)refreshControl {
    [refreshControl endRefreshing];
    if (error) {
        NSLog(@"Error updating weather = %@", error.localizedDescription);
    } else {
        [self.collectionView reloadData];
    }
}

#pragma mark - Empty Data Set

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    return [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Weather Stats", @"Weather Stats")];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    return [[NSAttributedString alloc] initWithString:NSLocalizedString(@"There's no available data.", @"There's no available data.")];
}

@end
