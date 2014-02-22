//
//  XHTopMusicPlayView.h
//  KugouMusic
//
//  Created by 曾 宪华 on 14-2-22.
//  Copyright (c) 2014年 HUAJIE. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kXHTopMediaPlayViewHeight 58

@class XHMusic;

@interface XHTopMusicPlayView : UIView

@property (nonatomic, strong) XHMusic *music;

+ (instancetype)shareTopMusicPlayView;

@end
