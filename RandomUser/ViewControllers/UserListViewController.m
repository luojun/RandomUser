//
//  UserListViewController.m
//  RandomUser
//
//  Created by Jun Luo on 2014-07-13.
//  Copyright (c) 2014 Jun Luo. All rights reserved.
//

#import "UserListViewController.h"
#import "UserDetailViewController.h"
#import "CoreDataFetcher.h"
#import "CoreDataHelper.h"
#import "RandomUserAPIClient.h"

@interface UserListViewController () <CoreDataFetcherDelegate>

@property (nonatomic, strong) CoreDataFetcher* fetcher;
@property NSMutableArray *objects;

@end

@implementation UserListViewController
            
- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewUser:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.UserDetailViewController = (UserDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];

    [self setupFetcher];
}

#pragma mark - set up

- (void)setupFetcher
{
    self.fetcher = [[CoreDataFetcher alloc] initWithTableView:self.tableView];
    self.fetcher.fetchedResultsController = self.fetchedResultsController;
    self.fetcher.delegate = self;
    self.fetcher.reuseIdentifier = @"Cell";
}

#pragma mark - Random User

- (void)addNewUser:(id)sender {
    [RandomUserAPIClient requestRandomUserWithBlock:nil];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.objects[indexPath.row];
        [(UserDetailViewController *)[[segue destinationViewController] topViewController] setDetailItem:object];
    }
}

#pragma mark - fetcher delegate

- (void)configureCell:(UITableViewCell *)cell withObject:(id)object
{
    UILabel *userNameView = (UILabel *) [cell.contentView viewWithTag:1];
    UIImageView *pictureView = (UIImageView *) [cell.contentView viewWithTag:2];
    userNameView.text = [[object valueForKey:@"name"] description];
    NSURL *imageURL = [NSURL URLWithString:[object valueForKey:@"picture"]];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        dispatch_async(dispatch_get_main_queue(), ^{
            pictureView.image = [UIImage imageWithData:imageData];
        });
    });
}

#pragma mark - fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSManagedObjectContext *mainContext = [CoreDataHelper defaultMainContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:mainContext];
    request.entity = entity;
    request.fetchBatchSize = 20;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    request.sortDescriptors = sortDescriptors;
    
    NSFetchedResultsController *controller = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:mainContext sectionNameKeyPath:nil cacheName:nil];
    _fetchedResultsController = controller;
    
    return _fetchedResultsController;
}


@end
