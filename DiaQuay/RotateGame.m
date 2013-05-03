//
//  RotateGame.m
//  GameRotate
//
//  Created by KIENND on 5/3/13.
//  Copyright (c) 2013 KIENND. All rights reserved.
//

#import "RotateGame.h"

@implementation RotateGame


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"tada" ofType:@"mp3"];
        NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
        NSLog(@"%@",soundFilePath);
        _player.numberOfLoops = 0; //Infinite
        
        soundFilePath = [[NSBundle mainBundle] pathForResource:@"lose" ofType:@"mp3"];
        soundFileURL = [NSURL fileURLWithPath:soundFilePath];
        _playerLose = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
        _playerLose.numberOfLoops = 0; //Infinite
        
        
        
        _running =false;
        _money =1000000;
        _bet = 0;
        _picTd = [[NSMutableArray alloc] initWithObjects: nil];
        for (int i=1; i<=5; i++) {
            [_picTd addObject:[UIImage imageNamed:[NSString stringWithFormat:@"td%d.png",i]]];
        }
        _c1 = [[CircleRotate alloc] initWithFrame:self.bounds imageName:@"lv1" velocity:_v1 acceleration:_a1];
        _c2 = [[CircleRotate alloc] initWithFrame:self.bounds imageName:@"lv2" velocity:_v2 acceleration:_a2];
        _c3 = [[CircleRotate alloc] initWithFrame:self.bounds imageName:@"lv3" velocity:_v3 acceleration:_a3];
        _dt =  [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y-30, self.bounds.size.width, self.bounds.size.height+30)];
        
        _dt.image = _picTd[0];
        [self addSubview:_dt];
        [self addSubview:_c1];
        [self addSubview:_c3];
        [self addSubview:_c2];
        // Initialization code
    }
    return self;
}

- (void) startGame
{
    _running =true;
    _c1.res = 1000;
    _c2.res = 1000;
    _c3.res = 1000;
    _v1= (arc4random()%50+50.0)/100.0*36.0;
    _v2= (arc4random()%50+50.0)/100.0*36.0*-1;
    _v3= (arc4random()%50+50.0)/100.0*36.0;

    _a1= (arc4random()%50+50.0)/100.0;
    _a2= (arc4random()%50+50.0)/100.0;
    _a3= (arc4random()%50+50.0)/100.0;
    
    
    [tm invalidate];
    tm = [NSTimer scheduledTimerWithTimeInterval:1
                                                   target:self
                                                 selector:@selector(changeTd)
                                                 userInfo:nil
                                                  repeats:YES
                   ];
    _c1.velocity1 = _v1;
    _c1.acceleration1 = _a1;
    _c2.velocity1 = _v2;
    _c2.acceleration1 = _a2;
    _c3.velocity1 = _v3;
    _c3.acceleration1 = _a3;
    
    [_c1 start];
    [_c2 start];
    [_c3 start];
}

- (void) changeTd
{

    [UIView animateWithDuration:1 animations:^{
        _dt.image = _picTd[arc4random()%5];
        
    }completion:^(BOOL finished) {
 
    }];

            NSLog(@"%d, %d, %d",_c3.res,_c2.res,_c1.res);
    if (_c3.res !=1000 && _c1.res!=1000 && _c2.res!=1000) {
        NSLog(@"res  %d, %d, %d",_c3.res,_c2.res,_c1.res);
        if (_c3.res!=_c2.res && _c2.res!= _c1.res && _c3.res!=_c1.res) {
            _money -= _bet;
            [_playerLose play];
            
        }else{
            if (_c3.res == _c2.res ==_c1.res) {
                _money+= (3*_bet);
                [_player play];
            }else{
                _money+=(2*_bet);
                [_player play];
            }
            
        }
        _c3.res = 1000;
        _c2.res = 1000;
        _c1.res = 1000;
        _running =false;
    }

    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
