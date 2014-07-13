//
//  RandomUserProcessor.m
//  RandomUser
//
//  Created by Jun Luo on 2014-07-13.
//  Copyright (c) 2014 Jun Luo. All rights reserved.
//

#import "RandomUserProcessor.h"
#import "RandomUserModelConfig.h"

@implementation RandomUserProcessor

#define kRUMAddress @"address"
#define kRUMCell @"cell"
#define kRUMEmail @"email"
#define kRUMGender @"gender"
#define kRUMName @"name"
#define kRUMPhone @"phone"
#define kRUMPicture @"picture"
#define kRUMRegistered @"registered"

+ (void)processData:(NSDictionary *)userData {
    NSManagedObjectContext *workerContext = [CoreDataHelper workerContext];
    [workerContext performBlock:^{
        NSManagedObject *userObject = [NSEntityDescription insertNewObjectForEntityForName:kRUMUserEntity inManagedObjectContext:workerContext];
        
        NSDictionary *addressData =[userData valueForKey:@"location"];
        [userObject setValue:[RandomUserProcessor addressFromAddressData:addressData] forKey:kRUMAddress];
        [userObject setValue:[userData valueForKey:@"cell"] forKey:kRUMCell];
        [userObject setValue:[userData valueForKey:@"email"] forKey:kRUMEmail];
        [userObject setValue:[userData valueForKey:@"gender"] forKey:kRUMGender];

        NSDictionary *nameData = [userData valueForKey:@"name"];
        [userObject setValue:[RandomUserProcessor nameFromNameData:nameData] forKey:kRUMName];
        [userObject setValue:[userData valueForKey:@"phone"] forKey:kRUMPhone];
        [userObject setValue:[userData valueForKey:@"picture"] forKey:kRUMPicture];
        [userObject setValue:[userData valueForKey:@"registered"] forKey:kRUMRegistered];
        
        [CoreDataHelper saveWorkerContext:workerContext];
    }];
}

+ (NSString *)nameFromNameData:(NSDictionary *)nameData {
    return [NSString stringWithFormat:@"%@ %@ %@",
            [nameData valueForKey:@"title"],
            [nameData valueForKey:@"first"],
            [nameData valueForKey:@"liast"]];
}

+ (NSString *)addressFromAddressData:(NSDictionary *)addressData {
    return [NSString stringWithFormat:@"%@, %@, %@ %@",
            [addressData valueForKey:@"street"],
            [addressData valueForKey:@"city"],
            [addressData valueForKey:@"state"],
            [addressData valueForKey:@"zipte"]];
}

@end
