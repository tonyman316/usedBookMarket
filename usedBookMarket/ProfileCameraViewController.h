//
//  ProfileCameraViewController.h
//  usedBookMarket
//
//  Created by Tony's Mac on 6/5/14.
//  Copyright (c) 2014 TonyCP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "MBProgressHUD.h"
#import "AboutMeViewController.h"


@interface ProfileCameraViewController : UITableViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, MBProgressHUDDelegate>
{

    // NSMutableArray *allImages;
    
    MBProgressHUD *HUD;
    MBProgressHUD *refreshHUD;
}

@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *imageId;


//- (void)uploadImage:(NSData *)imageData;

@end
