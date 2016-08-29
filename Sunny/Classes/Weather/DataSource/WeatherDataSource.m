//
// Created by Maciej Oczko on 22/05/15.
// Copyright (c) 2015 Polidea. All rights reserved.
//

#import "WeatherDataSource.h"
#import "Configurable.h"
#import "WeatherViewCell.h"
#import "WeatherService.h"
#import <extobjc.h>

@interface WeatherDataSource () <UICollectionViewDataSource>
@property(nonatomic, strong, readwrite) NSArray *items;
@end

@implementation WeatherDataSource

- (instancetype)initWithWeatherService:(WeatherService *)weatherService {
    self = [super init];
    if (self) {
        _weatherService = weatherService;
        [self setUp];
    }

    return self;
}

- (void)setUp {
    @weakify(self)
    self.weatherService.weatherChangeUpdateBlock = ^(NSArray *items, NSError *error) {
        @strongify(self)
        [self handleWeatherUpdateWithItems:items error:error completion:self.updateCompletionBlock];
    };
}

- (BOOL)updateWeatherWithCompletion:(WeatherDataSourceCompletionBlock)completion {
    @weakify(self)
    return [self.weatherService updateWeatherWithCompletion:^(NSArray *items, NSError *error) {
        @strongify(self)
        [self handleWeatherUpdateWithItems:items error:error completion:completion];
    }];
}

- (void)handleWeatherUpdateWithItems:(NSArray *)items error:(NSError *)error completion:(WeatherDataSourceCompletionBlock)completion {
    NSLog(@"Fetched weather items%@.", error ? [NSString stringWithFormat:@" error = %@", error.localizedDescription] : @"");
    self.items = items;
    if (completion) {
        completion(error);
    }
}

#pragma mark - Collection View settings

- (Class)defaultCellClass {
    return [WeatherViewCell class];
}

- (void)bindWithView:(UICollectionView *)collectionView {
    collectionView.dataSource = self;
    [collectionView registerClass:self.defaultCellClass forCellWithReuseIdentifier:[self.defaultCellClass className]];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell <Configurable> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[self.defaultCellClass className]
                                                                                          forIndexPath:indexPath];
    NSAssert([cell conformsToProtocol:@protocol(Configurable)], @"Cell must conform to Configurable protocol.");
    id item = self.items[(NSUInteger) indexPath.item];
    [cell configureWithItem:item];
    return cell;
}

@end
