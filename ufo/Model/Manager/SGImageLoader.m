//
//  SGImageLoader.m
//  ufo
//
//  Created by SandGro on 04-02-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import "SGImageLoader.h"
#import "SGImageRequest.h"
#import "SGImage.h"
#import "SGImageData.h"
#import "SGDataManager.h"
#import "SGRequestManager.h"
#import "SGImageCache.h"

@implementation SGImageLoader

#pragma mark Properties

@synthesize imageData = _imageData;
@synthesize waiting = _waiting;
@synthesize loading = _loading;
@synthesize loaded = _loaded;
@synthesize failed = _failed;

#pragma mark Initializer

- (id)initWithImageData:(SGImageData *)imageData
{
	self = [super init];
	if (self)
	{
		_imageData = imageData;
	}
	return self;
}

#pragma mark Public methods

- (void)start
{
	UIImage * cachedImage = [SGImageCache.shared imageFromCacheForImageData:_imageData];
	if (cachedImage)
	{
		_loaded(_imageData, cachedImage, YES);
	}
	else
	{
		[self requestImage];
	}
}

#pragma mark Private methods

- (void)requestImage
{
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
	dispatch_async(queue, ^{
		
		if (_loading)
		{
			_loading(_imageData);
		}
	
		SGImageRequest * imageRequest = [SGImageRequest.alloc initWithImageUrl:_imageData.path];
		imageRequest.imageRequestFinished = ^(SGImageRequest * request, UIImage * image){
			
			[self persistImage:image];
			
		};
		
		imageRequest.requestFailed = ^(SGAbstractRequest * request, NSHTTPURLResponse * httpResponse, NSError * error) {
			
			NSLog(@"Image request %@ failed (%@).", request.URL, error.localizedDescription);
		};
		
		[SGRequestManager.shared loadRequestInImageQueue:imageRequest prioritized:NO];
	});
}

- (void)persistImage:(UIImage *)image
{
	NSData * png = UIImagePNGRepresentation(image);
	NSURL * fileLocation = [[SGImageCache.shared imageCacheDirectoryForImageData:_imageData] URLByAppendingPathExtension:@"png"];
	
	if([png writeToURL:fileLocation atomically:NO])
	{
		NSManagedObjectContext * context = SGDataManager.shared.managedObjectContext;
		
		SGImage * cachedImage = [NSEntityDescription insertNewObjectForEntityForName:@"SGImage" inManagedObjectContext:context];
		cachedImage.location = fileLocation.absoluteString;
		cachedImage.imageId = _imageData.cacheKey;
		cachedImage.lastUsed = NSDate.date;
		
		NSError * error;
		if (![context save:&error])
		{
			NSLog(@"Whoops, couldn't save image: %@", [error localizedDescription]);
		}
		else
		{
			if (_loaded)
			{
				_loaded(_imageData, image, NO);
			}
		}
	}
}



@end
