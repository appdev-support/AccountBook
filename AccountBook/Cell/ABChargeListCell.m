//
//  ABChargeListCell.m
//  AccountBook
//
//  Created by zhourongqing on 15/9/20.
//  Copyright (c) 2015年 mtry. All rights reserved.
//

#import "ABChargeListCell.h"

@interface ABChargeListCell ()

@property (nonatomic, readonly) UILabel *titleLabel;

@property (nonatomic, readonly) UILabel *amountLabel;

@property (nonatomic, readonly) UILabel *startDateLabel;

@property (nonatomic, readonly) UILabel *endDateLabel;

@end

@implementation ABChargeListCell

@synthesize titleLabel = _titleLabel;
@synthesize amountLabel = _amountLabel;
@synthesize startDateLabel = _startDateLabel;
@synthesize endDateLabel = _endDateLabel;

- (UILabel *)titleLabel
{
    if(!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:18];
    }
    return _titleLabel;
}

- (UILabel *)amountLabel
{
    if(!_amountLabel)
    {
        _amountLabel = [[UILabel alloc] init];
        _amountLabel.textColor = [UIColor colorWithUInt:0x308ac2];
        _amountLabel.font = [UIFont systemFontOfSize:18];
    }
    return _amountLabel;
}

- (UILabel *)startDateLabel
{
    if(!_startDateLabel)
    {
        _startDateLabel = [[UILabel alloc] init];
        _startDateLabel.font = [UIFont systemFontOfSize:14];
        _startDateLabel.textColor = [UIColor grayColor];
    }
    return _startDateLabel;
}

- (UILabel *)endDateLabel
{
    if(!_endDateLabel)
    {
        _endDateLabel = [[UILabel alloc] init];
        _endDateLabel.font = [UIFont systemFontOfSize:14];
        _endDateLabel.textColor = [UIColor grayColor];
    }
    return _endDateLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.amountLabel];
        [self.contentView addSubview:self.startDateLabel];
        [self.contentView addSubview:self.endDateLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat space = 10;
    CGRect rect = CGRectZero;
    
    rect.size.width = 150;
    rect.size.height = self.startDateLabel.font.lineHeight;
    rect.origin.x = 15;
    rect.origin.y = (CGRectGetHeight(self.contentView.frame) - rect.size.height * 2 - space) / 2;
    self.titleLabel.frame = rect;
    
    rect = self.titleLabel.frame;
    rect.size.height = self.amountLabel.font.lineHeight;
    rect.origin.y = CGRectGetMaxY(self.titleLabel.frame) + space;
    self.amountLabel.frame = rect;
    
    space = 5;
    rect.size.width = 150;
    rect.size.height = self.startDateLabel.font.lineHeight;
    rect.origin.x = CGRectGetWidth(self.contentView.frame) - rect.size.width - 10;
    rect.origin.y = (CGRectGetHeight(self.contentView.frame) - rect.size.height * 2 - space) / 2;
    self.startDateLabel.frame = rect;
    
    rect.origin.y = CGRectGetMaxY(self.startDateLabel.frame) + space;
    rect.size.height = self.endDateLabel.font.lineHeight;
    self.endDateLabel.frame = rect;
}

- (void)reloadWithModel:(ABChargeModel *)model
{
    self.titleLabel.text = model.title;
    self.amountLabel.text = [NSString stringWithFormat:@"%.lf元", model.amount];
    self.startDateLabel.text = [NSString stringWithFormat:@"开始时间：%@", [ABUtils dateString:model.startTimeInterval]];
    
    NSMutableString *endDateString = [[NSMutableString alloc] initWithString:@"结束时间："];
    if(model.endTimeInterval)
    {
        [endDateString appendString:[ABUtils dateString:model.endTimeInterval]];
    }
    else
    {
        [endDateString appendString:@"-"];
    }
    self.endDateLabel.text = endDateString;
    
    if(model.isTimeOut)
    {
        self.amountLabel.textColor = [UIColor redColor];
    }
    else
    {
        self.amountLabel.textColor = [UIColor colorWithUInt:0x308ac2];
    }
}

@end
