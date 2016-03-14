
@import Foundation;


@interface DSAlertsHandlerConfiguration : NSObject
+ (nonnull instancetype)sharedInstance;
+ (nonnull instancetype)setupSharedInstanceWithConfigurationDictionary:(nonnull NSDictionary *)theConfiguration
                                                   messagesTableBundle:(nullable NSBundle *)bundle;

@property (nonatomic, strong, nonnull) NSBundle *messagesTableBundle;

@property (nonatomic, strong, readonly, nullable) NSString * modelAlertsClassName;
@property (nonatomic, strong, readonly, nullable) NSString * messagesLocalizationTableName;
@property (nonatomic, assign, readonly, nullable) NSNumber * showGeneralMessageForUnknownCodes;
@property (nonatomic, assign, readonly, nullable) NSNumber *showOfflineErrorsMoveThanOnce;
@end
