//
//  AddNewPostViewController.h
//  usedBookMarket
//
//  Created by Tony's Mac on 6/1/14.
//  Copyright (c) 2014 TonyCP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "ProfileCameraViewController.h"

@interface AddNewPostViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *categoryField;
@property (weak, nonatomic) IBOutlet UITextField *bookNameField;
@property (weak, nonatomic) IBOutlet UITextField *authorField;
@property (weak, nonatomic) IBOutlet UITextField *priceField;

@property (weak, nonatomic) IBOutlet UISegmentedControl *conditionSegment;

- (IBAction)submitBtn:(id)sender;

@end
