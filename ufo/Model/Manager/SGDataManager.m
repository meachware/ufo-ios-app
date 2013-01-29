//
//  SGDataManger.m
//  ufo
//
//  Created by SandGro on 29-01-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import "SGDataManager.h"
#import "SGBaseArticle.h"
#import "NSDictionary+Json.h"

@interface SGDataManager ()
- (NSURL *)applicationDocumentsDirectory;
@end

#pragma mark -

@implementation SGDataManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

#pragma mark Singleton pattern

+ (SGDataManager *)shared
{
	static SGDataManager * shared;
	
	static dispatch_once_t done;
	dispatch_once(&done, ^{
		shared = SGDataManager.alloc.init;
	});
	
	return shared;
}

#pragma mark Initializer

- (id)init
{
	self = [super init];
	if (self)
	{
		
	}
	return self;
}

#pragma mark Public Methods

- (void)saveContext
{
    NSError * error = nil;
    NSManagedObjectContext * managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
	{
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
		{
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void)saveArticleFromJson:(NSDictionary *)json
{
	NSManagedObjectContext * context = [self managedObjectContext];
	SGBaseArticle * article = [NSEntityDescription insertNewObjectForEntityForName:@"SGBaseArticle" inManagedObjectContext:context];
	article.identifier = [NSNumber numberWithInt:[json integerForTestedKey:@"id"]];
	article.title = [json stringForKey:@"title"];
	article.text = [json stringForKey:@"text"];
	article.publishDate = [json dateForTestedKey:@"publish_date"];
	
	NSError * error;
	if (![context save:&error])
	{
		NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
	}
}

- (NSArray *)allArticles
{
	NSManagedObjectContext * context = [self managedObjectContext];
	
	NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription * entity = [NSEntityDescription entityForName:@"SGBaseArticle" inManagedObjectContext:context];
	[fetchRequest setEntity:entity];
	
	NSError * error;
	NSArray * fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
	
	return fetchedObjects;
}

- (void)deleteAllArticles
{
	for (NSManagedObject * mo in [self allArticles])
	{
		[self.managedObjectContext deleteObject:mo];
		[self saveContext];
	}
}

#pragma mark - Core Data stack

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil)
	{
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator * coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
	{
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil)
	{
        return _managedObjectModel;
    }
	
    NSURL * modelURL = [[NSBundle mainBundle] URLForResource:@"ufo" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil)
	{
        return _persistentStoreCoordinator;
    }
    
    NSURL * storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ufo.sqlite"];
    
    NSError * error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
	{
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
