//
//  UserDetailViewController.h
//  RandomUser
//
//  Created by Jun Luo on 2014-07-13.
//  Copyright (c) 2014 Jun Luo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface UserDetailViewController : UIViewController

@property (strong, nonatomic) NSManagedObject *userObject;

@end

