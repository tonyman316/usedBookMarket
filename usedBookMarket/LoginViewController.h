//
//  LoginViewController.h
//  usedBookMarket
//
//  Created by Tony's Mac on 5/31/14.
//  Copyright (c) 2014 TonyCP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "MBProgressHUD.h"
//#import <SimpleAuth/SimpleAuth.h>


@interface LoginViewController : UIViewController <MBProgressHUDDelegate>

{
    MBProgressHUD *HUD;
}
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;


- (IBAction)loginBtn:(id)sender;

- (IBAction)fbBtn:(id)sender;
- (IBAction)twitterBtn:(id)sender;




@end
