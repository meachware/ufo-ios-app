//
//  NSDate+ISO8601.h
//  tvgidsios
//
//  Created by Edwin Schaap on 08-11-12.
//  Copyright (c) 2012 Veronica Magazine. All rights reserved.
//


@interface NSDate (ISO8601)

//ISO8601	2011-10-20 13:52:01+0000
//RFC-822	Thu, 20 Oct 2011 13:52:01 GMT

#pragma mark Class methods
+ (NSDate *)dateFromISOString:(NSString *)string;
+ (NSDate *)dateFromRFC822String:(NSString *)string;

#pragma mark Public methods
- (NSString *)ISOString;
- (NSString *)datePartISOString;
- (NSString *)timePartISOString;
- (NSString *)timePartShortISOString;
- (NSString *)RFC822String;
- (NSString *)relativeTime;

- (NSDate *)datePart;
- (BOOL)isToday;
- (BOOL)isYesterday;
- (BOOL)isSameDay:(NSDate *)date;
- (NSUInteger)hoursInDay;
- (NSDate *)dateWithInterval:(NSTimeInterval)interval;

@end
