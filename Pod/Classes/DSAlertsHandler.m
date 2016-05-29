#pragma mark - include
#import "DSAlertsHandler.h"
#import "DSAlert.h"
#import "DSAlertView.h"
#import "DSAlertViewFactory.h"
#import "DSAlertButton.h"
#import "DSMessage.h"
#import "DSAlertsQueue.h"
#import "DSAlertQueue+Private.h"
#import "DSAlertsHandlerConfiguration.h"
@import DSLibCore;

#pragma mark - private
@interface DSAlertsHandler ()
@property (nonatomic, strong) DSQueue *alertsQueue;
@property (nonatomic, strong) id<DSAlertView> currentAlertView;
@property (nonatomic, strong) DSAlert *currentAlert;
@property (nonatomic, assign) BOOL isOnline;
@property (nonatomic, assign) BOOL shouldShowNotReachableAlerts;
@end

@implementation DSAlertsHandler

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (id)sharedInstance
{
  DEFINE_SHARED_INSTANCE_USING_BLOCK(^
                                     {
                                       return [[DSAlertsHandler alloc] init];
                                     });
}

- (id)init
{
  self = [super init];
  if (self != nil) {
    _alertsQueue = [DSQueue queue];
    _shouldShowNotReachableAlerts = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidResignActive:)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
  }
  return self;
}

- (void)setIsOnline:(BOOL)isOnline
{
  _isOnline = isOnline;
  if (isOnline) {
    [self setShouldShowNotReachableAlerts:YES];
  }
}

- (void)setReachability:(DSReachability *)reachability
{
  if ([self reachability]) {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
  }
  
  _reachability = reachability;
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(reachabilityChanged:)
                                               name:kReachabilityChangedNotification
                                             object:reachability];
}

- (void)reachabilityChanged:(NSNotification *)notification
{
  if ([(DSReachability *)[notification object] isReachable])  {
    [self setIsOnline:YES];
  }
}


#pragma mark - public
- (void)showAlert:(DSAlert *)theAlert modally:(BOOL)isModalAlert
{
  NSAssert(isModalAlert == YES, @"Only modal alert is supported now");
  
  void (^block)() = ^{
    [self queueAlert:theAlert];
  };
  
  if ([NSThread isMainThread]) {
    block();
  }
  else {
    dispatch_async(dispatch_get_main_queue(), block);
  }
}

- (DSAlertsQueue *)detachAlertsQueue
{
  DSAlertsQueue *queue = [[DSAlertsQueue alloc] init];
  [queue setAlertsHandler:self];
  return queue;
}

#pragma mark - alert
- (void)showModalAlert:(DSAlert *)theAlert
{
  ASSERT_MAIN_THREAD;
  id<DSAlertView> alertView = [DSAlertViewFactory modalAlertViewWithAlert:theAlert];
  
  [self setCurrentAlertView:alertView];
  [self setCurrentAlert:theAlert];
  DSWEAK_SELF;
  [alertView setOnDismiss:^(id<DSAlertView> _Nonnull alertView) {
    [weakSelf alertDismissed];
  }];
  [alertView show];
}

#pragma mark - queue
- (BOOL)isAlertInQueue:(DSAlert *)theAlert
{
  BOOL currentAlertEquals = [[self currentAlert] isAlertMessageEqualWith:theAlert];
  if (currentAlertEquals) {
    return YES;
  }
  
  BOOL alertInQueue = NO;
  for (DSAlert *queueAlert in [self alertsQueue]) {
    if ([queueAlert isAlertMessageEqualWith:theAlert]) {
      alertInQueue = YES;
      break;
    }
  }
  
  return alertInQueue;
}

- (BOOL)isMessage:(DSMessage *)message inCollection:(id<NSFastEnumeration>)collection {
  BOOL alertInCollection = NO;
  for (DSMessage *collectionMessage in collection) {
    if ([collectionMessage isEqualToMessage:message]) {
      alertInCollection = YES;
      break;
    }
  }
  
  return alertInCollection;
}

- (void)queueAlert:(DSAlert *)theAlert
{
  ASSERT_MAIN_THREAD;
  
  if (!theAlert) {
    return;
  }
  
  //If the same message is already in queue don't do anything
  if ([self isAlertInQueue:theAlert]) {
    return;
  }
  
  if ([self isMessage:[theAlert message]
         inCollection:[self filterOutMessages]]) {
    return;
  }
  else if ([[[theAlert message] domain] isEqualToString:NSURLErrorDomain] &&
           [[[theAlert message] code] integerValue] == NSURLErrorNotConnectedToInternet) {
    
    if ([self shouldShowNotReachableAlerts]) {
      [[self alertsQueue] push:theAlert];
    }
    
    [self setIsOnline:NO];
    NSNumber *showOfflineErrorsMoveThanOncen = [[DSAlertsHandlerConfiguration sharedInstance] showOfflineErrorsMoveThanOnce];
    if (showOfflineErrorsMoveThanOncen) {
      [self setShouldShowNotReachableAlerts:showOfflineErrorsMoveThanOncen.boolValue];
    }
    else {
#if DSAlertsHandler_SHOW_NO_INTERNET_CONNECTION_POPUPS_ONCE
      [self setShouldShowNotReachableAlerts:NO];
#endif
    }
  }
  else {
    [[self alertsQueue] push:theAlert];
  }
  
  [self processNextAlertFromQueue];
}

- (void)processNextAlertFromQueue
{
  ASSERT_MAIN_THREAD;
  
  if ([self currentAlertView] == nil) {
    DSAlert *nextAlert = [[self alertsQueue] pop];
    if (nextAlert != nil) {
      [self showModalAlert:nextAlert];//NOTE: when will add notifications(modeless alerts), fix this call
    }
  }
}

- (void)alertDismissed
{
  ASSERT_MAIN_THREAD;
  
  //Cleanup
  [self setCurrentAlertView:nil];
  [self setCurrentAlert:nil];
  
  [self processNextAlertFromQueue];
}

#pragma mark - UIAlertViewDelegate
- (void)alertViewCancel:(id<DSAlertView>)alertView
{
  [self alertDismissed];
}

//- (void)        alertView:(id<DSAlertView>)theAlertView
//didDismissWithButtonIndex:(NSInteger)theButtonIndex
//{
//  ASSERT_MAIN_THREAD;
//  
//  DSAlertButton *clickedButton = nil;
//  
//  if ([theAlertView isCancelButtonAtIndex:theButtonIndex]) {
//    clickedButton = [[self currentAlert] cancelButton];
//  }
//  else {
//    clickedButton = [[[self currentAlert] otherButtons]
//                     objectAtIndex:(NSUInteger)(theButtonIndex - ([[self currentAlert] cancelButton] ? 1: 0))];
//  }
//  
//  [clickedButton invoke];
//  [self alertDismissed];
//}

#pragma mark - Notifications
- (void)applicationDidResignActive:(NSNotification *)notification
{
  ASSERT_MAIN_THREAD;
  
  [[self alertsQueue] filterWithPredicate:[NSPredicate predicateWithBlock:^BOOL(DSAlert *alert, NSDictionary *bindings) {
    return ![alert shouldDismissOnApplicationDidResignActive];
  }]];
  
  if ([[[self currentAlertView] alert] shouldDismissOnApplicationDidResignActive]) {
    [[self currentAlertView] dismissAnimated:NO completion:nil];
  }
}

@end