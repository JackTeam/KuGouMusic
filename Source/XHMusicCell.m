//
//  XHMusicCell.m
//  KugouMusic
//
//  Created by 曾 宪华 on 14-2-22.
//  Copyright (c) 2014年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
//

#import "XHMusicCell.h"
#import "XHMusic.h"

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
    self.songNameLabel.text = _music.title;
    if (_music.artworkImage)
        self.palugImageView.image = _music.artworkImage;
}

#pragma mark - life cycle

- (void)_setup {
    _palugImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _palugImageView.backgroundColor = [UIColor grayColor];
    
    _cheakImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth([[UIScreen mainScreen] bounds]) - 30, 0, 20, 20)];
    _cheakImageView.center = CGPointMake(_cheakImageView.center.x, CGRectGetMidY(self.bounds));
    _cheakImageView.image = [UIImage imageNamed:@"cheak"];
    
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
