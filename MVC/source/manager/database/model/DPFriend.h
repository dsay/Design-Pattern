//
//  DPFriend.h
//  MVC
//
//  Created by Dima on 7/14/14.
//  Copyright (c) 2014 Dima Sai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DPUser;

@interface DPFriend : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * friendID;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) DPUser *user;

@end
