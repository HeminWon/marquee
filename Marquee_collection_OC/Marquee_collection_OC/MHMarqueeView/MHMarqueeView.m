//
//  MHMarqueeView.m
//  Marquee_Collection_OC
//
//  Created by HeminWon on 2018/7/12.
//  Copyright © 2018 HeminWon. All rights reserved.
//

#import "MHMarqueeView.h"

@interface MHMarqueeView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation MHMarqueeView

#pragma mark - delegate UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark - setter && getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] init];
    }
    return _collectionView;
}


@end
