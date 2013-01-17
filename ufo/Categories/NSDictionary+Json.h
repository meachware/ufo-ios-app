//
//  NSDictionary+Json.h
//  tvgidsios
//
//  Created by Edwin Schaap on 24-11-12.
//  Copyright (c) 2012 Veronica Magazine. All rights reserved.
//


BOOL equalBooleans(BOOL boolean1, BOOL boolean2);
BOOL equalDates(NSDate * date1, NSDate * date2);
BOOL equalIntegers(NSUInteger integer1, NSUInteger integer2);
BOOL equalLongs(long long1, long long2);
BOOL equalStrings(NSString * string1, NSString * string2);
BOOL equalObjects(id object1, id object2);
BOOL equalArrays(NSArray * array1, NSArray * array2);
BOOL equalOrderedArrays(NSArray * array1, NSArray * array2);


#pragma mark -


@interface NSDictionary (Json)

#pragma mark Value by key methods
- (BOOL)booleanForKey:(NSString *)key;
- (NSDate *)dateForKey:(NSString *)key;
- (NSDate *)unixDateForKey:(NSString *)key;
- (NSDate *)formattedDateForKey:(NSString *)key;
- (NSInteger)integerForKey:(NSString *)key;
- (long)longForKey:(NSString *)key;
- (NSString *)stringForKey:(NSString *)key;
- (NSArray *)arrayForKey:(NSString *)key;
- (NSDictionary *)dictionaryForKey:(NSString *)key;

#pragma mark Value by tested key methods
- (BOOL)booleanForTestedKey:(NSString *)key;
- (NSDate *)dateForTestedKey:(NSString *)key;
- (NSDate *)unixDateForTestedKey:(NSString *)key;
- (NSInteger)integerForTestedKey:(NSString *)key;
- (long)longForTestedKey:(NSString *)key;
- (NSString *)stringForTestedKey:(NSString *)key;
- (NSArray *)arrayForTestedKey:(NSString *)key;
- (NSDictionary *)dictionaryForTestedKey:(NSString *)key;

#pragma mark Update by key methods
- (void)updateBoolean:(BOOL *)booleanValue forKey:(NSString *)key;
- (void)updateDate:(NSDate **)dateValue forKey:(NSString *)key;
- (void)updateUnixDate:(NSDate **)dateValue forKey:(NSString *)key;
- (void)updateFormattedDate:(NSDate **)dateValue forKey:(NSString *)key;
- (void)updateInteger:(NSInteger *)integerValue forKey:(NSString *)key;
- (void)updateLong:(long *)longValue forKey:(NSString *)key;
- (void)updateString:(NSString **)stringValue forKey:(NSString *)key;

#pragma mark Update by tested key methods
- (void)updateBoolean:(BOOL *)booleanValue forTestedKey:(NSString *)key;
- (void)updateDate:(NSDate **)dateValue forTestedKey:(NSString *)key;
- (void)updateUnixDate:(NSDate **)dateValue forTestedKey:(NSString *)key;
- (void)updateInteger:(NSInteger *)integerValue forTestedKey:(NSString *)key;
- (void)updateLong:(long *)longValue forTestedKey:(NSString *)key;
- (void)updateString:(NSString **)stringValue forTestedKey:(NSString *)key;

@end

#pragma mark -

@interface NSMutableDictionary (Json)

- (void)setBoolean:(BOOL)booleanValue forKey:(NSString *)key;
- (void)setDate:(NSDate *)dateValue forKey:(NSString *)key;
- (void)setFormattedDate:(NSDate *)dateValue forKey:(NSString *)key;
- (void)setInteger:(NSInteger)integerValue forKey:(NSString *)key;
- (void)setLong:(long)longValue forKey:(NSString *)key;
- (void)setString:(NSString *)stringValue forKey:(NSString *)key;
- (void)setJsonArray:(NSArray *)arrayValue forKey:(NSString *)key;
- (void)setJsonDictionary:(NSDictionary *)dictionaryValue forKey:(NSString *)key;

@end

#pragma mark -

@interface NSArray (Json)

#pragma mark Value by index methods
- (BOOL)booleanAtIndex:(NSUInteger)index;
- (NSDate *)dateAtIndex:(NSUInteger)index;
- (NSDate *)unixDateAtIndex:(NSUInteger)index;
- (NSDate *)formattedDateAtIndex:(NSUInteger)index;
- (NSInteger)integerAtIndex:(NSUInteger)index;
- (long)longAtIndex:(NSUInteger)index;
- (NSString *)stringAtIndex:(NSUInteger)index;
- (NSArray *)arrayAtIndex:(NSUInteger)index;
- (NSDictionary *)dictionaryAtIndex:(NSUInteger)index;

#pragma mark Tested value by index methods
- (BOOL)testedBooleanAtIndex:(NSUInteger)index;
- (NSDate *)testedDateAtIndex:(NSUInteger)index;
- (NSDate *)testedUnixDateAtIndex:(NSUInteger)index;
- (NSInteger)testedIntegerAtIndex:(NSUInteger)index;
- (long)testedLongAtIndex:(NSUInteger)index;
- (NSString *)testedStringAtIndex:(NSUInteger)index;
- (NSArray *)testedArrayAtIndex:(NSUInteger)index;
- (NSDictionary *)testedDictionaryAtIndex:(NSUInteger)index;

#pragma mark Enumeration methods
- (void)enumerateBooleansUsingBlock:(void (^)(BOOL booleanValue, NSUInteger index, BOOL * stop))block;
- (void)enumerateDatesUsingBlock:(void (^)(NSDate * dateValue, NSUInteger index, BOOL * stop))block;
- (void)enumerateUnixDatesUsingBlock:(void (^)(NSDate * dateValue, NSUInteger index, BOOL * stop))block;
- (void)enumerateIntegersUsingBlock:(void (^)(NSInteger integerValue, NSUInteger index, BOOL * stop))block;
- (void)enumerateLongsUsingBlock:(void (^)(long longValue, NSUInteger index, BOOL * stop))block;
- (void)enumerateStringsUsingBlock:(void (^)(NSString * stringValue, NSUInteger index, BOOL * stop))block;
- (void)enumerateArraysUsingBlock:(void (^)(NSArray * arrayValue, NSUInteger index, BOOL * stop))block;
- (void)enumerateDictionariesUsingBlock:(void (^)(NSDictionary * dictionaryValue, NSUInteger index, BOOL * stop))block;

@end

#pragma mark -

@interface NSMutableArray (Json)

- (void)addJsonArray:(NSArray *)arrayValue;
- (void)addJsonDictionary:(NSDictionary *)dictionaryValue;

@end
