//
//  MHMarqueeVIewFlowLayout.m
//  Marquee_Collection_OC
//
//  Created by HeminWon on 2018/7/15.
//  Copyright © 2018 HeminWon. All rights reserved.
//

#import "MHMarqueeVIewFlowLayout.h"

@interface MHMarqueeVIewFlowLayout ()

//用来记录每一列的最大y值
@property (nonatomic, strong) NSMutableDictionary *maxXDic;
//保存每一个item的attributes
@property (nonatomic, strong) NSMutableArray *attributesArr;

@end

@implementation MHMarqueeVIewFlowLayout

#pragma mark - Init
- (instancetype)init {
    return [self initWithRowCount:1];
}

- (instancetype)initWithRowCount:(NSInteger)rowCount {
    if (self = [super init]) {
        self.rowCount = rowCount;
        self.columnSpacing = 0.f;
        self.rowSpacing = 0.f;
        self.sectionInset = UIEdgeInsetsMake(0.f, 0.f, 0.f, 0.f);
    }
    return self;
}

+ (instancetype)waterFallLayoutWithRowCount:(NSInteger)rowCount {
    return [[self alloc] initWithRowCount:rowCount];
}

#pragma mark - Public
- (void)setColumnSpacing:(NSInteger)columnSpacing rowSpacing:(NSInteger)rowSepacing sectionInset:(UIEdgeInsets)sectionInset {
    self.columnSpacing = columnSpacing;
    self.rowSpacing = rowSepacing;
    self.sectionInset = sectionInset;
}

#pragma mark - Layout
- (void)prepareLayout {
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //初始化字典，有几行就有几个键值对，key为行，value为行的最大x值，初始值为左内边距
    for (int i = 0; i < self.rowCount; i++) {
        self.maxXDic[@(i)] = @(self.sectionInset.left);
    }
    
    //根据collectionView获取总共有多少个item
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    [self.attributesArr removeAllObjects];
    //为每一个item创建一个attributes并存入数组
    for (int i = 0; i < itemCount; i++) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attributesArr addObject:attributes];
    }
}

- (CGSize)collectionViewContentSize {
    __block NSNumber *maxIndex = @0;
    //遍历字典，找出最长的那一列
    [self.maxXDic enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSNumber *obj, BOOL *stop) {
        if ([self.maxXDic[maxIndex] floatValue] < obj.floatValue) {
            maxIndex = key;
        }
    }];
    
    //collectionView的contentSize.height就等于最长列的最大y值+下内边距
    return CGSizeMake([self.maxXDic[maxIndex] floatValue] + self.sectionInset.right, 30);
}



- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    //根据indexPath获取item的attributes
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //获取collectionView的宽度
    CGFloat collectionViewH = self.collectionView.frame.size.height;
    
    //item的高度 = (collectionView的高度 - 内边距与行间距) / 行数
    CGFloat itemHeight = (collectionViewH - self.sectionInset.top - self.sectionInset.bottom - (self.rowCount - 1) * self.rowSpacing) / self.rowCount;
    
    CGFloat itemWidth = 0;
    //获取item的高度，由外界计算得到
    if (self.itemWidthBlock) {
        itemWidth = self.itemWidthBlock(itemWidth, indexPath);
    } else {
        if ([self.delegate respondsToSelector:@selector(waterfallLayout:itemtWidthForHeight:atIndexPath:)]) {
            itemWidth = [self.delegate waterfallLayout:self itemtWidthForHeight:itemWidth atIndexPath:indexPath];
        }
    }
    
    //找出最短的那一行
    __block NSNumber *minIndex = @0;
    [self.maxXDic enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSNumber *obj, BOOL *stop) {
        if ([self.maxXDic[minIndex] floatValue] > obj.floatValue) {
            minIndex = key;
        }
    }];
    
    //根据最短行的行数计算item的x值
    CGFloat itemX = [self.maxXDic[minIndex] floatValue] + self.columnSpacing;
    
    //item的y值 = 最短列的最大y值 + 行间距
    CGFloat itemY = self.sectionInset.top + (self.rowSpacing + itemWidth) * minIndex.integerValue;
    
    //设置attributes的frame
    attributes.frame = CGRectMake(itemX, itemY, itemWidth, itemHeight);
    
    //更新字典中的最大y值
    self.maxXDic[minIndex] = @(CGRectGetMaxX(attributes.frame));
    
    return attributes;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attributesArr;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

#pragma mark - setter getter
- (NSMutableDictionary *)maxXDic {
    if (!_maxXDic) {
        _maxXDic = [[NSMutableDictionary alloc] init];
    }
    return _maxXDic;
}

- (NSMutableArray *)attributesArray {
    if (!_attributesArr) {
        _attributesArr = [NSMutableArray array];
    }
    return _attributesArr;
}

@end
