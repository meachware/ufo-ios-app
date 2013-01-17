//
//  NSDate+ISO8601.m
//  tvgidsios
//
//  Created by Edwin Schaap on 08-11-12.
//  Copyright (c) 2012 Veronica Magazine. All rights reserved.
//

#import "NSDate+ISO8601.h"


const long kMinuteInterval = 60;
const long kHourInterval = 60 * kMinuteInterval;
const long kDayInterval = 24 * kHourInterval;


@implementation NSDate (ISO8601)

#pragma mark Class methods

+ (NSDate *)dateFromISOString:(NSString *)string
{
	static NSCalendar * calendar = nil;
	
	static dispatch_once_t done;
	dispatch_once(&done, ^{
		calendar = NSCalendar.currentCalendar;
	});
	
	@synchronized (self)
	{
		// YYYY-MM-DD HH:MM:SSZ
		// YYYY-MM-DDTHH:MM:SSZ
		// YYYY-MM-DD HH:MM:SS+0000
		// YYYY-MM-DD HH:MM:SS+00:00
		// 0123456789012345678901234
		
		NSDate * date = nil;
		
		if (string.length >= 19)
		{
			NSDateComponents * components = [NSDateComponents.alloc init];
			components.year = [string substringWithRange:NSMakeRange(0, 4)].integerValue;
			components.month = [string substringWithRange:NSMakeRange(5, 2)].integerValue;
			components.day = [string substringWithRange:NSMakeRange(8, 2)]. integerValue;
			components.hour = [string substringWithRange:NSMakeRange(11, 2)].integerValue;
			components.minute = [string substringWithRange:NSMakeRange(14, 2)].integerValue;
			components.second = [string substringWithRange:NSMakeRange(17, 2)].integerValue;
			
			NSTimeZone * zone = NSTimeZone.systemTimeZone;
			
			if (string.length >= 20 && [string characterAtIndex:19] == 'Z')
			{
				zone = [NSTimeZone timeZoneForSecondsFromGMT:0];
			}
			else if (string.length >= 24)
			{
				NSInteger hours = [string substringWithRange:NSMakeRange(19, 3)].integerValue;
				NSUInteger offset = ([string characterAtIndex:22] && string.length >= 25) == ':' ? 23 : 22;
				NSInteger minutes = [string substringWithRange:NSMakeRange(offset, 2)].integerValue;
				
				if (hours >= 0 && hours < 24 && minutes >= 0 && minutes < 60)
				{
					zone = [NSTimeZone timeZoneForSecondsFromGMT:(hours * 60 + minutes) * 60];
				}
			}
			components.timeZone = zone;
			
			date = [calendar dateFromComponents:components];
		}
		return date;
	}
}

+ (NSDate *)dateFromRFC822String:(NSString *)string
{
	static NSDateFormatter * formatter = nil;
	
	static dispatch_once_t done;
	dispatch_once(&done, ^{
		formatter = [NSDateFormatter.alloc init];
		formatter.timeZone = NSTimeZone.localTimeZone;
		formatter.dateFormat = @"EEE, dd MMM yyyy HH:mm:ss Z";
	});
	
	@synchronized (self)
	{
		return [formatter dateFromString:string];
	}
}

#pragma mark Public methods

- (NSString *)ISOString
{
	static NSDateFormatter * formatter = nil;
	
	static dispatch_once_t done;
	dispatch_once(&done, ^{
		formatter = [NSDateFormatter.alloc init];
		formatter.timeZone = NSTimeZone.localTimeZone;
		formatter.dateFormat = @"yyyy-MM-dd HH:mm:ssZ";
	});
	
	@synchronized (self)
	{
		return [formatter stringFromDate:self];
	}
}

- (NSString *)datePartISOString
{
	static NSDateFormatter * formatter = nil;
	
	static dispatch_once_t done;
	dispatch_once(&done, ^{
		formatter = [NSDateFormatter.alloc init];
		formatter.timeZone = NSTimeZone.localTimeZone;
		formatter.dateFormat = @"yyyy-MM-dd";
	});
	
	return [formatter stringFromDate:self];
}

- (NSString *)timePartISOString
{
	static NSDateFormatter * formatter = nil;
	
	static dispatch_once_t done;
	dispatch_once(&done, ^{
		formatter = [NSDateFormatter.alloc init];
		formatter.timeZone = NSTimeZone.localTimeZone;
		formatter.dateFormat = @"HH:mm:ss";
	});
	
	return [formatter stringFromDate:self];
}

- (NSString *)timePartShortISOString
{
	static NSDateFormatter * formatter = nil;
	
	static dispatch_once_t done;
	dispatch_once(&done, ^{
		formatter = [NSDateFormatter.alloc init];
		formatter.timeZone = NSTimeZone.localTimeZone;
		formatter.dateFormat = @"HH:mm";
	});
	
	return [formatter stringFromDate:self];
}


- (NSString *)RFC822String
{
	static NSDateFormatter * formatter = nil;
	
	static dispatch_once_t done;
	dispatch_once(&done, ^{
		formatter = [NSDateFormatter.alloc init];
		formatter.timeZone = NSTimeZone.localTimeZone;
		formatter.dateFormat = @"EEE, dd MMM yyyy HH:mm:ss Z";
	});
	
	@synchronized (self)
	{
		return [formatter stringFromDate:self];
	}
}

- (NSDate *)datePart
{
	static NSCalendar * calendar = nil;
	
	static dispatch_once_t done;
	dispatch_once(&done, ^{
		calendar = NSCalendar.currentCalendar;
	});

	NSDateComponents * components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:self];
	
	return [calendar dateFromComponents:components];
}

- (BOOL)isToday
{
	long dayInterval = trunc([self timeIntervalSinceReferenceDate]);
	NSTimeInterval dayOffset = dayInterval - (dayInterval % kDayInterval);
	
	long todayInterval = trunc([NSDate.date timeIntervalSinceReferenceDate]);
	NSTimeInterval todayOffset = todayInterval - (todayInterval % kDayInterval);
	
	return dayOffset == todayOffset;
}

- (BOOL)isYesterday
{
	long dayInterval = trunc([self timeIntervalSinceReferenceDate]);
	NSTimeInterval dayOffset = dayInterval - (dayInterval % kDayInterval);
	
	long todayInterval = trunc([NSDate.date timeIntervalSinceReferenceDate]);
	NSTimeInterval todayOffset = todayInterval - (todayInterval % kDayInterval);
	
	return dayOffset == (todayOffset - kDayInterval);
}

- (BOOL)isSameDay:(NSDate *)date
{
	long dayInterval = trunc([self timeIntervalSinceReferenceDate]);
	NSTimeInterval dayOffset = dayInterval - (dayInterval % kDayInterval);
	
	long todayInterval = trunc([date timeIntervalSinceReferenceDate]);
	NSTimeInterval todayOffset = todayInterval - (todayInterval % kDayInterval);
	
	return dayOffset == todayOffset;
}

- (NSUInteger)hoursInDay
{
	static NSCalendar * calendar = nil;
	
	static dispatch_once_t done;
	dispatch_once(&done, ^{
		calendar = NSCalendar.currentCalendar;
	});
	
	NSDateComponents * components = [calendar components:NSHourCalendarUnit fromDate:self];
	return components.hour;
}

- (NSDate *)dateWithInterval:(NSTimeInterval)interval
{
	return [NSDate.alloc initWithTimeInterval:interval sinceDate:self];
}

@end
