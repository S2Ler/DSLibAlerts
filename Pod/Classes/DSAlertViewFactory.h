
@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@protocol DSAlertView;
@class DSAlert;

@interface DSAlertViewFactory: NSObject
/** Don't forget to set delegate */
+ (id<DSAlertView>)modalAlertViewWithAlert:(DSAlert *)theAlert;
@end

NS_ASSUME_NONNULL_END