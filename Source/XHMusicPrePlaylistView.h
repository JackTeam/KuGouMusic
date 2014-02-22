//
//  XHMusicPrePlaylistView.h
//  KugouMusic
//
//  Created by 曾 宪华 on 14-2-22.
//  Copyright (c) 2014年 HUAJIE. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XHMusic;

@interface XHMusicPrePlaylistView : UIView

@property (nonatomic, strong) NSArray *prePlayLists;

+ (instancetype)shareMusicPrePlaylistView;

- (void)show;
- (void)hide;

- (BOOL)addSongToList:(XHMusic *)music;

@end
