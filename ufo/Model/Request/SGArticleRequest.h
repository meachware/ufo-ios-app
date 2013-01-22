//
//  SGArticleRequest.h
//  ufo
//
//  Created by SandGro on 21-01-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import "SGAbstractRequest.h"

@class SGArticleRequest;

typedef BOOL (^SGJsonRequestFinished)(SGArticleRequest * request, id json);

@interface SGArticleRequest : SGAbstractRequest
{
@private
	SGJsonRequestFinished _jsonRequestFinished;
}

#pragma mark Properties
@property (nonatomic, copy) SGJsonRequestFinished jsonRequestFinished;

#pragma mark Public Methods
- (SGArticleRequest *)initNewsArticles;

@end
