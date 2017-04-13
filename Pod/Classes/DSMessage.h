@import Foundation;
#import "DSAlertsSupportCode.h"

NS_ASSUME_NONNULL_BEGIN

@class DSMessageContext;

@interface DSMessage: NSObject <NSCoding>

@property (nonatomic, strong, nullable) DSMessageContext *context;
@property (nonatomic, strong, readonly) DSMessageDomain *domain;
@property (nonatomic, strong, readonly) DSMessageCode *code;
@property (nonatomic, strong, readonly, nullable) NSArray *params;

@property (nonatomic, strong, nullable) NSArray *titleParams;

- (NSString *)localizedTitle;
- (NSString *)localizedBody;

/** This method makes sure that two message which are equals without a call to this method won't be equal.
  Why is this needed?
  CoreData doesn't send KVO messages if object to be changed is equal to the current one. But for one of my usecases I need it to send KVO notifications on every single change */
- (void)makeUnique;

/**
* @param theParam params for body text. to set params for title text, user titleParams property.
*/
- (instancetype)initWithDomain:(DSMessageDomain *)theDomain
                          code:(DSMessageCode *)theCode
                        params:(nullable id)theParam, ... NS_REQUIRES_NIL_TERMINATION;

- (instancetype)initWithDomain:(DSMessageDomain *)theDomain
                          code:(DSMessageCode *)theCode
                   paramsArray:(nullable NSArray<id> *)theParams NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithDomain:(DSMessageDomain *)theDomain
                          code:(DSMessageCode *)theCode
                         title:(NSString *)title
                       message:(NSString *)message
                   paramsArray:(nullable NSArray<id> *)theParams;

- (instancetype)initWithDomain:(DSMessageDomain *)theDomain
                          code:(DSMessageCode *)theCode;

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message;

- (instancetype)initWithError:(NSError *)theError;

- (BOOL)isEqualToMessage:(nullable id)theObj;

+ (instancetype)newUnknownError NS_SWIFT_NAME(unknownError());

- (BOOL)isGeneralErrorMessage;

- (BOOL)isEqualToError:(NSError *)error;
- (BOOL)isEqualToDomain:(DSMessageDomain *)domain codeInteger:(NSInteger)code;
- (BOOL)isEqualToDomain:(DSMessageDomain *)domain code:(DSMessageCode *)code;
@end

NS_ASSUME_NONNULL_END
