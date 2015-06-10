
@import Foundation;


@interface DSAlertsHandlerConfiguration : NSObject
+ (nonnull instancetype)sharedInstance;
+ (nonnull instancetype)setupSharedInstanceWithConfigurationDictionary:(nonnull NSDictionary *)theConfiguration;

@property (nonatomic, strong, readonly, nullable) NSString * modelAlertsClassName;
@property (nonatomic, strong, readonly, nullable) NSString * messagesLocalizationTableName;
@property (nonatomic, assign, readonly, nullable) NSNumber * showGeneralMessageForUnknownCodes;
@end
