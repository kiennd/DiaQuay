//
//  ViewController.m
//  DiaQuay
//
//  Created by KIENND on 5/3/13.
//  Copyright (c) 2013 KIENND. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    RotateGame* _game;
    AVAudioPlayer *_player;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) loadView
{
    [super loadView];
    _game = [[RotateGame alloc] initWithFrame:CGRectMake(5, 100, 300, 300)];
    [self.view addSubview:_game];
    
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(update) userInfo:nil repeats:YES];
    
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"backgroundMusic" ofType:@"mp3"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    NSLog(@"%@",soundFilePath);
    //_player.numberOfLoops = -1; //Infinite
    [_player play];
    _player.volume = 0.2;
    
}

- (void) update
{
    _moneyStatus.text = [NSString stringWithFormat:@"%ld",_game.money ];
}

- (IBAction)startAct:(id)sender {
    if (_game.running ==false && _betMoney.text.length>0) {
        _game.bet = [_betMoney.text longLongValue];
        [_game startGame];
    }
    if([_betMoney isFirstResponder]){
        [_betMoney resignFirstResponder];
    }
}
@end
