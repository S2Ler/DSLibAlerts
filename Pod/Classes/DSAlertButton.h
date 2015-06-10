
@import Foundation;
#import "DSAlertsSupportCode.h"
#import <DSLibCore/DSConstants.h>

NS_ASSUME_NONNULL_BEGIN

@interface DSAlertButton: NSObject

@property (nonatomic, strong, readonly) NSString * title;

- (instancetype)initWithTitle:(NSString *)theTitle
                       target:(nullable id)theTarget
                       action:(nullable SEL)theAction NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithTitle:(NSString *)theTitle
              invocationBlock:(nullable ds_action_block_t)theBlock NS_DESIGNATED_INITIALIZER;

+ (instancetype)buttonWithTitle:(NSString *)theTitle
                         target:(nullable id)theTarget
                         action:(nullable SEL)theAction;

+ (instancetype)buttonWithTitle:(NSString *)theTitle
                invocationBlock:(nullable ds_action_block_t)theBlock;

- (void)invoke;
@end

@interface DSAlertButton (FactoryMethods)
+ (instancetype)cancelButton;
+ (instancetype)cancelButtonWithBlock:(nullable ds_action_block_t)block;
+ (instancetype)NOButton;
+ (instancetype)OKButton;
@end

NS_ASSUME_NONNULL_END
