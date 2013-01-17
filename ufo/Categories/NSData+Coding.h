//
//  NSData+Coding.h
//  tvgidsios
//
//  Created by Edwin Schaap on 07-11-12.
//  Copyright (c) 2012 Veronica Magazine. All rights reserved.
//


@interface NSData (Coding)

#pragma mark Class methods
+ (NSData *)dataWithBase64String:(NSString *)base64String;
+ (NSData *)dataWithHexString:(NSString *)hexString;
+ (NSData *)dataWithUtf8String:(NSString *)utf8String;

#pragma mark Public methods
- (NSString *)base64string;
- (NSString *)hexString;
- (NSString *)utf8String;

@end
