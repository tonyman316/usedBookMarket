//
//  ResetPwViewController.h
//  usedBookMarket
//
//  Created by Tony's Mac on 6/7/14.
//  Copyright (c) 2014 TonyCP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ResetPwViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userEmailField;
@property (weak, nonatomic) IBOutlet UILabel *outputLbl;

- (IBAction)subBtn:(id)sender;
- (IBAction)cancelBtn:(id)sender;


@end
