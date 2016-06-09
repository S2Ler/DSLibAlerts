
#pragma mark - include
#import "DSUIAlertView.h"
#import "DSAlertButton.h"
@import DSLibCore;
@import SystemWindowController;

#pragma mark - private
@interface DSUIAlertView ()
@property (nonatomic, strong) NSMutableArray<DSAlertButton*> *buttons;
@end

@implementation DSUIAlertView
@synthesize alert = _alert;
@synthesize onDismiss;

+ (SystemWindowController *)alertWindowController {
  static dispatch_once_t onceToken;
  static SystemWindowController *alertsWindowController = nil;
  dispatch_once(&onceToken, ^{
    alertsWindowController = [[SystemWindowController alloc] initWithWindowLevel:UIWindowLevelAlert + 1];
  });
  
  return alertsWindowController;
}

+ (instancetype)alertViewWithTitle:(nullable NSString *)title
                           message:(nullable NSString *)message;
{
  return [self alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
}

- (NSMutableArray *)buttons {
  if (!_buttons) {
    _buttons = [NSMutableArray array];
  }
  return _buttons;
}

- (void)show
{
  [[DSUIAlertView alertWindowController] showSystemViewController:self atLevel:0 completion:nil];
}

- (void)dismissAnimated:(BOOL)animated completion:(void(^)())completion
{
  DSWEAK_SELF;
  [[DSUIAlertView alertWindowController] dismissSystemViewController:self completion:^{
    weakSelf.onDismiss(weakSelf);
    if (completion != nil) {
      completion();
    }
  }];
}

- (void)addButton:(DSAlertButton *)button style:(DSAlertButtonStyle)style {
  [self.buttons addObject:button];
  DSWEAK_SELF;
  [self addAction:[UIAlertAction actionWithTitle:button.title
                                           style:(UIAlertActionStyle)style
                                         handler:^(UIAlertAction * _Nonnull action) {
                                           [button invoke];
//                                           [weakSelf dismissAnimated:true completion:nil];
                                           weakSelf.onDismiss(weakSelf);
                                         }]];
}
@end
