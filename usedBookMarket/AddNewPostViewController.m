//
//  AddNewPostViewController.m
//  usedBookMarket
//
//  Created by Tony's Mac on 6/1/14.
//  Copyright (c) 2014 TonyCP. All rights reserved.
//

#import "AddNewPostViewController.h"

@interface AddNewPostViewController ()

@end

@implementation AddNewPostViewController

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
    // Do any additional setup after loading the view.
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

- (IBAction)submitBtn:(id)sender {
    
    NSString *category = [self.categoryField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *bookName = [self.bookNameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *author = [self.authorField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *price    = [self.priceField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    // NSString *condition   = [self.conditionField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    // condition segmented control
    // UIImage

    
    if ([category length] == 0 || [bookName length] == 0 ||[author length] == 0 ||[price length] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Make sure you enter ALL the information!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else{
        
        PFObject *post = [PFObject objectWithClassName:@"Post"];
        
        [post setObject:category forKey:@"category"];
        [post setObject:bookName forKey:@"bookName"];
        [post setObject:author forKey:@"author"];
        [post setObject:price forKey:@"price"];
        [post setObject:[[PFUser currentUser] objectId] forKey:@"sellerId"];
        [post setObject:[[PFUser currentUser] username] forKey:@"sellerName"];
        
        
        [post saveInBackground];
    }
    
   [self.navigationController popToRootViewControllerAnimated:YES];
   
    
}








@end
