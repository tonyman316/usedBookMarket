//
//  ResetPwViewController.m
//  usedBookMarket
//
//  Created by Tony's Mac on 6/7/14.
//  Copyright (c) 2014 TonyCP. All rights reserved.
//

#import "ResetPwViewController.h"

@interface ResetPwViewController ()

@end

@implementation ResetPwViewController

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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

#pragma mark - Reset user password

- (IBAction)subBtn:(id)sender {
    
    NSString *email    = [self.userEmailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    // need some code to check it is email format.
    
    if ([email length] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Make sure you enter the Email Address!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else{
        
        [PFUser requestPasswordResetForEmailInBackground:email];
        
        self.outputLbl.text = @"Please check your INBOX and reset your password.";

        
    }

    
}

- (IBAction)cancelBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
