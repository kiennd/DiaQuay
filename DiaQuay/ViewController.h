//
//  ViewController.h
//  DiaQuay
//
//  Created by KIENND on 5/3/13.
//  Copyright (c) 2013 KIENND. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RotateGame.h"
@interface ViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *moneyStatus;
@property (weak, nonatomic) IBOutlet UITextField *betMoney;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (strong) NSTimer* timer;
@end
