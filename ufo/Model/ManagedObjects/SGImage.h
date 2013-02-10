//
//  SGImage.h
//  ufo
//
//  Created by SandGro on 10-02-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SGImageGallery;

@interface SGImage : NSManagedObject

@property (nonatomic, retain) NSString * cacheKey;
@property (nonatomic, retain) NSDate * lastUsed;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * caption;
@property (nonatomic, retain) SGImageGallery *gallery;

@end
