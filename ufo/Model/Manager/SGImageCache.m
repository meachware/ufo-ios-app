//
//  SGImageCache.m
//  ufo
//
//  Created by SandGro on 04-02-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import "SGImageCache.h"
#import "SGImageData.h"
#import "SGDataManager.h"
#import "SGImage.h"

@implementation SGImageCache

#pragma mark Properties
@synthesize cachedImages = _cachedImages;
@synthesize imageCacheDirectory = _imageCacheDirectory;

+ (SGImageCache *)shared
{
	static SGImageCache * shared;
	
	static dispatch_once_t done;
	dispatch_once(&done, ^{
		shared = SGImageCache.alloc.init;
	});
	
	return shared;
}

#pragma mark Initializer

- (id)init
{
	self = [super init];
	if (self)
	{
		[self createImageCache];
	}
	return self;
}

#pragma mark Public methods

- (NSURL *)imageCacheDirectoryForImageData:(SGImageData *)imageData
{
	return [_imageCacheDirectory URLByAppendingPathComponent:imageData.cacheKey isDirectory:NO];
}

- (UIImage *)imageFromCacheForImageData:(SGImageData *)imageData
{
	UIImage * cachedImage = nil;
	
	NSString * cacheLocation = [_cachedImages objectForKey:imageData.cacheKey];
	if (cacheLocation)
	{
		NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:cacheLocation]];
		cachedImage = [UIImage imageWithData:imageData];
	}
	
	return cachedImage;
}

#pragma mark Private Methods

- (void)createImageCache
{
	NSURL * imageCacheDir = [[self applicationCacheDirectory] URLByAppendingPathComponent:@"images"];
	if(! [NSFileManager.defaultManager fileExistsAtPath:imageCacheDir.absoluteString isDirectory:YES])
	{
		[NSFileManager.defaultManager createDirectoryAtURL:imageCacheDir withIntermediateDirectories:NO attributes:nil error:nil];
	}
	
	_imageCacheDirectory = imageCacheDir;
	
	NSManagedObjectContext * moc = SGDataManager.shared.managedObjectContext;
	NSEntityDescription * entityDescription = [NSEntityDescription entityForName:@"SGImage" inManagedObjectContext:moc];
	NSFetchRequest * request = [[NSFetchRequest alloc] init];
	[request setEntity:entityDescription];
	
	NSError * error;
	NSArray * images = [moc executeFetchRequest:request error:&error];
	
	if (!images || error)
	{
		NSLog(@"No cached images or error fetching them");
	}
	
	_cachedImages = NSMutableDictionary.alloc.init;
	for (SGImage * image in images)
	{
		//TODO: Load image in memory or not
		if (image.cacheKey)
		{
			[_cachedImages setObject:image.location forKey:image.cacheKey];
		}
	}
}

- (NSURL *)applicationCacheDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
