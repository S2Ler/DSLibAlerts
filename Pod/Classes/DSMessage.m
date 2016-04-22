
#pragma mark - include
#import "DSMessage.h"
#import "NSString+Extras.h"
#import "DSAlertsHandlerConfiguration.h"
#import "NSError+DSMessage.h"
@import ObjectiveC;

#pragma mark - private
@interface DSMessage ()
@property (nonatomic, strong) DSMessageDomain *domain;
@property (nonatomic, strong) DSMessageCode *code;
@property (nonatomic, strong) NSArray *params;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) NSString *uniqueID;
@end

@implementation DSMessage

- (NSString *)localizationTable
{
  return [DSMessage localizationTable];
}

- (NSBundle *)localizationBundle {
  return [DSMessage localizationBundle];
}

+ (NSBundle *)localizationBundle {
  return [[DSAlertsHandlerConfiguration sharedInstance] messagesTableBundle];
}

+ (NSString *)localizationTable
{
  return [[DSAlertsHandlerConfiguration sharedInstance] messagesLocalizationTableName];
}

- (NSString *)keyForLocalizedTitle
{
  NSString *key = [NSString stringWithFormat:@"%@.%@.title", [self domain], [self code]];
  return key;
}

- (NSString *)keyForLocalizedBody
{
  NSString *key = [NSString stringWithFormat:@"%@.%@.body", [self domain], [self code]];
  return key;
}

- (NSString *)localizedTitle
{
  NSString *localizationKey = [self keyForLocalizedTitle];
  NSString *title = NSLocalizedStringFromTableInBundle(localizationKey, [self localizationTable], [self localizationBundle], nil);
  
  if ([[self titleParams] count] > 0) {
    NSString *find = @"%@";
    
    NSString *result = title;
    for (NSString *arg in [self titleParams]) {
      NSRange range = [result rangeOfString:find]; // this will find the first occurrence of the string
      if (range.location != NSNotFound) {
        result = [result stringByReplacingCharactersInRange:range withString:[arg description]];
      }
    }
    return result;
  }
  
  if ([title isEqualToString:localizationKey] || title == nil) {
    if ([self error]) {
      return [DSMessage messageTitleFromError:[self error]];
    }
    else if ([[[DSAlertsHandlerConfiguration sharedInstance] showGeneralMessageForUnknownCodes] boolValue]) {
      NSString *generalErrorTitleLocalizationKey = [NSString stringWithFormat:@"%@.%@.title",
                                                   DSAlertsGeneralDomain, DSAlertsGeneralCode];
      NSString *generalErrorTitle = NSLocalizedStringFromTableInBundle(generalErrorTitleLocalizationKey,
                                                                       [self localizationTable],
                                                                       [self localizationBundle],
                                                                       nil);
      return generalErrorTitle;
    }
    else {
      return title;
    }
  }
  
  return title;
}

+ (NSString *)messageTitleFromError:(NSError *)error
{
  return [error title] ? [error title] : NSLocalizedStringFromTableInBundle(@"general.error.title",
                                                                            [self localizationTable],
                                                                            [self localizationBundle],
                                                                            nil);
}

- (NSString *)generalErrorBody
{
  NSString *generalErrorBodyLocalizationKey = [NSString stringWithFormat:@"%@.%@.body",
                                               DSAlertsGeneralDomain, DSAlertsGeneralCode];
  NSString *generalErrorBody = NSLocalizedStringFromTableInBundle(generalErrorBodyLocalizationKey,
                                                                  [self localizationTable],
                                                                  [self localizationBundle],
                                                                  nil);
  return generalErrorBody;
}

- (NSString *)localizedBody
{
  NSString *localizationKey = [self keyForLocalizedBody];
  NSString *body = NSLocalizedStringFromTableInBundle(localizationKey,
                                                      [self localizationTable],
                                                      [self localizationBundle],
                                                      nil);
  
  if ([[self params] count] > 0) {
    NSString *find = @"%@";
    
    NSString *result = body;
    for (NSString *arg in [self params]) {
      NSRange range = [result rangeOfString:find]; // this will find the first occurrence of the string
      if (range.location != NSNotFound) {
        result = [result stringByReplacingCharactersInRange:range withString:[arg description]];
      }
    }
    return result;
  }
  else if ([body isEqualToString:localizationKey] || body == nil) {
    if ([self error]) {
      return [DSMessage messageBodyFromError:[self error]];
    }
    else if ([[[DSAlertsHandlerConfiguration sharedInstance] showGeneralMessageForUnknownCodes] boolValue]) {
      NSString *generalErrorBody = [self generalErrorBody];
      return generalErrorBody;
    }
    else {
      return body;
    }
  }
  else {
    return body;
  }
}

- (BOOL)isGeneralErrorMessage
{
  return [[self localizedBody] isEqualToString:[self generalErrorBody]];
}

+ (NSString *)messageBodyFromError:(NSError *)error
{
    return [error localizedDescription];
}

- (instancetype)initWithDomain:(DSMessageDomain *)theDomain
                          code:(DSMessageCode *)theCode
                        params:(id)theParam, ...
{
  va_list params;
  va_start(params, theParam);
  
  NSMutableArray *paramsArray = [NSMutableArray array];
  for (id param = theParam; param != nil; param = va_arg(params, id)) {
    [paramsArray addObject:param];
  }
  va_end(params);
  return [self initWithDomain:theDomain code:theCode paramsArray:paramsArray];
}

- (instancetype)initWithDomain:(DSMessageDomain *)theDomain
                          code:(DSMessageCode *)theCode
                   paramsArray:(nullable NSArray<id> *)theParams {
  self = [super init];
  if (self) {
    _domain = [theDomain copy];
    _code = theCode;

    _params = theParams.copy;
  }
  
  return self;
}

- (instancetype)initWithDomain:(DSMessageDomain *)theDomain code:(DSMessageCode *)theCode
{
  return [self initWithDomain:theDomain
                         code:theCode
                       params:nil];
}

+ (instancetype)messageWithDomain:(DSMessageDomain *)theDomain code:(DSMessageCode *)theCode
{
  DSMessage *message = [[DSMessage alloc] initWithDomain:theDomain
                                                  code:theCode];
  return message;
}

- (instancetype)initWithError:(NSError *)theError
{
  NSString *domain = [theError domain];
  NSInteger code = [theError code];

  if ([theError isErrorFromMessage]) {
    self = [self initWithDomain:domain code:[theError extractMessageCode]];
  }
  else {
    self = [self initWithDomain:domain
                           code:[NSString stringWithFormat:@"%lld", (long long)code]];
  }
  
  if (self) {
      _error = theError;
  }

  return self;
}

+ (instancetype)messageWithError:(NSError *)theError
{
  DSMessage *message = [[DSMessage alloc] initWithError:theError];
  return message;
}

+ (instancetype)unknownError
{
  NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain
                                       code:NSURLErrorUnknown
                                   userInfo:@{NSLocalizedDescriptionKey: @"Unknown Error"}];
  return [DSMessage messageWithError:error];
}

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
{
  return [self initWithError:[NSError errorWithTitle:title description:message]];
}

+ (instancetype)messageWithTitle:(NSString *)title
                         message:(NSString *)message
{
  return [[self alloc] initWithTitle:title message:message];
}

- (BOOL)isEqualToMessage:(DSMessage *)theObj
{
  BOOL incomeObjectIncorrect = (theObj == nil) || ([theObj isKindOfClass:[self class]] == NO);

  if (incomeObjectIncorrect == YES) {
    return NO;
  }

  BOOL domainsEqual = [[self domain] isEqualToString:[theObj domain]];
  BOOL codesEqual = [[self code] isEqualToString:[theObj code]];
  BOOL paramsEqual = YES;
  for (id param in [self params]) {
    for (id comparedParam in [theObj params]) {
      if (!paramsEqual) {
        break;
      }

      if (![param isEqual:comparedParam]) {
        paramsEqual = NO;
        break;
      }
    }
  }
  
  for (id param in [self titleParams]) {
    for (id comparedParam in [theObj titleParams]) {
      if (!paramsEqual) {
        break;
      }
      
      if (![param isEqual:comparedParam]) {
        paramsEqual = NO;
        break;
      }
    }
  }

  BOOL uniquenessEquals = (!self.uniqueID && !theObj.uniqueID) || [self.uniqueID isEqualToString:theObj.uniqueID];
  
  return (domainsEqual && codesEqual && paramsEqual && uniquenessEquals);
}

- (BOOL)isEqual:(id)object
{
  if (![object isKindOfClass:[DSMessage class]]) {
    return NO;
  }
  
  return [self isEqualToMessage:object];
}

- (NSUInteger)hash
{
  NSString *hashString = [NSString stringWithFormat:@"%@%@%@%@", [self domain], [self code], [self params], [self titleParams]];
  return [hashString hash];
}

- (NSString *)description
{
  NSString *str = [NSString stringWithFormat:@"domain: %@; code: %@",
                                             [self domain], [self code]];
  return str;
}


//===========================================================
//  Keyed Archiving
//
//===========================================================
- (void)encodeWithCoder:(NSCoder *)encoder
{
  [encoder encodeObject:self.context forKey:@"context"];
  [encoder encodeObject:self.domain forKey:@"domain"];
  [encoder encodeObject:self.code forKey:@"code"];
  [encoder encodeObject:self.params forKey:@"params"];
  [encoder encodeObject:self.error forKey:@"error"];
  [encoder encodeObject:self.titleParams forKey:@"titleParams"];
  [encoder encodeObject:self.uniqueID forKey:@"uniqueID"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
  self = [self init];
  if (self) {
    self.context = [decoder decodeObjectForKey:@"context"];
    self.domain = [decoder decodeObjectForKey:@"domain"];
    self.code = [decoder decodeObjectForKey:@"code"];
    self.params = [decoder decodeObjectForKey:@"params"];
    self.error = [decoder decodeObjectForKey:@"error"];
    self.titleParams = [decoder decodeObjectForKey:@"titleParams"];
    self.uniqueID = [decoder decodeObjectForKey:@"uniqueID"];
  }
  return self;
}

- (void)makeUnique
{
  self.uniqueID = [[NSUUID UUID] UUIDString];
}

- (BOOL)isEqualToError:(NSError *)error
{
  return DSMessageDomainsEqual(error.domain, self.domain) &&
  DSMessageCodesEqual(self.code, [@(error.code) description]);
}

- (BOOL)isEqualToDomain:(DSMessageDomain *)domain codeInteger:(NSInteger)code
{
  return [self isEqualToError:[NSError errorWithDomain:domain code:code userInfo:nil]];
}

- (BOOL)isEqualToDomain:(DSMessageDomain *)domain code:(DSMessageCode *)code
{
  return DSMessageDomainsEqual(self.domain, domain) && DSMessageCodesEqual(self.code, code);
}

@end
