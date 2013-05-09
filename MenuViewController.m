//
//  MenuViewController.m
//  DiaQuay
//
//  Created by KIENND on 5/4/13.
//  Copyright (c) 2013 KIENND. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()
{
    IBOutlet UIButton *newGameButton;
}
@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)newGameAct:(id)sender {
    NSLog(@"abc");
    
    ViewController* gameVC =  [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];

    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1];
        [self.navigationController pushViewController:gameVC animated:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];        
        [UIView commitAnimations];

    
}

- (IBAction)aboutAct:(id)sender {
}
@end
