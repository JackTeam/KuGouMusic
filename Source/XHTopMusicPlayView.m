//
//  XHTopMusicPlayView.m
//  KugouMusic
//
//  Created by 曾 宪华 on 14-2-22.
//  Copyright (c) 2014年 HUAJIE. All rights reserved.
//

#import "XHTopMusicPlayView.h"

#import "XHMusic.h"

@interface XHTopMusicPlayView ()

@property (nonatomic, strong) UIImageView *thumbImageView;
@property (nonatomic, strong) UILabel *songNameLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UILabel *timekeepingLabel;
@property (nonatomic, strong) UIProgressView *songPlaybackProgress;
@property (nonatomic, strong) UIButton *songControlButton;
@property (nonatomic, strong) UIButton *nextSongButton;

@end

@implementation XHTopMusicPlayView

#pragma mark - Propertys

- (void)setMusic:(XHMusic *)music {
    if (_music == music)
        return;
    _music = music;
    // todo
    self.songNameLabel.text = _music.title;
    self.thumbImageView.image = _music.artworkImage;
}

#pragma mark - life cycle

- (void)_setup {
    self.backgroundColor = [UIColor blackColor];
    
    CGFloat thumbImageViewPadding = 3;
    CGFloat thumbImageViewSize = CGRectGetHeight(self.bounds) - (thumbImageViewPadding * 2);
    _thumbImageView = [[UIImageView alloc] initWithFrame:CGRectMake(thumbImageViewPadding, thumbImageViewPadding, thumbImageViewSize, thumbImageViewSize)];
    _thumbImageView.backgroundColor = [UIColor grayColor];
    
    CGFloat songNameLabelPaddingX = 8;
    
    CGFloat buttonPadding = 15;
    CGFloat buttonWidth = 25;
    
    CGFloat songNameLabelX = CGRectGetMaxX(_thumbImageView.frame) + songNameLabelPaddingX;
    _songNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(songNameLabelX, thumbImageViewPadding, CGRectGetWidth(self.bounds) - songNameLabelX - buttonWidth * 3.3 - buttonPadding, 25)];
    _songNameLabel.font = [UIFont systemFontOfSize:15.0f];
    _songNameLabel.textColor = [UIColor whiteColor];
    _songNameLabel.text = @"Download the web image not cache to local. 3 days ago";
    
    _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_songNameLabel.frame.origin.x, CGRectGetMaxY(_songNameLabel.frame), 15, 15)];
    _arrowImageView.backgroundColor = [UIColor cyanColor];
    
    _timekeepingLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_arrowImageView.frame) + thumbImageViewPadding, _arrowImageView.frame.origin.y, 100, 20)];
    _timekeepingLabel.font = [UIFont systemFontOfSize:11.0f];
    _timekeepingLabel.textColor = [UIColor whiteColor];
    _timekeepingLabel.text = @"00:02 | 03:54";
    
    _songPlaybackProgress = [[UIProgressView alloc] initWithFrame:CGRectMake(_songNameLabel.frame.origin.x, CGRectGetMaxY(_timekeepingLabel.frame), CGRectGetWidth(self.bounds) - songNameLabelX - thumbImageViewPadding, 2)];
    
    CGFloat ControlButtonPaddingY = 15;
    _songControlButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_songNameLabel.frame) + buttonPadding, ControlButtonPaddingY, buttonWidth, buttonWidth)];
    _songControlButton.backgroundColor = [UIColor whiteColor];
    _songControlButton.showsTouchWhenHighlighted = YES;
    
    CGRect nextSongButtonFrame = _songControlButton.frame;
    nextSongButtonFrame.origin.x += buttonPadding + CGRectGetWidth(nextSongButtonFrame);
    _nextSongButton = [[UIButton alloc] initWithFrame:nextSongButtonFrame];
    _nextSongButton.backgroundColor = [UIColor whiteColor];
    _nextSongButton.showsTouchWhenHighlighted = YES;
    
    [self addSubview:self.thumbImageView];
    [self addSubview:self.songNameLabel];
    
    [self addSubview:self.arrowImageView];
    [self addSubview:self.timekeepingLabel];
    [self addSubview:self.songPlaybackProgress];
    
    [self addSubview:self.songControlButton];
    [self addSubview:self.nextSongButton];
}

+ (instancetype)shareTopMusicPlayView {
    static XHTopMusicPlayView *topMusicPlayView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        topMusicPlayView = [[XHTopMusicPlayView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), kXHTopMediaPlayViewHeight)];
    });
    return topMusicPlayView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _setup];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
