#import <Foundation/Foundation.h>
#import "DPModelProtocol.h"

@class DPLoginModel;
@protocol DPLoginModelDelegate <NSObject>

- (void)modelDidLogin:(DPLoginModel *)model;

@end

@interface DPLoginModel : NSObject <DPModelProtocol>

@property (nonatomic, weak) id <DPModelDelegate, DPLoginModelDelegate> delegate;

@property (nonatomic, strong, readonly) NSString *email;
@property (nonatomic, strong, readonly) NSString *password;
@property (nonatomic, strong, readonly) NSString *emailPlaceholder;
@property (nonatomic, strong, readonly) NSString *passwordPlaceholder;
@property (nonatomic, strong, readonly) NSString *messageText;
@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSString *loginTitle;

- (void)login;

- (BOOL)shouldChangeEmailInRange:(NSRange)range
                replacementText:(NSString *)text;
- (BOOL)shouldChangePasswordtInRange:(NSRange)range
                replacementText:(NSString *)text;

@end
