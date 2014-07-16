#import <Foundation/Foundation.h>
#import "DPModelProtocol.h"

@class DPLoginModel;
@protocol DPLoginModelDelegate <NSObject>

- (void)modelDidLogin:(DPLoginModel *)model;

@end

@interface DPLoginModel : NSObject <DPModelProtocol>

@property (nonatomic, weak) id <DPModelDelegate, DPLoginModelDelegate, DPActivityDelegate> delegate;

@property (readonly) DPManagerProvider *provider;

@property (readonly) NSString *email;
@property (readonly) NSString *password;
@property (readonly) NSString *messageText;

@property (readonly) NSString *emailDefaultText;
@property (readonly) NSString *passwordDefaultText;
@property (readonly) NSString *title;
@property (readonly) NSString *loginTitle;

- (void)login;

- (BOOL)shouldChangeEmailInRange:(NSRange)range
                replacementText:(NSString *)text;

- (BOOL)shouldChangePasswordtInRange:(NSRange)range
                replacementText:(NSString *)text;

@end
