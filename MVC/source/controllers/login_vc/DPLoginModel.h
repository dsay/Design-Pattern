#import <Foundation/Foundation.h>
#import "DPModelProtocol.h"

@class DPLoginModel;
@protocol DPLoginModelDelegate <NSObject>

- (void)modelDidLogin:(DPLoginModel *)model;

@end

@interface DPLoginModel : NSObject <DPModelProtocol>

@property (nonatomic, weak) id <DPModelDelegate, DPLoginModelDelegate, DPActivityDelegate> delegate;
@property (readonly) DPManagerProvider *manager;
@property (readonly) NSString *email;
@property (readonly) NSString *password;
@property (readonly) NSString *messageText;

@property (readonly) NSString *emailPlaceholder;
@property (readonly) NSString *passwordPlaceholder;
@property (readonly) NSString *title;
@property (readonly) NSString *loginTitle;

- (void)login;

- (BOOL)shouldChangeEmailInRange:(NSRange)range
                replacementText:(NSString *)text;

- (BOOL)shouldChangePasswordtInRange:(NSRange)range
                replacementText:(NSString *)text;

@end
