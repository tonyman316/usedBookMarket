//
//  PostCameraViewController.h
//  usedBookMarket
//
//  Created by Tony's Mac on 6/7/14.
//  Copyright (c) 2014 TonyCP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostCameraViewController : UITableViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePicker;

@end
