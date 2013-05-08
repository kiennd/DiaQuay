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
        
        
        
        soundFilePath = [[NSBundle mainBundle] pathForResource:@"coins-charg" ofType:@"mp3"];
        soundFileURL = [NSURL fileURLWithPath:soundFilePath];
        _playerCoinCharg =[[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
        
        _running =false;
        NSString* path = [[NSBundle mainBundle] pathForResource:@"money"
                                                         ofType:@"txt"];
        NSString* money =  [NSString stringWithContentsOfFile:path
                                                     encoding:NSUTF8StringEncoding
                                                        error:nil];
        
        _money =[money longLongValue];
        _bet = malloc(sizeof(int)*9);
        _picTd = [[NSMutableArray alloc] initWithObjects: nil];
        for (int i=1; i<=5; i++) {
            [_picTd addObject:[UIImage imageNamed:[NSString stringWithFormat:@"td%d.png",i]]];
        }
        _c1 = [[CircleRotate alloc] initWithFrame:self.bounds imageName:@"lv1" velocity:_v1 acceleration:_a1];
        _c2 = [[CircleRotate alloc] initWithFrame:self.bounds imageName:@"lv2" velocity:_v2 acceleration:_a2];
        _c3 = [[CircleRotate alloc] initWithFrame:self.bounds imageName:@"lv3" velocity:_v3 acceleration:_a3];
        _dt =  [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y-30, self.bounds.size.width, self.bounds.size.height+30)];
        
        _dt.image = _picTd[0];

        [self addSubview:_c1];
        
        [self addSubview:_c2];
        [self addSubview:_c3];
        [self addSubview:_dt];        
        tm = [NSTimer scheduledTimerWithTimeInterval:1
                                              target:self
                                            selector:@selector(changeTd)
                                            userInfo:nil
                                             repeats:YES
              ];
        
        // Initialization code
    }
    return self;
}

- (void) randomVelocity
{
    _c1.res = 1000;
    _c2.res = 1000;
    _c3.res = 1000;
    _v1= (arc4random()%50+80.0)/100.0*36.0;
    _v2= (arc4random()%50+80.0)/100.0*36.0*-1;
    _v3= (arc4random()%50+80.0)/100.0*36.0;
    
    _a1= (arc4random()%50+50.0)/100.0;
    _a2= (arc4random()%50+50.0)/100.0;
    _a3= (arc4random()%50+50.0)/100.0;
    
    
    _c1.velocity1 = _v1;
    _c1.acceleration1 = _a1;
    //_c2.velocity1 = _v2;
    _c2.velocity1 = -((float)_v1/_a1)*_a2;
    _c2.acceleration1 = _a2;
    //_c3.velocity1 = _v3;
    _c3.velocity1 = ((float)_v1/_a1)*_a3;
    _c3.acceleration1 = _a3;
    
}

- (void) startGame
{
    _running =true;
    [self randomVelocity];
    [_c1 start];
    [_c2 start];
    [_c3 start];
}

- (void) setBet:(int *)bet loc:(int) vt{
    _bet[vt] = bet;
}

- (void) changeTd
{

    [UIView animateWithDuration:1 animations:^{
        _dt.image = _picTd[arc4random()%5];
        
    }completion:^(BOOL finished) {
    }];

    /*
    [UIView animateWithDuration:2 delay:2 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _dt.image = _picTd[arc4random()%5];
        
    }completion:^(BOOL finished){
        [self changeTd];
    }];*/
        //    NSLog(@"%d, %d, %d",_c3.res,_c2.res,_c1.res);
    if (_c3.res !=1000 && _c1.res!=1000 && _c2.res!=1000) {
        _c1.res=-1*_c1.res/45;
        _c2.res=-1*_c2.res/45;
        _c3.res=-1*_c3.res/45;
        if (_c1.res <0 ) {
            _c1.res +=8;
        }
        if (_c2.res <0 ) {
            _c2.res +=8;
        }
        if (_c3.res <0 ) {
            _c3.res +=8;
        }
        NSLog(@"res  %d, %d, %d",_c3.res,_c2.res,_c1.res);
        
        long res=0;
        int dem = 0;
        for (int i=0; i<8; i++) {
            if (i==_c1.res) {
                res+=2*_bet[i];
                dem++;
                NSLog(@"add %d",_bet[i]);
            }else{
                res-=_bet[i];
            }
            if (i==_c2.res) {
                dem++;
                res+=(dem+2)*_bet[i];
                NSLog(@"add %d",_bet[i]);
            }else{
                res-=_bet[i];
            }
            if (i==_c3.res) {
                dem++;
                res+=(dem+2)*_bet[i];
                NSLog(@"add %d",_bet[i]);
            }else{
                res-=_bet[i];
            }
        
        }
        
        if (res<0) {
            _money += res;
            [_playerLose play];
            
        }else{
            _money+=res;
            [_player play];
        }
        NSString* path = [[NSBundle mainBundle] pathForResource:@"money"
                                                         ofType:@"txt"];
        NSLog(@"path = %@",path);
        NSString* tofile = [NSString stringWithFormat:@"%ld",_money];
        NSLog(@"%ld %@",_money,tofile);
        [tofile writeToFile:path atomically:NO encoding:NSUTF8StringEncoding error:nil];
        
        _c3.res = 1000;
        _c2.res = 1000;
        _c1.res = 1000;
        _running =false;
    }

    
}
- (void) napTien{
    _money +=100000;
    NSString* path = [[NSBundle mainBundle] pathForResource:@"money"
                                                     ofType:@"txt"];
    NSLog(@"path = %@",path);
    NSString* tofile = [NSString stringWithFormat:@"%ld",_money];
    NSLog(@"%ld %@",_money,tofile);
    [tofile writeToFile:path atomically:NO encoding:NSUTF8StringEncoding error:nil];
    UIAlertView * al =  [[UIAlertView alloc] initWithTitle:@"Nap tien" message:@"Nap tien thanh cong" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [al show];
    [_playerCoinCharg play];
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
