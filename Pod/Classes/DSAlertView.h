
@import Foundation;
#import "DSAlertButtonStyle.h"

NS_ASSUME_NONNULL_BEGIN

@class DSAlert;
@class DSAlertButton;
@protocol DSAlertView;
@import Foundation;

@protocol DSAlertView<NSObject>
@property (nonatomic, strong, nullable) DSAlert *alert;
@property (nonatomic, copy) void (^onDismiss)(id<DSAlertView>);

+ (instancetype)alertViewWithTitle:(nullable NSString *)title
                           message:(nullable NSString *)message;

- (void)addButton:(DSAlertButton *)button style:(DSAlertButtonStyle)style;

- (void)show;
- (void)dismissAnimated:(BOOL)animated completion:(void(^_Nullable)())completion;
@end

NS_ASSUME_NONNULL_END
