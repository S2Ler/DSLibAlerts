
#pragma mark - include
#import "DSAlertViewFactory.h"
#import "DSAlertView.h"
#import "DSAlert.h"
#import "DSUIAlertView.h"
#import "DSAlertButton.h"
#import "DSAlertsHandlerConfiguration.h"


@implementation DSAlertViewFactory

+ (id<DSAlertView>)modalAlertViewWithAlert:(DSAlert *)theAlert
{
  NSArray<DSAlertButton*> *otherButtons = [theAlert otherButtons];

  NSMutableArray *otherButtonsTitles = [NSMutableArray array];
  for (DSAlertButton *button in otherButtons) {
    [otherButtonsTitles addObject:[button title]];
  }

  id<DSAlertView> alertView = nil;
  NSString *alertViewClassName = [[DSAlertsHandlerConfiguration sharedInstance] modelAlertsClassName];
  Class alertViewClass = NSClassFromString(alertViewClassName);
  if (alertViewClass) {
    alertView = [alertViewClass alertViewWithTitle:[theAlert localizedTitle]
                                          message:[theAlert localizedBody]];
  }
  else {
    alertView = [DSUIAlertView alertViewWithTitle:[theAlert localizedTitle]
                                          message:[theAlert localizedBody]];
  }
  
  for (DSAlertButton *otherButton in otherButtons) {
    [alertView addButton:otherButton style:DSAlertButtonStyleDefault];
  }
  if ([theAlert cancelButton]) {
    [alertView addButton:[theAlert cancelButton] style:DSAlertButtonStyleCancel];
  }

  [alertView setAlert:theAlert];
  
  return alertView;
}


@end
