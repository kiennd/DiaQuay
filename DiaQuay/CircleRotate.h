//
//  CycleRotate.h
//  GameRotate
//
//  Created by KIENND on 5/3/13.
//  Copyright (c) 2013 KIENND. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface CircleRotate : UIView
{
    
}

@property (strong) UIImageView* circle1;
@property (strong) NSTimer* tm;
@property (assign) int dimensional;
@property (assign) float acceleration1;
@property (assign) float velocity1;
@property (assign) int res;

- (id)initWithFrame:(CGRect)frame
          imageName:(NSString*) imgName
           velocity:(float) velocity
       acceleration:(float) acceleration;
- (void) start;

@end
