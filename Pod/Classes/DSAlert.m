
#pragma mark - include
#import "DSAlert.h"
#import "DSAlertButton.h"
#import "DSMessage.h"
@import DSLibCore;

#pragma mark - private
@interface DSAlert ()
@property (nonatomic, strong) DSMessage *message;
@property (nonatomic, strong) DSAlertButton *cancelButton;
@property (nonatomic, strong) NSArray *otherButtons;
@end

@implementation DSAlert

- (instancetype)init
{
  ASSERT_NOT_SUPPORTED_METHOD;
  return [self initWithMessage:[DSMessage unknownError]
                  cancelButton:nil
                  otherButtons:nil];
}

- (instancetype)initWithMessage:(DSMessage *)theMessage
                   cancelButton:(DSAlertButton *)theCancelButton
                   otherButtons:(DSAlertButton *)theButtons, ...
{
  va_list buttonsList;
  va_start(buttonsList, theButtons);
  
  NSMutableArray *buttons = [NSMutableArray array];
  for (DSAlertButton *button = theButtons;
       button != nil;
       button = va_arg(buttonsList, DSAlertButton *))
  {
    [buttons addObject:button];
  }
  va_end(buttonsList);

  return [self initWithMessage:theMessage
                  cancelButton:theCancelButton
             otherButtonsArray:buttons];
}

- (instancetype)initWithMessage:(DSMessage *)theMessage
                   cancelButton:(nullable DSAlertButton *)theCancelButton
              otherButtonsArray:(nullable NSArray<DSAlertButton*> *)theButtons {
  self = [super init];
  if (self) {
    _message = theMessage;
    _cancelButton = theCancelButton;
    
    _otherButtons = theButtons;
    _shouldDismissOnApplicationDidResignActive = YES;
  }
  return self;
}

- (NSString *)localizedTitle
{
  return [[self message] localizedTitle];
}

- (NSString *)localizedBody
{
  return [[self message] localizedBody];
}

- (BOOL)isAlertMessageEqualWith:(id)theObj
{
  DSAlert *alert = DSDynamicCast(theObj, DSAlert);
  if (alert == nil) {
    return NO;
  }

  BOOL messagesEquals = [[self message] isEqualToMessage:[alert message]];
  return messagesEquals;
}


@end
