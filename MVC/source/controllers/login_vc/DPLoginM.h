#import <Foundation/Foundation.h>

@protocol DPLoginMProtocol

- (void)loginMDidUpdateData;
- (void)showController:(UIViewController *)controller;

@end

@interface DPLoginM : NSObject

@property (nonatomic, weak) id <DPLoginMProtocol> delegate;

@property (nonatomic, strong, readonly) NSString *email;
@property (nonatomic, strong, readonly) NSString *password;
@property (nonatomic, strong, readonly) NSString *messageText;
@property (nonatomic, strong, readonly) NSString *title;

- (void)login;

- (void)setEmail:(NSString *)email;
- (void)setPassword:(NSString *)password;

@end
