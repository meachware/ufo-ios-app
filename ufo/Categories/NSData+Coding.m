//
//  NSData+Coding.m
//  tvgidsios
//
//  Created by Edwin Schaap on 07-11-12.
//  Copyright (c) 2012 Veronica Magazine. All rights reserved.
//

#import "NSData+Coding.h"


static const char __base64EncodingTable[64] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
static const char __hexEncodingTable[16] = "0123456789ABCDEF";
static const short __base64DecodingTable[256] = {
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -1, -1, -2, -1, -1, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-1, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, 62, -2, -2, -2, 63,
	52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -2, -2, -2, -2, -2, -2,
	-2,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
	15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -2, -2, -2, -2, -2,
	-2, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
	41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2
};
static const short __hexDecodingTable[256] = {
	0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
	0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
	0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
	0,  1,  2,  3,  4,  5,  6,  7,  8,  9,  0,  0,  0,  0,  0,  0,
	0, 10, 11, 12, 13, 14, 15,  0,  0,  0,  0,  0,  0,  0,  0,  0,
	0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
	0, 10, 11, 12, 13, 14, 15,  0,  0,  0,  0,  0,  0,  0,  0,  0,
	0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
	0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
	0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
	0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
	0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
	0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
	0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
	0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
	0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
};


@implementation NSData (Coding)

#pragma mark Class methods

+ (NSData *)dataWithBase64String:(NSString *)base64String
{
	const char * postion = [base64String cStringUsingEncoding:NSASCIIStringEncoding];
	int length = strlen(postion);
	
	unsigned char * result = calloc(length, sizeof(char));
	
	int current;
	int index = 0;
	int resultPosition = 0;
	
	while (((current = * postion++) != '\0') && (length-- > 0))
	{
		if (current == '=')
		{
			if (*postion != '=' && ((index % 4) == 1))
			{
				free(result);
				return nil;
			}
			continue;
		}
		
		current = __base64DecodingTable[current];
		if (current == -1)
		{
			continue;
		}
		else if (current == -2)
		{
			free(result);
			return nil;
		}
		
		switch (index % 4)
		{
			case 0:
				result[resultPosition] = current << 2;
				break;
			case 1:
				result[resultPosition++] |= current >> 4;
				result[resultPosition] = (current & 0x0f) << 4;
				break;
			case 2:
				result[resultPosition++] |= current >> 2;
				result[resultPosition] = (current & 0x03) << 6;
				break;
			case 3:
				result[resultPosition++] |= current;
				break;
		}
		index++;
	}
	
	int extra = resultPosition;
	if (current == '=')
	{
		switch (index % 4)
		{
			case 1:
				free(result);
				return nil;
			case 2:
				extra++;
			case 3:
				result[extra] = 0;
		}
	}
	
	NSData * data = [NSData.alloc initWithBytes:result length:resultPosition];
	free(result);
	
	return data;
}

+ (NSData *)dataWithHexString:(NSString *)hexString
{
	const char * postion = [hexString cStringUsingEncoding:NSASCIIStringEncoding];
	int length = strlen(postion);
	
	unsigned char * result = calloc(length / 2, sizeof(char));
	
	int index = 0;
	while (* postion != '\0')
	{
		short value = __hexDecodingTable[* postion++];
		
		if ((index & 0x01) == 0)
		{
			result[index] = value << 4;
		} else {
			result[index++] |= value;
		}
		
	}
	
	NSData * data = [[NSData alloc] initWithBytes:result length:index];
	free(result);
	
	return data;
}

+ (NSData *)dataWithUtf8String:(NSString *)utf8String
{
	return [utf8String dataUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark Public methods

- (NSString *)base64string
{
	const unsigned char * rawData = self.bytes;
	
	int length = self.length;
	if (length == 0)
	{
		return nil;
	}
	
	char * result = (char *)calloc(((length + 2) / 3) * 4, sizeof(char));
	char * position = result;
	
	while (length > 2)
	{
		* position++ = __base64EncodingTable[rawData[0] >> 2];
		* position++ = __base64EncodingTable[((rawData[0] & 0x03) << 4) + (rawData[1] >> 4)];
		* position++ = __base64EncodingTable[((rawData[1] & 0x0f) << 2) + (rawData[2] >> 6)];
		* position++ = __base64EncodingTable[rawData[2] & 0x3f];
		
		rawData += 3;
		length -= 3;
	}
	
	if (length != 0)
	{
		* position++ = __base64EncodingTable[rawData[0] >> 2];
		if (length > 1)
		{
			* position++ = __base64EncodingTable[((rawData[0] & 0x03) << 4) + (rawData[1] >> 4)];
			* position++ = __base64EncodingTable[(rawData[1] & 0x0f) << 2];
			* position++ = '=';
		}
		else
		{
			* position++ = __base64EncodingTable[(rawData[0] & 0x03) << 4];
			* position++ = '=';
			* position++ = '=';
		}
	}
	
	* position = '\0';
	
	NSString * base64string = [NSString stringWithCString:result encoding:NSASCIIStringEncoding];
	free(result);
	
	return base64string;
}

- (NSString *)hexString
{
	const unsigned char * rawData = [self bytes];
	
	int length = [self length];
	if (length == 0) {
		return nil;
	}
	
	char * result = (char*)calloc(length * 2 + 1, sizeof(char));
	char * position = result;
	
	int index = 0;
	while (index < length)
	{
		* position++ = __hexEncodingTable[rawData[index] >> 4];
		* position++ = __hexEncodingTable[rawData[index] & 0x0F];
		index++;
	}
	
	* position = '\0';
	
	NSString * hexString = [NSString stringWithCString:result encoding:NSASCIIStringEncoding];
	free(result);
	
	return hexString;
}

- (NSString *)utf8String
{
	return [NSString.alloc initWithData:self encoding:NSUTF8StringEncoding];
}

@end
