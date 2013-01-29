//
//  SGBaseArticle.h
//  ufo
//
//  Created by SandGro on 29-01-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SGBaseArticle : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * publishDate;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSNumber * identifier;

@end
