//
//  UserDetailViewController.m
//  RandomUser
//
//  Created by Jun Luo on 2014-07-13.
//  Copyright (c) 2014 Jun Luo. All rights reserved.
//

#import "UserDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface UserDetailViewController ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) UIPopoverController *masterPopoverController;

@end

@implementation UserDetailViewController
            
#pragma mark - Managing the detail item

- (void)setUserObject:(NSManagedObject *)newUserObject {
    if (_userObject != newUserObject) {
        _userObject = newUserObject;
            
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
}

- (void)configureView {
    UILabel *userNameView = (UILabel *) [self.contentView viewWithTag:1];
    userNameView.text = [[self.userObject valueForKey:@"name"] description];
    UILabel *userCellView = (UILabel *) [self.contentView viewWithTag:4];
    userCellView.text = [[self.userObject valueForKey:@"cell"] description];
    UILabel *userEmailView = (UILabel *) [self.contentView viewWithTag:5];
    userEmailView.text = [[self.userObject valueForKey:@"email"] description];

    UIImageView *pictureView = (UIImageView *) [self.contentView viewWithTag:2];
    NSURL *imageURL = [NSURL URLWithString:[self.userObject valueForKey:@"picture"]];
    [pictureView setImageWithURL:imageURL];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
    return YES;
}

@end
