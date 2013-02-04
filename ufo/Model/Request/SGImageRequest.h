//
//  SGImageRequest.h
//  ufo
//
//  Created by SandGro on 04-02-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import "SGAbstractRequest.h"

@class SGImageRequest;

typedef void (^SGImageRequestFinished)(SGImageRequest * request, UIImage * imagae);

@interface SGImageRequest : SGAbstractRequest
{
@private
	SGImageRequestFinished _imageRequestFinished;
}

#pragma mark Properties
@property (nonatomic, copy) SGImageRequestFinished imageRequestFinished;

#pragma mark Initializer
- (id)initWithImageUrl:(NSString *)imageUrl;

@end
