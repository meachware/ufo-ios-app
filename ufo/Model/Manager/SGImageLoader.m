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

@implementation SGImageLoader

@synthesize imageData = _imageData;

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
	[self requestImage];
}

#pragma mark Private methods

- (void)requestImage
{
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
	dispatch_async(queue, ^{
	
		SGImageRequest * imageRequest = [SGImageRequest.alloc initWithImageUrl:_imageData.path];
		imageRequest.imageRequestFinished = ^(SGImageRequest * request, UIImage * image){
			
			[self persistImage:image];
			
		};
		
		imageRequest.requestFailed = ^(SGAbstractRequest * request, NSHTTPURLResponse * httpResponse, NSError * error) {
			
			NSLog(@"Image request %@ failed (%@).", request.URL, error.localizedDescription);
		};
		
	});
}

- (void)persistImage:(UIImage *)image
{
	NSData * png = UIImagePNGRepresentation(image);
	NSURL * fileLocation = [[self applicationCacheDirectory] URLByAppendingPathComponent:_imageData.cacheKey];
	
	if([png writeToURL:fileLocation atomically:NO])
	{
		NSManagedObjectContext * context = SGDataManager.shared.managedObjectContext;
		
		SGImage * cachedImage = [NSEntityDescription insertNewObjectForEntityForName:@"SGImage" inManagedObjectContext:context];
		cachedImage.location = fileLocation.absoluteString;
		cachedImage.lastUsed = NSDate.date;
		
		NSError * error;
		if (![context save:&error])
		{
			NSLog(@"Whoops, couldn't save image: %@", [error localizedDescription]);
		}
	}
}

- (NSURL *)applicationCacheDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
