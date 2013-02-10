//
//  SGImageGallery.h
//  ufo
//
//  Created by SandGro on 10-02-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SGBaseArticle, SGImage;

@interface SGImageGallery : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *images;
@property (nonatomic, retain) SGBaseArticle *article;
@end

@interface SGImageGallery (CoreDataGeneratedAccessors)

- (void)addImagesObject:(SGImage *)value;
- (void)removeImagesObject:(SGImage *)value;
- (void)addImages:(NSSet *)values;
- (void)removeImages:(NSSet *)values;

@end
