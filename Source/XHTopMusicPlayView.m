//
//  XHTopMusicPlayView.m
//  KugouMusic
//
//  Created by 曾 宪华 on 14-2-22.
//  Copyright (c) 2014年 HUAJIE. All rights reserved.
//

#import "XHTopMusicPlayView.h"

@implementation XHTopMusicPlayView

#pragma mark - Propertys

- (void)setMusic:(XHMusic *)music {
    if (_music == music)
        return;
    _music = music;
    // todo
}

#pragma mark - life cycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
