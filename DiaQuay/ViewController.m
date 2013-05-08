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
    AVAudioPlayer *_player2;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
}
- (void) viewDidDisappear:(BOOL)animated
{
    [_player stop];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
- (void) loadView
{
    [super loadView];
    _game = [[RotateGame alloc] initWithFrame:CGRectMake(5, 200, 305, 305)];
    _betMoneyVal = malloc(sizeof(int)*10);
    for (int i = 0; i<10; i++) {
        _betMoneyVal[i] = 0 ;
    }
    [self.view addSubview:_game];

    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(update) userInfo:nil repeats:YES];
    
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"backgroundMusic" ofType:@"mp3"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    _player.numberOfLoops = 10; //Infinite
    [_player play];
    _player.volume = 0.2;
        
    
    
    [_startBtn setBackgroundImage:[UIImage imageNamed:@"start" ] forState:UIControlStateNormal];
    [_exitBtn setBackgroundImage:[UIImage imageNamed:@"exit" ] forState:UIControlStateNormal];
    [_moneyAdd setBackgroundImage:[UIImage imageNamed:@"addMoney" ] forState:UIControlStateNormal];
    [_addBetBtn setBackgroundImage:[UIImage imageNamed:@"addbet" ] forState:UIControlStateNormal];
    [_subtractBetBtn setBackgroundImage:[UIImage imageNamed:@"subtractbet" ] forState:UIControlStateNormal];
    [_addBetBtn1 setBackgroundImage:[UIImage imageNamed:@"addbet" ] forState:UIControlStateNormal];
    [_subtractBetBtn1 setBackgroundImage:[UIImage imageNamed:@"subtractbet" ] forState:UIControlStateNormal];
    [_addBetBtn2 setBackgroundImage:[UIImage imageNamed:@"addbet" ] forState:UIControlStateNormal];
    [_subtractBetBtn2 setBackgroundImage:[UIImage imageNamed:@"subtractbet" ] forState:UIControlStateNormal];
    [_addBetBtn3 setBackgroundImage:[UIImage imageNamed:@"addbet" ] forState:UIControlStateNormal];
    [_subtractBetBtn3 setBackgroundImage:[UIImage imageNamed:@"subtractbet" ] forState:UIControlStateNormal];
    [_addBetBtn4 setBackgroundImage:[UIImage imageNamed:@"addbet" ] forState:UIControlStateNormal];
    [_subtractBetBtn4 setBackgroundImage:[UIImage imageNamed:@"subtractbet" ] forState:UIControlStateNormal];
    [_addBetBtn5 setBackgroundImage:[UIImage imageNamed:@"addbet" ] forState:UIControlStateNormal];
    [_subtractBetBtn5 setBackgroundImage:[UIImage imageNamed:@"subtractbet" ] forState:UIControlStateNormal];
    [_addBetBtn6 setBackgroundImage:[UIImage imageNamed:@"addbet" ] forState:UIControlStateNormal];
    [_subtractBetBtn6 setBackgroundImage:[UIImage imageNamed:@"subtractbet" ] forState:UIControlStateNormal];
    [_addBetBtn7 setBackgroundImage:[UIImage imageNamed:@"addbet" ] forState:UIControlStateNormal];
    [_subtractBetBtn7 setBackgroundImage:[UIImage imageNamed:@"subtractbet" ] forState:UIControlStateNormal];
    [self.view bringSubviewToFront:_exitBtn];
    [self.view bringSubviewToFront:_moneyAdd];
    [self loadBetLabel];
}

- (void) loadBetLabel{
    _betMoney = [[NSMutableArray alloc] initWithObjects: nil];
    int y = 28;
    for (int i=1; i<=8; i+=2) {
        UILabel *lb1,*lb2;
        lb1 = [[UILabel alloc] initWithFrame:CGRectMake(72, y, 80, 20)];
        lb1.text = @"0  0  0";
        [_betMoney addObject:lb1];
        lb2 = [[UILabel alloc] initWithFrame:CGRectMake(232, y, 80, 20)];
        [_betMoney addObject:lb2];
        lb2.text = @"0  0  0";
        y+=43;
        lb1.backgroundColor = [UIColor clearColor];
        lb2.backgroundColor = [UIColor clearColor];
        [self.view addSubview:lb1];
        [self.view addSubview:lb2];
    }
}

- (void) update
{
    _moneyStatus.text = [NSString stringWithFormat:@"%ld",_game.money ];
}

- (void) setbetMoneyText:(int) betMoney idLabel:(int) idlb{
    NSMutableString* betText = [[NSMutableString alloc] initWithString:@""];
    int a1,a2,a3;
    a1 = betMoney/100;
    betMoney%=100;
    a2 = betMoney/10;
    betMoney%=10;
    a3 = betMoney;
    [betText appendFormat:@"%d  %d  %d",a1,a2,a3];
    UILabel* betmoney = _betMoney[idlb];
    betmoney.text = betText;
}

- (IBAction)startAct:(id)sender {
    if (_game.running ==false) {
        
        for (int i=0; i<=7; i++) {
            [_game setBet:_betMoneyVal[i] loc:i];
        }
        
        [_game startGame];
        _game.running = true;
    }
}
- (IBAction)exitAct:(id)sender {
    if (_game.running == false) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        UIAlertView* al =  [[UIAlertView alloc] initWithTitle:@"Game is running" message:@"please wait" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [al show];
    }

}
- (IBAction)addMoney:(id)sender {
    [_game napTien];
}
- (IBAction)subtractBet:(id)sender {
    UIButton* bt = sender;
    NSLog(@"- %d",bt.tag);
    if (_betMoneyVal[bt.tag - 1]>0) {
        _betMoneyVal[bt.tag - 1] -=10;
        [self setbetMoneyText:_betMoneyVal[bt.tag - 1] idLabel:bt.tag - 1];
        NSString* soundFilePath = [[NSBundle mainBundle] pathForResource:@"coin-change" ofType:@"mp3"];
        NSURL* soundFileURL = [NSURL fileURLWithPath:soundFilePath];
        _player2 = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
        
        [_player2 play];
    }

}
- (IBAction)addBet:(id)sender {
    UIButton* bt = sender;
    NSLog(@"- %d",bt.tag);
    if (_betMoneyVal[bt.tag%10 - 1]<990) {
        _betMoneyVal[bt.tag%10 - 1] +=10;
        [self setbetMoneyText:_betMoneyVal[bt.tag%10 - 1] idLabel:bt.tag%10 - 1];
        NSString* soundFilePath = [[NSBundle mainBundle] pathForResource:@"coin-change" ofType:@"mp3"];
        NSURL* soundFileURL = [NSURL fileURLWithPath:soundFilePath];
        _player2 = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
        [_player2 play];
    }}

@end
