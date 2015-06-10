
@import Foundation;

@protocol DSAlertView;
@class DSAlert;
@protocol DSAlertViewDelegate;


@interface DSAlertViewFactory: NSObject
/** Don't forget to set delegate */
+ (nonnull id<DSAlertView>)modalAlertViewWithAlert:(nonnull DSAlert *)theAlert
                                          delegate:(nullable id<DSAlertViewDelegate>)theDelegate;
@end
