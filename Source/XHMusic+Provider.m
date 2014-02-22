//
//  XHMusic+Provider.m
//  KugouMusic
//
//  Created by 曾 宪华 on 14-2-22.
//  Copyright (c) 2014年 HUAJIE. All rights reserved.
//

#import "XHMusic+Provider.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation XHMusic (Provider)

+ (NSArray *)localLibraryMusicsWithRandom:(BOOL)isRandom {
    static NSArray *musics = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableArray *allTracks = [NSMutableArray array];
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
                artworkImage = [UIImage imageNamed:@"musicCover"];
            }
            music.artworkImage = artworkImage;
            [allTracks addObject:music];
        }
        
        if (isRandom) {
            for (NSUInteger i = 0; i < [allTracks count]; ++i) {
                NSUInteger j = arc4random_uniform((u_int32_t)[allTracks count]);
                [allTracks exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
        
        musics = [allTracks copy];
    });
    
    return musics;
}

@end
