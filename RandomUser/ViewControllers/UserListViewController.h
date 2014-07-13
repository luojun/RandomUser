//
//  UserListViewController.h
//  RandomUser
//
//  Created by Jun Luo on 2014-07-13.
//  Copyright (c) 2014 Jun Luo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class UserDetailViewController;

@interface UserListViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) UserDetailViewController *UserDetailViewController;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

