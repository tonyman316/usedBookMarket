//
//  SearchTableViewController.h
//  usedBookMarket
//
//  Created by Tony's Mac on 5/31/14.
//  Copyright (c) 2014 TonyCP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SearchTableViewController : UITableViewController


- (IBAction)refresh:(id)sender;

@property (strong, nonatomic) NSArray *allPost;
@property (strong, nonatomic) PFObject *book;

@end
