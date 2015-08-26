
@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@protocol DSAlertViewDelegate;
@class DSAlert;
@import Foundation;

@protocol DSAlertView<NSObject>
@property (nonatomic, strong, nullable) DSAlert *alert;

- (instancetype)initWithTitle:(nullable NSString *)title
                      message:(nullable NSString *)message
                     delegate:(nullable id<DSAlertViewDelegate>)delegate
            cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                  otherTitles:(nullable NSArray *)otherButtonTitles;

- (void)setDelegate:(nullable id<DSAlertViewDelegate>)theDelegate;
- (void)show;
- (void)dismissAnimated:(BOOL)animated;

- (BOOL)isCancelButtonAtIndex:(NSInteger)theButtonIndex;
@end

NS_ASSUME_NONNULL_END
