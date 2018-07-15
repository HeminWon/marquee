//
//  MHMarqueeCollectionViewCell.m
//  Marquee_Collection_OC
//
//  Created by HeminWon on 2018/7/12.
//  Copyright © 2018 HeminWon. All rights reserved.
//

#import "MHMarqueeCollectionViewCell.h"

@interface MHMarqueeCollectionViewCell ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation MHMarqueeCollectionViewCell

#pragma mark - Init
- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //
    }
    return self;
}

#pragma mark - Layout
- (void)layoutSubviews {
    [super layoutSubviews];
    self.label.frame = self.bounds;
}

#pragma mark - Public
- (void)setText:(NSString *)text {
    if (_text != text) {
        _text = text;
        self.label.text = _text;
    }
}

#pragma mark - setter && getter
- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
    }
    return _label;
}


@end
