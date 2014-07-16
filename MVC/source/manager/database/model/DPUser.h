//
//  DPUser.h
//  MVC
//
//  Created by Dima on 7/14/14.
//  Copyright (c) 2014 Dima Sai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DPFriend;

@interface DPUser : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSNumber * userID;
@property (nonatomic, retain) NSSet *friends;
@end

@interface DPUser (CoreDataGeneratedAccessors)

- (void)addFriendsObject:(DPFriend *)value;
- (void)removeFriendsObject:(DPFriend *)value;
- (void)addFriends:(NSSet *)values;
- (void)removeFriends:(NSSet *)values;

@end
