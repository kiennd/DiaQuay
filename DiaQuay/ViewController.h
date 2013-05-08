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
@property (weak, nonatomic) IBOutlet UIButton *exitBtn;
@property (strong) NSMutableArray *betMoney;
@property (weak, nonatomic) IBOutlet UIButton *subtractBetBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBetBtn;
@property (weak, nonatomic) IBOutlet UIButton *subtractBetBtn1;
@property (weak, nonatomic) IBOutlet UIButton *addBetBtn1;
@property (weak, nonatomic) IBOutlet UIButton *subtractBetBtn2;
@property (weak, nonatomic) IBOutlet UIButton *addBetBtn2;
@property (weak, nonatomic) IBOutlet UIButton *subtractBetBtn3;
@property (weak, nonatomic) IBOutlet UIButton *addBetBtn3;
@property (weak, nonatomic) IBOutlet UIButton *subtractBetBtn4;
@property (weak, nonatomic) IBOutlet UIButton *addBetBtn4;
@property (weak, nonatomic) IBOutlet UIButton *subtractBetBtn5;
@property (weak, nonatomic) IBOutlet UIButton *addBetBtn5;
@property (weak, nonatomic) IBOutlet UIButton *subtractBetBtn6;
@property (weak, nonatomic) IBOutlet UIButton *addBetBtn6;
@property (weak, nonatomic) IBOutlet UIButton *subtractBetBtn7;
@property (weak, nonatomic) IBOutlet UIButton *addBetBtn7;
@property (assign) int *betMoneyVal;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (strong) NSTimer* timer;
@property (weak, nonatomic) IBOutlet UIButton *moneyAdd;
@end
