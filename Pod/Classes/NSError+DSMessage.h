//
//  NSError+DSMessage.h
//  DSLib
//
//  Created by Alexander Belyavskiy on 6/27/14.
//  Copyright (c) 2014 DS ltd. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@class DSMessage;

@interface NSError (DSMessage)
- (nullable NSString *)title;
+ (instancetype)errorWithTitle:(NSString *)title
                   description:(NSString *)description;
+ (instancetype)errorWithTitle:(NSString *)title
                   description:(NSString *)description
                        domain:(NSString *)domain
                          code:(NSString *)code;
+ (instancetype)errorFromMessage:(DSMessage *)message;
- (BOOL)isErrorFromMessage;
- (nullable NSString *)extractMessageCode;

@end

NS_ASSUME_NONNULL_END
