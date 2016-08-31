//
//  LocationSearchViewController.m
//  Sunny
//
//  Created by Przemek on 29.08.2016.
//  Copyright © 2016 Polidea. All rights reserved.
//

#import "LocationSearchViewController.h"
#import "LocationSearchViewModel.h"
#import "Metamacros.h"

@interface LocationSearchViewController ()
@property(nonatomic, strong) IBOutlet UIButton *nameSearchButton;
@property(nonatomic, strong, readonly) LocationSearchViewModel *viewModel;
@end

@implementation LocationSearchViewController

MM_NOT_DESIGNATED_INITIALIZER()
MM_NOT_DESIGNATED_NONNULL_INITIALIZER_CUSTOM(initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil)
MM_NOT_DESIGNATED_INITIALIZER_CUSTOM(initWithCoder:(NSCoder *)aDecoder)

- (instancetype)initWithViewModel:(LocationSearchViewModel *)viewModel {
    NSParameterAssert(viewModel);
    if (self = [super initWithNibName:nil bundle:nil]) {
        _viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindWithViewModel];
}

- (void)bindWithViewModel {
    @weakify(self)
    self.viewModel.updateBlock = ^(id<LocationSearchViewDataProtocol> viewData) {
        @strongify(self)
        self.nameSearchButton.enabled = viewData.byNameSearchEnabled;
    };
}

#pragma mark - IBActions

- (IBAction)byNameSearchTextFieldDidChange:(UITextField *)textField {
    self.viewModel.locationName = textField.text;
}

@end

