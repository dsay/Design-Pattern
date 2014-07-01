#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CurrentCondition : NSManagedObject

@property (nonatomic, retain) NSNumber * pressure;
@property (nonatomic, retain) NSNumber * temp_C;
@property (nonatomic, retain) NSNumber * temp_F;
@property (nonatomic, retain) NSString * weatherDesc;
@property (nonatomic, retain) NSString * weatherIconUrl;
@property (nonatomic, retain) NSString * observation_time;
@property (nonatomic, retain) NSNumber * humidity;
@property (nonatomic, retain) NSSet *weathers;
@end

@interface CurrentCondition (CoreDataGeneratedAccessors)

- (void)addWeathersObject:(NSManagedObject *)value;
- (void)removeWeathersObject:(NSManagedObject *)value;
- (void)addWeathers:(NSSet *)values;
- (void)removeWeathers:(NSSet *)values;

@end
