
@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@class DSMessage;
@class DSAlertButton;


@interface DSAlert: NSObject

@property (nonatomic, strong, readonly, nullable) DSAlertButton * cancelButton;
@property (nonatomic, strong, readonly, nullable) NSArray * otherButtons;
@property (nonatomic, strong, readonly, nullable) DSMessage * message;

/** Default is YES */
@property (nonatomic, assign) BOOL shouldDismissOnApplicationDidResignActive;

- (instancetype)initWithMessage:(DSMessage *)theMessage
                   cancelButton:(nullable DSAlertButton *)theCancelButton
                   otherButtons:(nullable DSAlertButton *)theButtons, ... NS_REQUIRES_NIL_TERMINATION NS_DESIGNATED_INITIALIZER;

- (NSString *)localizedTitle;
- (NSString *)localizedBody;

- (BOOL)isAlertMessageEqualWith:(nullable id)theObj;

@end

NS_ASSUME_NONNULL_END
