//
//  SGBaseArticle.h
//  ufo
//
//  Created by SandGro on 10-02-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SGImageGallery;

@interface SGBaseArticle : NSManagedObject

@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSDate * publishDate;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * thumbUrl;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) SGImageGallery *imageGallery;

@end
