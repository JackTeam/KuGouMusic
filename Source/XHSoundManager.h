//
//  XHSoundManager.h
//  KugouMusic
//
//  Created by 曾 宪华 on 14-2-23.
//  Copyright (c) 2014年 HUAJIE. All rights reserved.
//
#ifndef XH_RETAIN
#if __has_feature(objc_arc)
#define XH_RETAIN(x) (x)
#define XH_RELEASE(x) (void)(x)
#define XH_AUTORELEASE(x) (x)
#define XH_SUPER_DEALLOC (void)(0)
#define __XH_BRIDGE __bridge
#else
#define __XH_WEAK
#define XH_WEAK assign
#define XH_RETAIN(x) [(x) retain]
#define XH_RELEASE(x) [(x) release]
#define XH_AUTORELEASE(x) [(x) autorelease]
#define XH_SUPER_DEALLOC [super dealloc]
#define __XH_BRIDGE
#endif
#endif

//  ARC Helper ends


#import <Availability.h>
#if defined(__IPHONE_OS_VERSION_MAX_ALLOWED)
#import <UIKit/UIKit.h>
#define XH_USE_AV_AUDIO_PLAYER
#else
#import <Cocoa/Cocoa.h>
#if __MAC_OS_X_VERSION_MIN_REQUIRED > __MAC_10_6
#define XH_USE_AV_AUDIO_PLAYER
#endif
#endif


#ifdef XH_USE_AV_AUDIO_PLAYER
#import <AVFoundation/AVFoundation.h>
#define XH_SOUND AVAudioPlayer
#else
#define XH_SOUND NSSound
#endif


#import <Foundation/Foundation.h>

extern NSString *const SoundDidFinishPlayingNotification;


typedef void (^SoundCompletionHandler)(BOOL didFinish);

@interface Sound : NSObject

//required for 32-bit Macs
#ifdef __i386__
{
@private
    
    float baseVolume;
    float startVolume;
    float targetVolume;
    NSTimeInterval fadeTime;
    NSTimeInterval fadeStart;
    NSTimer *timer;
    Sound *selfReference;
    NSURL *url;
    XH_SOUND *sound;
    SoundCompletionHandler completionHandler;
}
#endif

+ (Sound *)soundNamed:(NSString *)name;
+ (Sound *)soundWithContentsOfFile:(NSString *)path;
- (Sound *)initWithContentsOfFile:(NSString *)path;
+ (Sound *)soundWithContentsOfURL:(NSURL *)url;
- (Sound *)initWithContentsOfURL:(NSURL *)url;

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, strong) NSURL *url;
@property (nonatomic, readonly, getter = isPlaying) BOOL playing;
@property (nonatomic, assign, getter = isLooping) BOOL looping;
@property (nonatomic, copy) SoundCompletionHandler completionHandler;
@property (nonatomic, assign) float baseVolume;
@property (nonatomic, assign) float volume;

- (void)fadeTo:(float)volume duration:(NSTimeInterval)duration;
- (void)fadeIn:(NSTimeInterval)duration;
- (void)fadeOut:(NSTimeInterval)duration;
- (void)play;
- (void)stop;

@end

@interface XHSoundManager : NSObject
//required for 32-bit Macs
#ifdef __i386__
{
@private
    
    Sound *currentMusic;
    NSMutableArray *currentSounds;
    BOOL allowsBackgroundMusic;
    float soundVolume;
    float musicVolume;
    NSTimeInterval soundFadeDuration;
    NSTimeInterval musicFadeDuration;
}
#endif

@property (nonatomic, readonly, getter = isPlayingMusic) BOOL playingMusic;
@property (nonatomic, assign) BOOL allowsBackgroundMusic;
@property (nonatomic, assign) float soundVolume;
@property (nonatomic, assign) float musicVolume;
@property (nonatomic, assign) NSTimeInterval soundFadeDuration;
@property (nonatomic, assign) NSTimeInterval musicFadeDuration;

+ (instancetype)sharedSoundManager;

- (void)prepareToPlayWithSound:(id)soundOrName;
- (void)prepareToPlay;

- (void)playMusic:(id)soundOrName looping:(BOOL)looping fadeIn:(BOOL)fadeIn;
- (void)playMusic:(id)soundOrName looping:(BOOL)looping;
- (void)playMusic:(id)soundOrName;

- (void)stopMusic:(BOOL)fadeOut;
- (void)stopMusic;

- (void)playSound:(id)soundOrName looping:(BOOL)looping fadeIn:(BOOL)fadeIn;
- (void)playSound:(id)soundOrName looping:(BOOL)looping;
- (void)playSound:(id)soundOrName;

- (void)stopSound:(id)soundOrName fadeOut:(BOOL)fadeOut;
- (void)stopSound:(id)soundOrName;
- (void)stopAllSounds:(BOOL)fadeOut;
- (void)stopAllSounds;

@end
