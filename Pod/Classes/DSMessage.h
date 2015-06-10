#import <Foundation/Foundation.h>
#import "DSAlertsSupportCode.h"

NS_ASSUME_NONNULL_BEGIN

@class DSMessageContext;

@interface DSMessage: NSObject <NSCoding>

@property (nonatomic, strong, nullable) DSMessageContext *context;
@property (nonatomic, strong, readonly, nonnull) DSMessageDomain *domain;
@property (nonatomic, strong, readonly, nonnull) DSMessageCode *code;
@property (nonatomic, strong, readonly, nullable) NSArray *params;

@property (nonatomic, strong, nullable) NSArray *titleParams;

- (NSString *)localizedTitle;
- (NSString *)localizedBody;

/**
* @param theParam params for body text. to set params for title text, user titleParams property.
*/
- (instancetype)initWithDomain:(DSMessageDomain *)theDomain
                          code:(DSMessageCode *)theCode
                        params:(nullable id)theParam, ... NS_REQUIRES_NIL_TERMINATION;


- (instancetype)initWithDomain:(DSMessageDomain *)theDomain
                          code:(DSMessageCode *)theCode;

+ (instancetype)messageWithDomain:(DSMessageDomain *)theDomain
                             code:(DSMessageCode *)theCode;

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message;

+ (instancetype)messageWithTitle:(NSString *)title
                         message:(NSString *)message;

- (instancetype)initWithError:(NSError *)theError;

+ (instancetype)messageWithError:(NSError *)theError;

- (BOOL)isEqualToMessage:(nullable id)theObj;

+ (instancetype)unknownError;

- (BOOL)isGeneralErrorMessage;

@end

NS_ASSUME_NONNULL_END