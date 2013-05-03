//
//  RotateGame.h
//  GameRotate
//
//  Created by KIENND on 5/3/13.
//  Copyright (c) 2013 KIENND. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleRotate.h"
#import <AVFoundation/AVFoundation.h>
@interface RotateGame : UIView<AVAudioPlayerDelegate>
{
    NSMutableArray* _picTd;
    UIImageView *_dt;
    NSTimer* tm;
    CircleRotate* _c1 ;
    CircleRotate* _c2 ;
    CircleRotate* _c3 ;
    AVAudioPlayer* _player;
    AVAudioPlayer* _playerLose;
    
}
@property (assign) float v1,v2,v3,a1,a2,a3;
@property (assign) long money,bet;
@property (assign) BOOL running;
- (void) startGame;
- (void) randomVelocity;
@end
