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
@property (nonatomic, assign) CADisplayLink *displayLink;

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
    self.displayLink.paused = NO;
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
    return 15;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MHMarqueeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.text = @"idfadfdsfskldjfs;d";
    return cell;
}

#pragma mark - delegate MHMarqueeVIewFlowLayoutDelegate
- (CGFloat)waterfallLayout:(MHMarqueeVIewFlowLayout *)waterfallLayout itemtWidthForHeight:(CGFloat)itemHeight atIndexPath:(NSIndexPath *)indexPath {
//    UILabel *label = [[UILabel alloc] init];
//    label.text = @"idfadfdsfskldjfs;d";
//    [label sizeToFit];
    
    return arc4random() % 100 + 100;
}

- (void)updateContentOffset:(CADisplayLink *)displayLink {
    self.collectionView.contentOffset = CGPointMake(self.collectionView.contentOffset.x + 0.5f, 0);
}


#pragma mark - setter && getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        MHMarqueeVIewFlowLayout *flowLayout = [MHMarqueeVIewFlowLayout waterFallLayoutWithRowCount:2];
        [flowLayout setColumnSpacing:10 rowSpacing:1 sectionInset:UIEdgeInsetsMake(1, 1, 1, 1)];
        flowLayout.delegate = self;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[MHMarqueeCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

- (CADisplayLink *)displayLink {
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateContentOffset:)];
        _displayLink.preferredFramesPerSecond = 60;
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop]
                               forMode:NSDefaultRunLoopMode];
    }
    return _displayLink;
}

@end
