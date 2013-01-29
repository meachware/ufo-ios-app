//
//  SGDataManger.h
//  ufo
//
//  Created by SandGro on 29-01-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SGBaseArticle;

@interface SGDataManager : NSObject
{
@private
	NSManagedObjectContext * _managedObjectContext;
	NSManagedObjectModel * _managedObjectModel;
	NSPersistentStoreCoordinator * _persistentStoreCoordinator;
}

@property (readonly, strong, nonatomic) NSManagedObjectContext * managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel * managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator * persistentStoreCoordinator;

#pragma mark Singleton pattern
+ (SGDataManager *)shared;

#pragma mark Public Methods

- (void)saveContext;
- (void)saveArticleFromJson:(NSDictionary *)json;

@end
