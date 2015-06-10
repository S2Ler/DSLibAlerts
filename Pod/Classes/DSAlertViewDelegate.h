
@protocol DSAlertView;

@protocol DSAlertViewDelegate<NSObject>
- (void)        alertView:(nonnull id<DSAlertView>)alertView
didDismissWithButtonIndex:(NSInteger)buttonIndex;
@end
