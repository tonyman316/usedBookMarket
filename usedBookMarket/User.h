//
//  User.h
//  usedBookMarket
//
//  Created by Tony's Mac on 5/2/14.
//  Copyright (c) 2014 TonyCP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (weak, nonatomic) NSString *username;
@property (weak, nonatomic) NSString *firstName;
@property (weak, nonatomic) NSString *lastName;
@property (weak, nonatomic) NSString *email;
@property (weak, nonatomic) NSString *studentID;
@property (weak, nonatomic) NSString *mobile;
@property (weak, nonatomic) NSString *password;

@property (weak, nonatomic) NSURL *facebook;
@property (weak, nonatomic) NSURL *twitter;
@property (weak, nonatomic) UIImage *profilePic;





//@property NSMutableArray (book)* bookSelling;
//@property NSMutableArray (book)* bookPurchase;

@end
