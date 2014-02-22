//
//  XHLocalMusicViewController.m
//  KugouMusic
//
//  Created by 曾 宪华 on 14-2-22.
//  Copyright (c) 2014年 HUAJIE. All rights reserved.
//

#import "XHLocalMusicViewController.h"

#import "XHMusicCell.h"
#import "XHMusic+Provider.h"

#import "XHTopMusicPlayView.h"
#import "XHMusicPrePlaylistView.h"

@interface XHLocalMusicViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *everythingMusics;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation XHLocalMusicViewController

#pragma mark - Propertys

- (void)setEverythingMusics:(NSArray *)everythingMusics {
    _everythingMusics = everythingMusics;
    [XHMusicPrePlaylistView shareMusicPrePlaylistView].prePlayLists = self.everythingMusics;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [self.view sendSubviewToBack:_tableView];
    }
    return _tableView;
}

#pragma mark - Life cycle

- (void)_setup {
    
}

- (id)init {
    self = [super init];
    if (self) {
        [self _setup];
    }
    return self;
}

- (void)_loadEverythingMusics {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_queue_create("Load local music", NULL), ^{
        NSArray *everythingMusics = [XHMusic localLibraryMusicsWithRandom:NO];
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.everythingMusics = everythingMusics;
            [weakSelf.tableView reloadData];
        });
    });
}

- (void)_showPlayListView {
    [[XHMusicPrePlaylistView shareMusicPrePlaylistView] show];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self _loadEverythingMusics];
    [self _showPlayListView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    XHTopMusicPlayView *topMediaPlayView = [XHTopMusicPlayView shareTopMusicPlayView];
    CGRect topMediaPlayViewFrame = topMediaPlayView.frame;
    topMediaPlayViewFrame.origin.y = CGRectGetHeight(self.view.bounds) - kXHTopMediaPlayViewHeight;
    topMediaPlayView.frame = topMediaPlayViewFrame;
    [self.view addSubview:topMediaPlayView];
    
    XHMusicPrePlaylistView *playListView = [XHMusicPrePlaylistView shareMusicPrePlaylistView];
    [self.view insertSubview:playListView belowSubview:topMediaPlayView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.everythingMusics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"musicCellIdentifier";
    XHMusicCell *musicCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!musicCell) {
        musicCell = [[XHMusicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    XHMusic *music = self.everythingMusics[indexPath.row];
    musicCell.music = music;
    
    return musicCell;
}

#pragma mark - UITableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[XHTopMusicPlayView shareTopMusicPlayView] setMusic:self.everythingMusics[indexPath.row]];
}

@end
