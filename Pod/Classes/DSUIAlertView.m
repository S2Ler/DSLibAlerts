
#pragma mark - include
#import "DSUIAlertView.h"
#import "DSAlertsHandler.h"
#import "DSAlertButton.h"
@import DSLibCore;

#pragma mark - private
@interface DSUIAlertView ()
@property (nonatomic, strong) NSMutableArray<DSAlertButton*> *buttons;
@end

@implementation DSUIAlertView
@synthesize alert = _alert;
@synthesize onDismiss;

+ (instancetype)alertViewWithTitle:(nullable NSString *)title
                           message:(nullable NSString *)message;
{
  return [super alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
}

- (NSMutableArray *)buttons {
  if (!_buttons) {
    _buttons = [NSMutableArray array];
  }
  return _buttons;
}

- (void)show
{
  [[DSAlertsHandler sharedInstance].getViewControllerForAlerts() presentViewController:self animated:true completion:nil];
  //TODO: Present to root view controller of the window?
}

- (void)dismissAnimated:(BOOL)animated completion:(void(^)())completion
{
  [self dismissViewControllerAnimated:animated completion:completion];
}

- (void)addButton:(DSAlertButton *)button style:(DSAlertButtonStyle)style {
  [self.buttons addObject:button];
  DSWEAK_SELF;
  [self addAction:[UIAlertAction actionWithTitle:button.title
                                           style:style
                                         handler:^(UIAlertAction * _Nonnull action) {
                                           [button invoke];
                                           weakSelf.onDismiss(weakSelf);
                                         }]];
}
@end
