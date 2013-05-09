//
//  CycleRotate.m
//  GameRotate
//
//  Created by KIENND on 5/3/13.
//  Copyright (c) 2013 KIENND. All rights reserved.
//

#import "CircleRotate.h"
AVAudioPlayer* _player;
@implementation CircleRotate
int _last;
- (id)initWithFrame:(CGRect)frame
          imageName:(NSString*) imgName
           velocity:(float) velocity
       acceleration:(float) acceleration
{
    self = [super initWithFrame:frame];
    if (self) {
        _last = 0;
        _res = 1000;
        
        // Initialization code
        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"button1" ofType:@"wav"];

        NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
        
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
        
        _player.numberOfLoops = 0;

        _acceleration1 = acceleration;
        _velocity1 = velocity;
        
        
        _circle1 =  [[UIImageView alloc] initWithFrame:self.bounds];
        _circle1.image = [UIImage imageNamed:imgName];
        NSLog(@"imgname :%@",imgName);
        _circle1.backgroundColor =  [UIColor clearColor];
        [self addSubview:_circle1];
        
    }
    return self;
}



- (void) rotate:(float) degree
          image: (UIImageView*) uim
{
    _last+=degree;

    if (_last >= 45) {

        _last -= 45;
        if ([_player isPlaying] == false) {
            [_player play];
        }
    }

    CGFloat radians = atan2f(uim.transform.b, uim.transform.a);
    uim.transform = CGAffineTransformMakeRotation(radians+_dimensional* degree*M_PI/180.0);
}

- (void) start
{
    
    if (_velocity1<0) {
        _dimensional = -1;
        _velocity1*=-1;
    }else{
        _dimensional = 1;
    }
    _tm = [NSTimer scheduledTimerWithTimeInterval:0.01
                                           target:self
                                         selector:@selector(changeVelocity)
                                         userInfo:nil
                                          repeats:YES
           ];
    [self rotate:_velocity1 image:_circle1];
    
}

- (void) changeVelocity
{
    
    if (_velocity1>=0.7) {
                _velocity1-=_acceleration1/10;
        [self rotate:_velocity1 image:_circle1];
    }else{
        CGFloat radians = atan2f(_circle1.transform.b, _circle1.transform.a);
        int degree = radians*180.0/M_PI;
        if (degree%45!=0) {
            [self rotate:0.7 image:_circle1];
        }else{
            NSLog(@"done %d",degree);
            _res =degree;
            [_player play];
            [_tm invalidate];
        }
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
