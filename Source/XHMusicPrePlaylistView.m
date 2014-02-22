//
//  XHMusicPrePlaylistView.m
//  KugouMusic
//
//  Created by 曾 宪华 on 14-2-22.
//  Copyright (c) 2014年 HUAJIE. All rights reserved.
//

#import "XHMusicPrePlaylistView.h"

#import "XHMusic.h"

@interface XHMusicPrePlaylistView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *prePlaylistLabel;
@property (nonatomic, strong) UITableView *tableView;

@end


@implementation XHMusicPrePlaylistView

#pragma mark - Propertys

- (void)setPrePlayLists:(NSArray *)prePlayLists {
    _prePlayLists = prePlayLists;
    [self _refreshData];
}

- (void)_refreshData {
    [self _setupPlayListLabelText];
    [self.tableView reloadData];
}

- (void)_setupPlayListLabelText {
    _prePlaylistLabel.text = [NSString stringWithFormat:@"播放列表(%d)", self.prePlayLists.count];
}

- (BOOL)addSongToList:(XHMusic *)music {
    [self _refreshData];
    return 0;
}

- (void)_controlContainerViewDisplay:(BOOL)show {
    CGRect containerViewFrame = self.containerView.frame;
    CGFloat alpha = 0;
    if (show) {
        alpha = 1.;
        containerViewFrame.origin.y = CGRectGetHeight(self.bounds) - CGRectGetHeight(containerViewFrame) - 58;
    } else {
        containerViewFrame.origin.y = CGRectGetHeight(self.bounds) - 58;
    }
    
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = alpha;
        self.containerView.alpha = 1.;
        self.containerView.frame = containerViewFrame;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)show {
    [self _controlContainerViewDisplay:YES];
}

- (void)hide {
    [self _controlContainerViewDisplay:NO];
}

- (void)tapGestureRecognizerHandle:(UITapGestureRecognizer *)tapGestureRecognizer {
    [self hide];
}

- (void)_setup {
    self.alpha = 0.;
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerHandle:)];
    [self addGestureRecognizer:tapGestureRecognizer];
    
    if (!_prePlayLists) {
        _prePlayLists = [[NSArray alloc] init];
    }
    
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds) - 58, CGRectGetWidth(self.bounds), 260)];
        _containerView.backgroundColor = [UIColor whiteColor];
        _containerView.alpha = 0.;
        [self addSubview:self.containerView];
    }
    
    if (!_prePlaylistLabel) {
        _prePlaylistLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 40)];
        _prePlaylistLabel.textColor = [UIColor blackColor];
        [self _setupPlayListLabelText];
        [_containerView addSubview:self.prePlaylistLabel];
    }
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, CGRectGetWidth(self.bounds), 220) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_containerView addSubview:_tableView];
        [_containerView sendSubviewToBack:_tableView];
    }
}

+ (instancetype)shareMusicPrePlaylistView {
    static XHMusicPrePlaylistView *musicPrePlaylistView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        musicPrePlaylistView = [[XHMusicPrePlaylistView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), CGRectGetHeight([[UIScreen mainScreen] bounds]))];
    });
    return musicPrePlaylistView;
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

#pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.prePlayLists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    XHMusic *music = self.prePlayLists[indexPath.row];
    cell.textLabel.text = music.title;
    
    return cell;
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

@end
