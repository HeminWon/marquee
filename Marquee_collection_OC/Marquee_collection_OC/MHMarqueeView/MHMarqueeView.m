//
//  MHMarqueeView.m
//  Marquee_Collection_OC
//
//  Created by HeminWon on 2018/7/12.
//  Copyright © 2018 HeminWon. All rights reserved.
//

#import "MHMarqueeView.h"
#import "Layout/MHMarqueeVIewFlowLayout.h"
#import "views/MHMarqueeCollectionViewCell.h"

static NSString * const reuseIdentifier = @"MHMarqueeCollectionViewCell";

@interface MHMarqueeView ()<UICollectionViewDelegate, UICollectionViewDataSource, MHMarqueeVIewFlowLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation MHMarqueeView


#pragma mark - Init
- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
        [self setupUI];
        
    }
    return self;
}

- (void)commonInit {
    
}

- (void)setupUI {
    [self addSubview:self.collectionView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}

- (void)reloadData {
    [self.collectionView reloadData];
}

#pragma mark - delegate UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MHMarqueeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.text = @"idfadfdsfskldjfs;d";
    return cell;
}

#pragma mark - delegate MHMarqueeVIewFlowLayoutDelegate
- (CGFloat)waterfallLayout:(MHMarqueeVIewFlowLayout *)waterfallLayout itemtWidthForHeight:(CGFloat)itemHeight atIndexPath:(NSIndexPath *)indexPath {
    return 10;
}

#pragma mark - setter && getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        MHMarqueeVIewFlowLayout *flowLayout = [MHMarqueeVIewFlowLayout waterFallLayoutWithRowCount:1];
        flowLayout.delegate = self;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        [_collectionView registerClass:[MHMarqueeCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}



@end
