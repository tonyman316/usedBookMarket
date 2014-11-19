//
//  AboutMeViewController.m
//  usedBookMarket
//
//  Created by Tony's Mac on 6/2/14.
//  Copyright (c) 2014 TonyCP. All rights reserved.
//

#import "AboutMeViewController.h"




@interface AboutMeViewController () <UITableViewDataSource , UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation AboutMeViewController
// @synthesize profilePic;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    
#pragma mark - Send request to Facebook
    
    // If the user is already logged in, display any previously cached values before we get the latest from Facebook.
    if ([PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
        [self updateProfile];

       
    }
    
    // Send request to Facebook
    FBRequest *request = [FBRequest requestForMe];
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        // handle response
        if (!error) {
            // Parse the data received
            NSDictionary *userData = (NSDictionary *)result;
            
            NSString *facebookID = userData[@"id"];
            
            NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
            
            
            NSMutableDictionary *userProfile = [NSMutableDictionary dictionaryWithCapacity:8];
            
            if (facebookID) {
                userProfile[@"facebookId"] = facebookID;
            }
            
            if (userData[@"name"]) {
                userProfile[@"name"] = userData[@"name"];
            }
            
            if (userData[@"location"][@"name"]) {
                userProfile[@"location"] = userData[@"location"][@"name"];
            }
            
            if (userData[@"gender"]) {
                userProfile[@"gender"] = userData[@"gender"];
            }
            
            if (userData[@"birthday"]) {
                userProfile[@"birthday"] = userData[@"birthday"];
            }
            
            if (userData[@"relationship_status"]) {
                userProfile[@"relationship"] = userData[@"relationship_status"];
            }
            
            if (userData[@"email"]) {
                userProfile[@"email"] = userData[@"email"];
            }
            
            if ([pictureURL absoluteString]) {
                userProfile[@"pictureURL"] = [pictureURL absoluteString];
            }
            
            [[PFUser currentUser] setObject:userProfile forKey:@"profile"];
            [[PFUser currentUser] saveInBackground];
            
            [self updateProfile];
        } else if ([[[[error userInfo] objectForKey:@"error"] objectForKey:@"type"]
                    isEqualToString: @"OAuthException"]) { // Since the request failed, we can check if it was due to an invalid session
            NSLog(@"The facebook session was invalidated");
            [self logoutBtn:nil];
        } else {
            NSLog(@"Some other error: %@", error);
        }
    }];
    

}
#pragma mark - Retrieving currentUser Info

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    
    if ([PFUser currentUser])
    {
    
        if ([PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) //check if the user is linked to facebook
        {
                [self updateProfile];
                
                PFQuery *query = [PFUser query];
                [query whereKey:@"objectId" equalTo:[[PFUser currentUser] objectId]];
                self.firstLastName.text = [[PFUser currentUser] objectForKey:@"profile"][@"name"];
                self.userEmail = [[PFUser currentUser] objectForKey:@"profile"][@"email"];
                self.userOther = [[PFUser currentUser] objectForKey:@"profile"][@"gender"];
                [self countTotalPost];

        }
        else
        {
            
            PFQuery *query = [PFUser query];
            [query whereKey:@"objectId" equalTo:[[PFUser currentUser] objectId]];
            self.firstLastName.text = [[PFUser currentUser] username];
            self.userEmail = [[PFUser currentUser] email];
            self.userMobile = [[PFUser currentUser] objectForKey:@"mobile"]; //for other column in database
            [self countTotalPost];
            
            
            // retrieving profile pic:

                
            PFQuery *query2 = [PFQuery queryWithClassName:@"UserPhoto"];
            PFUser *user = [PFUser currentUser];
            [query2 whereKey:@"user" equalTo:user];
            [query2 getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
                if (!object) {
                    NSLog(@"The getFirstObject request failed.");
                }
                    else
                    {
                        NSLog(@"Successfully retrieved the object.");
                        
                        PFFile *file = [object objectForKey:@"imageFile"];
                        self.profilePic.file = file;
                        [self.profilePic loadInBackground];
                        [self.profilePic reloadInputViews];
                    }
            }];

        }
        
    }
    else
    {
        [self performSegueWithIdentifier:@"showLogin2" sender:self];
    }
    
    [self.myTableView reloadData];

        
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
 
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    
    switch (section)
    {
            case 0:
            {
                return 1;
                break;
            }
            case 1:
            {
                return 1;
                break;
            }
            case 2:{
                return 1;
                break;
            }
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"MyCell";
    UITableViewCell *thisCell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (thisCell==nil)
    {
        thisCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
        switch (indexPath.section){

            case 0:
            {
                
                NSString *totalPostString = [@"Total Post: " stringByAppendingFormat:@"%i", self.postCount];
                thisCell.textLabel.text = totalPostString;
                                           
                break;
            }
            case 1:
            {
               
                NSString *emailString = [@"Email: " stringByAppendingFormat:@"%@", self.userEmail];
                thisCell.textLabel.text = emailString; //self.userEmail;
                break;
            }
            case 2:
            {
                if ([PFFacebookUtils isLinkedWithUser:[PFUser currentUser]])
                {
                   // NSString *otherString =[@"Gender: " stringByAppendingString: self.userOther];
                   // thisCell.textLabel.text = otherString; //self.userMobile;
                    
                    break;
                }
                else{

//                NSString *mobileString =[@"Mobile: " stringByAppendingString: self.userMobile];
//                thisCell.textLabel.text = mobileString; //self.userMobile;
//                break;
                }
            }
        }
    return thisCell;
}




- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showLogin2"]) {
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
    }
}



#pragma mark - Retrieving from Parse Method

-(void) countTotalPost
{
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query whereKey:@"sellerId" equalTo:[[PFUser currentUser]objectId]];
    [query countObjectsInBackgroundWithBlock:^(int count, NSError *error) {
        if (!error) {
            // The count request succeeded. Log the count
            NSLog(@"You have %d post", count);
            
            self.postCount = count;
            
            // NSLog(@"You have %i post", self.postCount);
            
            [self.myTableView reloadData];
            
        } else {
            // The request failed
        }
    }];
}

#pragma mark - NSURLConnectionDataDelegate

/* Callback delegate methods used for downloading the user's profile picture */

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // As chuncks of the image are received, we build our data file
    [self.imageData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // All data has been downloaded, now we can set the image in the header image view
    self.profilePic.image = [UIImage imageWithData:self.imageData];
    
    // Add a nice corner radius to the image
    self.profilePic.layer.cornerRadius = 8.0f;
    self.profilePic.layer.masksToBounds = YES;
}

#pragma marke - Facebook Profile Update

// Set received values if they are not nil and reload the table
- (void)updateProfile {
    if ([[PFUser currentUser] objectForKey:@"profile"][@"location"]) {
//        [self.rowDataArray replaceObjectAtIndex:0 withObject:[[PFUser currentUser] objectForKey:@"profile"][@"location"]];
    }
    
    if ([[PFUser currentUser] objectForKey:@"profile"][@"gender"]) {
//        [self.rowDataArray replaceObjectAtIndex:1 withObject:[[PFUser currentUser] objectForKey:@"profile"][@"gender"]];
    }
    
    if ([[PFUser currentUser] objectForKey:@"profile"][@"birthday"]) {
//        [self.rowDataArray replaceObjectAtIndex:2 withObject:[[PFUser currentUser] objectForKey:@"profile"][@"birthday"]];
    }
    
    if ([[PFUser currentUser] objectForKey:@"profile"][@"relationship"]) {
//        [self.rowDataArray replaceObjectAtIndex:3 withObject:[[PFUser currentUser] objectForKey:@"profile"][@"relationship"]];
    }
    
//    [self.tableView reloadData];
    
    // Set the name in the header view label
    if ([[PFUser currentUser] objectForKey:@"profile"][@"name"]) {
        self.firstLastName.text = [[PFUser currentUser] objectForKey:@"profile"][@"name"];
    }
    
    // Download the user's facebook profile picture
    self.imageData = [[NSMutableData alloc] init]; // the data will be loaded in here
    
    if ([[PFUser currentUser] objectForKey:@"profile"][@"pictureURL"]) {
        NSURL *pictureURL = [NSURL URLWithString:[[PFUser currentUser] objectForKey:@"profile"][@"pictureURL"]];
        
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:pictureURL
                                                                  cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                              timeoutInterval:2.0f];
        // Run network request asynchronously
        NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
        if (!urlConnection) {
            NSLog(@"Failed to download picture");
        }
    }
}

# pragma mark - Set Profile Pic method if it is nil (basic users)

//- (void)downloadAllImages
//{
//    PFQuery *query = [PFQuery queryWithClassName:@"UserPhoto"];
//    PFUser *user = [PFUser currentUser];
//    [query whereKey:@"user" equalTo:user];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        // If there are photos, we start extracting the data
//        // Save a list of object IDs while extracting this data
//        
//        NSMutableArray *newObjectIDArray = [NSMutableArray array];
//        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
//        
//        if (objects.count > 0) {
//            for (PFObject *eachObject in objects) {
//                [newObjectIDArray addObject:[eachObject objectId]];
//            }
//        }
//    }];
//
//}




-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0)
    {
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = NO;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:^{}];
    }
    else if (buttonIndex == 1)
    {
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = NO;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:^{}];
        
    }
    else
    {
        
    }
}
- (IBAction)showActionSheet:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Take Photo", @"Choose Existing Photo", nil];
    [actionSheet showInView:self.view];

}

- (IBAction)logoutBtn:(id)sender {
    [PFUser logOut];
    [self performSegueWithIdentifier:@"showLogin2" sender:self];
}

@end
