//
//  searchDetailViewController.h
//  usedBookMarket
//
//  Created by Tony's Mac on 6/4/14.
//  Copyright (c) 2014 TonyCP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchTableViewController.h"
#import <Parse/Parse.h>

@interface searchDetailViewController : UIViewController

@property (strong, nonatomic) NSString *detailItem;

@property (weak, nonatomic) IBOutlet UILabel *testDetail;

@end
