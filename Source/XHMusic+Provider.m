//
//  XHMusic+Provider.m
//  KugouMusic
//
//  Created by 曾 宪华 on 14-2-22.
//  Copyright (c) 2014年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
//

#import "XHMusic+Provider.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation XHMusic (Provider)

+ (NSArray *)boundleMusics {
    static NSArray *musics = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableArray *allMusics = [NSMutableArray array];
        XHMusic *music = [[XHMusic alloc] init];
        music.artist = nil;
        music.title = @"情非得已";
        music.musicFileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"情非得已" ofType:@"mp3"]];
        music.artworkImage = [UIImage imageNamed:@"thumb"];
        [allMusics addObject:music];
        
        musics = [allMusics copy];
    });
    return musics;
}

+ (NSArray *)localLibraryMusicsWithRandom:(BOOL)isRandom {
    static NSArray *musics = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableArray *allMusics = [NSMutableArray array];
        for (MPMediaItem *item in [[MPMediaQuery songsQuery] items]) {
            if ([[item valueForProperty:MPMediaItemPropertyIsCloudItem] boolValue]) {
                continue;
            }
            
            XHMusic *music = [[XHMusic alloc] init];
            music.artist = [item valueForProperty:MPMediaItemPropertyArtist];
            music.title = [item valueForProperty:MPMediaItemPropertyTitle];
            music.musicFileURL = [item valueForProperty:MPMediaItemPropertyAssetURL];
            MPMediaItemArtwork *artwork =
            [item valueForProperty: MPMediaItemPropertyArtwork];
            UIImage *artworkImage =
            [artwork imageWithSize:CGSizeMake(kXHArtworkImageWidth, kXHArtworkImageHeight)];
            if (!artworkImage) {
                artworkImage = [UIImage imageNamed:@"thumb"];
            }
            music.artworkImage = artworkImage;
            [allMusics addObject:music];
        }
        
        if (isRandom) {
            for (NSUInteger i = 0; i < [allMusics count]; ++i) {
                NSUInteger j = arc4random_uniform((u_int32_t)[allMusics count]);
                [allMusics exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
        
        musics = [allMusics copy];
    });
    
    return musics;
}

@end
