//
//  ViewController.m
//  Marquee_Collection_OC
//
//  Created by HeminWon on 2018/7/12.
//  Copyright © 2018 HeminWon. All rights reserved.
//

#import "ViewController.h"
#import "MHMarqueeView/MHMarqueeView.h"

@interface ViewController ()

@property (nonatomic, strong) MHMarqueeView *marqueeView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.marqueeView];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.marqueeView reloadData];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.marqueeView.frame = CGRectMake(10, 100, 355, 60);
}

#pragma mark - setter && getter
- (MHMarqueeView *)marqueeView {
    if (!_marqueeView) {
        _marqueeView = [[MHMarqueeView alloc] init];
        _marqueeView.backgroundColor = [UIColor lightGrayColor];
    }
    return _marqueeView;
}

@end
