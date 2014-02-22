//
//  XHMusic.h
//  KugouMusic
//
//  Created by 曾 宪华 on 14-2-22.
//  Copyright (c) 2014年 HUAJIE. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kXHArtworkImageWidth 50
#define kXHArtworkImageHeight 50

@interface XHMusic : NSObject

@property (nonatomic, strong) NSString *artist;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSURL *musicFileURL;
@property (nonatomic, strong) UIImage *artworkImage;

@end
