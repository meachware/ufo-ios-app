//
//  NSDictionary+Json.m
//  tvgidsios
//
//  Created by Edwin Schaap on 24-11-12.
//  Copyright (c) 2012 Veronica Magazine. All rights reserved.
//

#import "NSDictionary+Json.h"
#import "NSDate+ISO8601.h"


BOOL equalBooleans(BOOL boolean1, BOOL boolean2)
{
	return boolean1 == boolean2;
}

BOOL equalDates(NSDate * date1, NSDate * date2)
{
	return date1 == date2 || [date1 isEqualToDate:date2];
}

BOOL equalIntegers(NSUInteger integer1, NSUInteger integer2)
{
	return integer1 == integer2;
}

BOOL equalLongs(long long1, long long2)
{
	return long1 == long2;
}

BOOL equalStrings(NSString * string1, NSString * string2)
{
	return string1 == string2 || [string1 isEqualToString:string2];
}

BOOL equalObjects(id object1, id object2)
{
	return object1 == object2 || [object1 isEqual:object2];
}

BOOL equalArrays(NSArray * array1, NSArray * array2)
{
	BOOL equal = NO;
	
	if (array1.count == array2.count)
	{
		equal = YES;
	}
	return equal;
}

BOOL equalOrderedArrays(NSArray * array1, NSArray * array2)
{
	BOOL equal = NO;
	
	if (array1.count == array2.count)
	{
		equal = YES;
	}
	return equal;
}


#pragma mark -


@implementation NSDictionary (Json)

#pragma mark Value by key methods

- (BOOL)booleanForKey:(NSString *)key
{
	NSNumber * number = [self objectForKey:key];
	return number ? number.boolValue : NO;
}

- (NSDate *)dateForKey:(NSString *)key
{
	NSNumber * number = [self objectForKey:key];
	return number ? [NSDate.alloc initWithTimeIntervalSinceReferenceDate:number.longValue] : nil;
}

- (NSDate *)unixDateForKey:(NSString *)key
{
	NSNumber * number = [self objectForKey:key];
	return number ? [NSDate.alloc initWithTimeIntervalSince1970:number.longValue] : nil;
}

- (NSDate *)formattedDateForKey:(NSString *)key
{
	NSString * string = [self objectForKey:key];
	return string ? [NSDate dateFromISOString:string] : nil;
}

- (NSInteger)integerForKey:(NSString *)key
{
	NSNumber * number = [self objectForKey:key];
	return number ? number.integerValue : 0;
}

- (long)longForKey:(NSString *)key
{
	NSNumber * number = [self objectForKey:key];
	return number ? number.longValue : 0;
}

- (NSString *)stringForKey:(NSString *)key
{
	return [self objectForKey:key];
}

- (NSArray *)arrayForKey:(NSString *)key
{
	NSArray * arrayValue = [self objectForKey:key];
	if (!arrayValue)
	{
		arrayValue = [NSArray.alloc init];
	}
	
	return arrayValue;
}

- (NSDictionary *)dictionaryForKey:(NSString *)key
{
	NSDictionary * dictionaryValue = [self objectForKey:key];
	if (!dictionaryValue)
	{
		dictionaryValue = [NSDictionary.alloc init];
	}
	
	return dictionaryValue;
}

#pragma mark Value by tested key methods

- (BOOL)booleanForTestedKey:(NSString *)key
{
	BOOL booleanValue = NO;
	
	id value = [self objectForKey:key];
	if ([value isKindOfClass:NSNumber.class])
	{
		booleanValue = ((NSNumber *)value).boolValue;
	}
	else if ([value isKindOfClass:NSString.class])
	{
		booleanValue = ((NSString *)value).boolValue;
	}
	
	return booleanValue;
}

- (NSDate *)dateForTestedKey:(NSString *)key
{
	NSDate * dateValue = nil;
	
	id value = [self objectForKey:key];
	if ([value isKindOfClass:NSDate.class])
	{
		dateValue = value;
	}
	else if ([value isKindOfClass:NSNumber.class])
	{
		dateValue = [NSDate.alloc initWithTimeIntervalSinceReferenceDate:((NSNumber *)value).longValue];
	}
	else if ([value isKindOfClass:NSString.class])
	{
		dateValue = [NSDate dateFromISOString:(NSString *)value];
	}
	
	return dateValue;
}

- (NSDate *)unixDateForTestedKey:(NSString *)key
{
	NSDate * dateValue = nil;
	
	id value = [self objectForKey:key];
	if ([value isKindOfClass:NSDate.class])
	{
		dateValue = value;
	}
	else if ([value isKindOfClass:NSNumber.class])
	{
		dateValue = [NSDate.alloc initWithTimeIntervalSince1970:((NSNumber *)value).longValue];
	}
	else if ([value isKindOfClass:NSString.class])
	{
		dateValue = [NSDate dateFromISOString:(NSString *)value];
	}
	
	return dateValue;
}

- (NSInteger)integerForTestedKey:(NSString *)key
{
	NSInteger integerValue = 0;
	
	id value = [self objectForKey:key];
	if ([value isKindOfClass:NSNumber.class])
	{
		integerValue = ((NSNumber *)value).integerValue;
	}
	else if ([value isKindOfClass:NSString.class])
	{
		integerValue = ((NSString *)value).integerValue;
	}
	
	return integerValue;
}

- (long)longForTestedKey:(NSString *)key
{
	long longValue = 0;
	
	id value = [self objectForKey:key];
	if ([value isKindOfClass:NSNumber.class])
	{
		longValue = ((NSNumber *)value).longValue;
	}
	else if ([value isKindOfClass:NSString.class])
	{
		longValue = ((NSString *)value).longLongValue;
	}
	
	return longValue;
}

- (NSString *)stringForTestedKey:(NSString *)key
{
	NSString * stringValue = nil;
	
	id value = [self objectForKey:key];
	if ([value isKindOfClass:NSString.class])
	{
		stringValue = (NSString *)value;
	}
	else if ([value isKindOfClass:NSNumber.class])
	{
		stringValue = ((NSNumber *)value).description;
	}
	else if (![value isKindOfClass:NSNull.class])
	{
		stringValue = ((NSObject *)value).description;
	}
	
	return stringValue;
}

- (NSArray *)arrayForTestedKey:(NSString *)key
{
	NSArray * arrayValue = nil;
	
	id value = [self objectForKey:key];
	if ([value isKindOfClass:NSArray.class])
	{
		arrayValue = (NSArray *)value;
	}
	else
	{
		arrayValue = [NSArray.alloc init];
	}
	
	return arrayValue;
}

- (NSDictionary *)dictionaryForTestedKey:(NSString *)key
{
	NSDictionary * dictionaryValue = nil;
	
	id value = [self objectForKey:key];
	if ([value isKindOfClass:NSDictionary.class])
	{
		dictionaryValue = (NSDictionary *)value;
	}
	else
	{
		dictionaryValue = [NSDictionary.alloc init];
	}
	
	return dictionaryValue;
}

#pragma mark Update by key methods

- (void)updateBoolean:(BOOL *)booleanValue forKey:(NSString *)key
{
	NSNumber * number = [self objectForKey:key];
	if (number)
	{
		* booleanValue = number.boolValue;
	}
}

- (void)updateDate:(NSDate **)dateValue forKey:(NSString *)key
{
	NSNumber * number = [self objectForKey:key];
	if (number)
	{
		* dateValue = [NSDate.alloc initWithTimeIntervalSinceReferenceDate:number.longValue];
	}
}

- (void)updateUnixDate:(NSDate **)dateValue forKey:(NSString *)key
{
	NSNumber * number = [self objectForKey:key];
	if (number)
	{
		* dateValue = [NSDate.alloc initWithTimeIntervalSince1970:number.longValue];
	}
}

- (void)updateFormattedDate:(NSDate **)dateValue forKey:(NSString *)key
{
	NSString * string = [self objectForKey:key];
	if (string)
	{
		* dateValue = [NSDate dateFromISOString:string];
	}
}

- (void)updateInteger:(NSInteger *)integerValue forKey:(NSString *)key
{
	NSNumber * number = [self objectForKey:key];
	if (number)
	{
		* integerValue = number.integerValue;
	}
}

- (void)updateLong:(long *)longValue forKey:(NSString *)key
{
	NSNumber * number = [self objectForKey:key];
	if (number)
	{
		* longValue = number.longValue;
	}
}

- (void)updateString:(NSString **)stringValue forKey:(NSString *)key
{
	NSString * string = [self objectForKey:key];
	if (string)
	{
		* stringValue = string;
	}
}

#pragma mark Update by tested key methods

- (void)updateBoolean:(BOOL *)booleanValue forTestedKey:(NSString *)key
{
	id value = [self objectForKey:key];
	if ([value isKindOfClass:NSNumber.class])
	{
		* booleanValue = ((NSNumber *)value).boolValue;
	}
	else if ([value isKindOfClass:NSString.class])
	{
		* booleanValue = ((NSString *)value).boolValue;
	}
}

- (void)updateDate:(NSDate **)dateValue forTestedKey:(NSString *)key
{
	id value = [self objectForKey:key];
	if ([value isKindOfClass:NSDate.class])
	{
		* dateValue = value;
	}
	else if ([value isKindOfClass:NSNumber.class])
	{
		* dateValue = [NSDate.alloc initWithTimeIntervalSinceReferenceDate:((NSNumber *)value).longValue];
	}
	else if ([value isKindOfClass:NSString.class])
	{
		* dateValue = [NSDate dateFromISOString:value];
	}
}

- (void)updateUnixDate:(NSDate **)dateValue forTestedKey:(NSString *)key
{
	id value = [self objectForKey:key];
	if ([value isKindOfClass:NSDate.class])
	{
		* dateValue = value;
	}
	else if ([value isKindOfClass:NSNumber.class])
	{
		* dateValue = [NSDate.alloc initWithTimeIntervalSince1970:((NSNumber *)value).longValue];
	}
	else if ([value isKindOfClass:NSString.class])
	{
		* dateValue = [NSDate dateFromISOString:value];
	}
}

- (void)updateInteger:(NSInteger *)integerValue forTestedKey:(NSString *)key
{
	id value = [self objectForKey:key];
	if ([value isKindOfClass:NSNumber.class])
	{
		* integerValue = ((NSNumber *)value).integerValue;
	}
	else if ([value isKindOfClass:NSString.class])
	{
		* integerValue = ((NSString *)value).integerValue;
	}
}

- (void)updateLong:(long *)longValue forTestedKey:(NSString *)key
{
	id value = [self objectForKey:key];
	if ([value isKindOfClass:NSNumber.class])
	{
		* longValue = ((NSNumber *)value).longValue;
	}
	else if ([value isKindOfClass:NSString.class])
	{
		* longValue = ((NSString *)value).longLongValue;
	}
}

- (void)updateString:(NSString **)stringValue forTestedKey:(NSString *)key
{
	id value = [self objectForKey:key];
	if ([value isKindOfClass:NSString.class])
	{
		* stringValue = (NSString *)value;
	}
	else if ([value isKindOfClass:NSNumber.class])
	{
		* stringValue = ((NSNumber *)value).description;
	}
	else if (![value isKindOfClass:NSNull.class])
	{
		* stringValue = ((NSObject *)value).description;
	}
}

@end


#pragma mark -


@implementation NSMutableDictionary (Json)

- (void)setBoolean:(BOOL)booleanValue forKey:(NSString *)key
{
	if (booleanValue)
	{
		[self setObject:[NSNumber numberWithBool:booleanValue] forKey:key];
	}
}

- (void)setDate:(NSDate *)dateValue forKey:(NSString *)key
{
	if (dateValue)
	{
		[self setObject:[NSNumber numberWithLong:dateValue.timeIntervalSinceReferenceDate] forKey:key];
	}
}

- (void)setFormattedDate:(NSDate *)dateValue forKey:(NSString *)key
{
	if (dateValue)
	{
		[self setObject:dateValue.ISOString forKey:key];
	}
}

- (void)setInteger:(NSInteger)integerValue forKey:(NSString *)key
{
	if (integerValue != 0)
	{
		[self setObject:[NSNumber numberWithInteger:integerValue] forKey:key];
	}
}

- (void)setLong:(long)longValue forKey:(NSString *)key
{
	if (longValue != 0)
	{
		[self setObject:[NSNumber numberWithLong:longValue] forKey:key];
	}
}

- (void)setString:(NSString *)stringValue forKey:(NSString *)key
{
	if (stringValue && stringValue.length > 0)
	{
		[self setObject:stringValue forKey:key];
	}
}

- (void)setJsonArray:(NSArray *)arrayValue forKey:(NSString *)key
{
	if (arrayValue && arrayValue.count > 0)
	{
		[self setObject:arrayValue forKey:key];
	}
}

- (void)setJsonDictionary:(NSDictionary *)dictionaryValue forKey:(NSString *)key
{
	if (dictionaryValue && dictionaryValue.count > 0)
	{
		[self setObject:dictionaryValue forKey:key];
	}
}

@end


#pragma mark -


@implementation NSArray (Json)

#pragma mark Value by index methods

- (BOOL)booleanAtIndex:(NSUInteger)index
{
	NSNumber * number = [self objectAtIndex:index];
	return number ? number.boolValue : NO;
}

- (NSDate *)dateAtIndex:(NSUInteger)index
{
	NSNumber * number = [self objectAtIndex:index];
	return number ? [NSDate.alloc initWithTimeIntervalSinceReferenceDate:number.longValue] : nil;
}

- (NSDate *)unixDateAtIndex:(NSUInteger)index
{
	NSNumber * number = [self objectAtIndex:index];
	return number ? [NSDate.alloc initWithTimeIntervalSince1970:number.longValue] : nil;
}

- (NSDate *)formattedDateAtIndex:(NSUInteger)index
{
	NSString * string = [self objectAtIndex:index];
	return string ? [NSDate dateFromISOString:string] : nil;
}

- (NSInteger)integerAtIndex:(NSUInteger)index
{
	NSNumber * number = [self objectAtIndex:index];
	return number ? number.integerValue : 0;
}

- (long)longAtIndex:(NSUInteger)index
{
	NSNumber * number = [self objectAtIndex:index];
	return number ? number.longValue : 0;
}

- (NSString *)stringAtIndex:(NSUInteger)index
{
	return [self objectAtIndex:index];
}

- (NSArray *)arrayAtIndex:(NSUInteger)index
{
	NSArray * arrayValue = [self objectAtIndex:index];
	if (!arrayValue)
	{
		arrayValue = [NSArray.alloc init];
	}
	
	return arrayValue;
}

- (NSDictionary *)dictionaryAtIndex:(NSUInteger)index
{
	NSDictionary * dictionaryValue = [self objectAtIndex:index];
	if (!dictionaryValue)
	{
		dictionaryValue = [NSDictionary.alloc init];
	}
	
	return dictionaryValue;
}

#pragma mark Tested value by index methods

- (BOOL)testedBooleanAtIndex:(NSUInteger)index
{
	BOOL booleanValue = NO;
	
	id value = index < self.count ? [self objectAtIndex:index] : nil;
	if ([value isKindOfClass:NSNumber.class])
	{
		booleanValue = ((NSNumber *)value).boolValue;
	}
	else if ([value isKindOfClass:NSString.class])
	{
		booleanValue = ((NSString *)value).boolValue;
	}
	
	return booleanValue;
}

- (NSDate *)testedDateAtIndex:(NSUInteger)index
{
	NSDate * dateValue = nil;
	
	id value = index < self.count ? [self objectAtIndex:index] : nil;
	if ([value isKindOfClass:NSDate.class])
	{
		dateValue = value;
	}
	else if ([value isKindOfClass:NSNumber.class])
	{
		dateValue = [NSDate.alloc initWithTimeIntervalSinceReferenceDate:((NSNumber *)value).longValue];
	}
	else if ([value isKindOfClass:NSString.class])
	{
		dateValue = [NSDate dateFromISOString:(NSString *)value];
	}
	
	return dateValue;
}

- (NSDate *)testedUnixDateAtIndex:(NSUInteger)index
{
	NSDate * dateValue = nil;
	
	id value = index < self.count ? [self objectAtIndex:index] : nil;
	if ([value isKindOfClass:NSDate.class])
	{
		dateValue = value;
	}
	else if ([value isKindOfClass:NSNumber.class])
	{
		dateValue = [NSDate.alloc initWithTimeIntervalSince1970:((NSNumber *)value).longValue];
	}
	else if ([value isKindOfClass:NSString.class])
	{
		dateValue = [NSDate dateFromISOString:(NSString *)value];
	}
	
	return dateValue;
}

- (NSInteger)testedIntegerAtIndex:(NSUInteger)index
{
	NSInteger integerValue = 0;
	
	id value = index < self.count ? [self objectAtIndex:index] : nil;
	if ([value isKindOfClass:NSNumber.class])
	{
		integerValue = ((NSNumber *)value).integerValue;
	}
	else if ([value isKindOfClass:NSString.class])
	{
		integerValue = ((NSString *)value).integerValue;
	}
	
	return integerValue;
}

- (long)testedLongAtIndex:(NSUInteger)index
{
	long longValue = 0;
	
	id value = index < self.count ? [self objectAtIndex:index] : nil;
	if ([value isKindOfClass:NSNumber.class])
	{
		longValue = ((NSNumber *)value).longValue;
	}
	else if ([value isKindOfClass:NSString.class])
	{
		longValue = ((NSString *)value).longLongValue;
	}
	
	return longValue;
}

- (NSString *)testedStringAtIndex:(NSUInteger)index
{
	NSString * stringValue = nil;
	
	id value = index < self.count ? [self objectAtIndex:index] : nil;
	if ([value isKindOfClass:NSString.class])
	{
		stringValue = (NSString *)value;
	}
	else if ([value isKindOfClass:NSNumber.class])
	{
		stringValue = ((NSNumber *)value).description;
	}
	else if (![value isKindOfClass:NSNull.class])
	{
		stringValue = ((NSObject *)value).description;
	}
	
	return stringValue;
}

- (NSArray *)testedArrayAtIndex:(NSUInteger)index
{
	NSArray * arrayValue = nil;
	
	id value = index < self.count ? [self objectAtIndex:index] : nil;
	if ([value isKindOfClass:NSArray.class])
	{
		arrayValue = (NSArray *)value;
	}
	else
	{
		arrayValue = [NSArray.alloc init];
	}
	
	return arrayValue;
}

- (NSDictionary *)testedDictionaryAtIndex:(NSUInteger)index
{
	NSDictionary * dictionaryValue = nil;
	
	id value = index < self.count ? [self objectAtIndex:index] : nil;
	if ([value isKindOfClass:NSDictionary.class])
	{
		dictionaryValue = (NSDictionary *)value;
	}
	else
	{
		dictionaryValue = [NSDictionary.alloc init];
	}
	
	return dictionaryValue;
}

#pragma mark Enumeration methods

- (void)enumerateBooleansUsingBlock:(void (^)(BOOL booleanValue, NSUInteger index, BOOL * stop))block
{
	[self enumerateObjectsUsingBlock:^(id value, NSUInteger index, BOOL * stop) {
		if ([value isKindOfClass:NSNumber.class])
		{
			block(((NSNumber *)value).boolValue, index, stop);
		}
		else if ([value isKindOfClass:NSString.class])
		{
			block(((NSString *)value).boolValue, index, stop);
		}
	}];
}

- (void)enumerateDatesUsingBlock:(void (^)(NSDate * dateValue, NSUInteger index, BOOL * stop))block
{
	[self enumerateObjectsUsingBlock:^(id value, NSUInteger index, BOOL * stop) {
		if ([value isKindOfClass:NSDate.class])
		{
			block(value, index, stop);
		}
		else if ([value isKindOfClass:NSNumber.class])
		{
			block([NSDate.alloc initWithTimeIntervalSinceReferenceDate:((NSNumber *)value).longValue], index, stop);
		}
		else if ([value isKindOfClass:NSString.class])
		{
			block([NSDate dateFromISOString:(NSString *)value], index, stop);
		}
	}];
}

- (void)enumerateUnixDatesUsingBlock:(void (^)(NSDate * dateValue, NSUInteger index, BOOL * stop))block
{
	[self enumerateObjectsUsingBlock:^(id value, NSUInteger index, BOOL * stop) {
		if ([value isKindOfClass:NSDate.class])
		{
			block(value, index, stop);
		}
		else if ([value isKindOfClass:NSNumber.class])
		{
			block([NSDate.alloc initWithTimeIntervalSince1970:((NSNumber *)value).longValue], index, stop);
		}
		else if ([value isKindOfClass:NSString.class])
		{
			block([NSDate dateFromISOString:(NSString *)value], index, stop);
		}
	}];
}

- (void)enumerateIntegersUsingBlock:(void (^)(NSInteger integerValue, NSUInteger index, BOOL * stop))block
{
	[self enumerateObjectsUsingBlock:^(id value, NSUInteger index, BOOL * stop) {
		if ([value isKindOfClass:NSNumber.class])
		{
			block(((NSNumber *)value).integerValue, index, stop);
		}
		else if ([value isKindOfClass:NSString.class])
		{
			block(((NSString *)value).integerValue, index, stop);
		}
	}];
}

- (void)enumerateLongsUsingBlock:(void (^)(long longValue, NSUInteger index, BOOL * stop))block
{
	[self enumerateObjectsUsingBlock:^(id value, NSUInteger index, BOOL * stop) {
		if ([value isKindOfClass:NSNumber.class])
		{
			block(((NSNumber *)value).longValue, index, stop);
		}
		else if ([value isKindOfClass:NSString.class])
		{
			block(((NSString *)value).longLongValue, index, stop);
		}
	}];
}

- (void)enumerateStringsUsingBlock:(void (^)(NSString * stringValue, NSUInteger index, BOOL * stop))block
{
	[self enumerateObjectsUsingBlock:^(id value, NSUInteger index, BOOL * stop) {
		if ([value isKindOfClass:NSString.class])
		{
			block(value, index, stop);
		}
		else if ([value isKindOfClass:NSNumber.class])
		{
			block(((NSNumber *)value).description, index, stop);
		}
		else if (![value isKindOfClass:NSNull.class])
		{
			block(((NSObject *)value).description, index, stop);
		}
	}];
}

- (void)enumerateArraysUsingBlock:(void (^)(NSArray * arrayValue, NSUInteger index, BOOL * stop))block
{
	[self enumerateObjectsUsingBlock:^(id value, NSUInteger index, BOOL * stop) {
		if ([value isKindOfClass:NSArray.class])
		{
			block(value, index, stop);
		}
	}];
}

- (void)enumerateDictionariesUsingBlock:(void (^)(NSDictionary * dictionaryValue, NSUInteger index, BOOL * stop))block
{
	[self enumerateObjectsUsingBlock:^(id value, NSUInteger index, BOOL * stop) {
		if ([value isKindOfClass:NSDictionary.class])
		{
			block(value, index, stop);
		}
	}];
}

@end


#pragma mark -


@implementation NSMutableArray (Json)

- (void)addJsonArray:(NSArray *)arrayValue
{
	if (arrayValue && arrayValue.count > 0)
	{
		[self addObject:arrayValue];
	}
	
}

- (void)addJsonDictionary:(NSDictionary *)dictionaryValue
{
	if (dictionaryValue && dictionaryValue.count > 0)
	{
		[self addObject:dictionaryValue];
	}
}

@end
