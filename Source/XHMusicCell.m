//
//  XHMusicCell.m
//  KugouMusic
//
//  Created by 曾 宪华 on 14-2-22.
//  Copyright (c) 2014年 HUAJIE. All rights reserved.
//

#import "XHMusicCell.h"

@interface XHMusicCell ()

@property (nonatomic, strong) UIImageView *palugImageView;
@property (nonatomic, strong) UILabel *songNameLabel;
@property (nonatomic, strong) UIImageView *cheakImageView;

@end

@implementation XHMusicCell

#pragma mark - Propertys

- (void)setMusic:(XHMusic *)music {
    if (_music == music)
        return;
    _music = music;
    // todo
}

#pragma mark - life cycle

- (void)_setup {
    _palugImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _palugImageView.backgroundColor = [UIColor grayColor];
    
    _cheakImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth([[UIScreen mainScreen] bounds]) - 30, 0, 30, 30)];
    _cheakImageView.backgroundColor = [UIColor redColor];
    
    _songNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_palugImageView.frame), 0, CGRectGetWidth([[UIScreen mainScreen] bounds]) - CGRectGetWidth(_palugImageView.frame) - CGRectGetWidth(_cheakImageView.frame), 30)];
    
    [self.contentView addSubview:self.palugImageView];
    [self.contentView addSubview:self.cheakImageView];
    [self.contentView addSubview:self.songNameLabel];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self _setup];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
