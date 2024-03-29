//
//  SearchTableViewController.m
//  usedBookMarket
//
//  Created by Tony's Mac on 5/31/14.
//  Copyright (c) 2014 TonyCP. All rights reserved.
//

#import "SearchTableViewController.h"
#import "searchDetailViewController.h"

@interface SearchTableViewController ()

@end

@implementation SearchTableViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Check if user is cached and linked to Facebook, if so, bypass login
    if ([PFUser currentUser] || [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
        NSLog(@"current user: %@", [[PFUser currentUser] username]);

    }else
    {
        //Go to login
        [self.tabBarController setSelectedIndex:3];
    }

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByAscending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        else {
            self.allPost = objects;
            [self.tableView reloadData];
        }
    }];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.allPost count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    PFObject*post = [self.allPost objectAtIndex:indexPath.row];
    cell.textLabel.text = [post objectForKey:@"bookName"];
    cell.detailTextLabel.text = [post objectForKey:@"author"];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (IBAction)refresh:(id)sender {
    
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        // NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        searchDetailViewController *deetsController = segue.destinationViewController;
         deetsController.detailItem = @"To be built!"; //my stuff
        
        // deetsController.detailItem = [ <from parse> objectAtIndex:indexPath.row];;
        
        //[[segue destinationViewController] setBook:[_user.buyingBooks objectAtIndex:0]];
    }
    
}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"showDetail"])
//    {
//        NSIndexPath *indexPath = [_placesTable indexPathForSelectedRow];
//        TravelDetailsViewController *deetsController = segue.destinationViewController;
//        deetsController.navIteamName = @"Hello!"; //my stuff
//        // deetsController.navIteamName = [navItems objectAtIndex:indexPath.row]; //from book
//    }
//}




@end
