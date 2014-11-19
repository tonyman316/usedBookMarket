//
//  AboutMeViewController.h
//  usedBookMarket
//
//  Created by Tony's Mac on 6/2/14.
//  Copyright (c) 2014 TonyCP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>



@interface AboutMeViewController : UIViewController
//{
//   IBOutlet UIImageView *profilePic;
//    UIImage *selectedImage;
//}

@property (nonatomic) int postCount;
@property (strong, nonatomic) NSString *userEmail;
@property (strong, nonatomic) NSString *userMobile;
@property (strong, nonatomic) NSString *userOther;

@property (nonatomic, strong) NSMutableData *imageData;

@property (weak, nonatomic) IBOutlet UILabel *firstLastName;
@property (strong, nonatomic) IBOutlet PFImageView *profilePic;

- (IBAction)showActionSheet:(id)sender;

- (IBAction)logoutBtn:(id)sender;


@end
