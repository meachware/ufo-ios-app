//
//  SGImage.h
//  ufo
//
//  Created by SandGro on 05-02-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SGImage : NSManagedObject

@property (nonatomic, retain) NSString * cacheKey;
@property (nonatomic, retain) NSDate * lastUsed;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * type;

@end
