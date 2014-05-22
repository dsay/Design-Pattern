#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CurrentCondition;

@interface Weather : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * tempMaxC;
@property (nonatomic, retain) NSNumber * tempMaxF;
@property (nonatomic, retain) NSNumber * tempMinC;
@property (nonatomic, retain) NSNumber * tempMinF;
@property (nonatomic, retain) NSString * weatherDesc;
@property (nonatomic, retain) NSString * weatherIconUrl;
@property (nonatomic, retain) CurrentCondition *currentCondition;

@end
