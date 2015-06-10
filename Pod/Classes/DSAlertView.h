
@protocol DSAlertViewDelegate;
@class DSAlert;
@import Foundation;

@protocol DSAlertView<NSObject>
@property (nonatomic, strong, nullable) DSAlert *alert;

- (nonnull instancetype)initWithTitle:(nullable NSString *)title
                              message:(nullable NSString *)message
                             delegate:(nullable id<DSAlertViewDelegate>)delegate
                    cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                          otherTitles:(nullable NSArray *)otherButtonTitles;

- (void)setDelegate:(nullable id<DSAlertViewDelegate>)theDelegate;
- (void)show;
- (void)dismissAnimated:(BOOL)animated;

- (BOOL)isCancelButtonAtIndex:(NSInteger)theButtonIndex;
@end
