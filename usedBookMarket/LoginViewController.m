//
//  LoginViewController.m
//  usedBookMarket
//
//  Created by Tony's Mac on 5/31/14.
//  Copyright (c) 2014 TonyCP. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

    
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Basic login / sign up

- (IBAction)loginBtn:(id)sender {
    NSString *username = [self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if ([username length] == 0 || [password length] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Make sure you enter the Username and Password!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else{
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
            if (error) {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Sorry!" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
            }
            else{
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            
        }];
        
    }
}


#pragma mark - Facebook login / sign up

- (IBAction)fbBtn:(id)sender {
    
    
    // Set permissions required from the facebook user account
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location",@"email"];
    
    // Login PFUser using facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
       // [_activityIndicator stopAnimating]; // Hide loading indicator
        
        if (!user)
        {
            if (!error)
            {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:@"Uh oh. The user cancelled the Facebook login." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            }
            else
            {
                NSLog(@"Uh oh. An error occurred: %@", error);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:[error description] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            }
        }
        else if (user.isNew)
        {
            NSLog(@"User with facebook signed up and logged in!");
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
            HUD = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:HUD];
            
            // Set determinate mode
            //HUD.mode = MBProgressHUDModeDeterminate;
            HUD.mode = MBProgressHUDModeIndeterminate;
            HUD.delegate = self;
            HUD.labelText = @"Uploading";
            [HUD show:YES];
            
        } else {
            NSLog(@"User with facebook logged in!");
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
            HUD = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:HUD];
            
            // Set determinate mode
            //HUD.mode = MBProgressHUDModeDeterminate;
            HUD.mode = MBProgressHUDModeIndeterminate;
            HUD.delegate = self;
            HUD.labelText = @"Uploading";
            [HUD show:YES];
        }


    }];
    
    
    
}


#pragma mark - Twitter login / sign up

- (IBAction)twitterBtn:(id)sender
{
    [PFTwitterUtils logInWithBlock:^(PFUser *user, NSError *error)
    {
        if (!user)
        {
            NSLog(@"Uh oh. The user cancelled the Twitter login.");
            return;
        } else if (user.isNew)
        {
            NSLog(@"User signed up and logged in with Twitter!");
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        } else
        {
            NSLog(@"User logged in with Twitter!");
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }];
    
}


@end





