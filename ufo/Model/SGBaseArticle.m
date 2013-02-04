//
//  SGBaseArticle.m
//  ufo
//
//  Created by SandGro on 29-01-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import "SGBaseArticle.h"


@implementation SGBaseArticle

@dynamic title;
@dynamic publishDate;
@dynamic text;
@dynamic identifier;

- (BOOL)validateForInsert:(NSError *__autoreleasing *)error
{
	[super validateForInsert:error];
	
	NSFetchRequest * fetch = [[NSFetchRequest alloc] init];
	[fetch setEntity:[NSEntityDescription entityForName:[self.entity name] inManagedObjectContext:self.managedObjectContext]];
	
	NSPredicate * predicate = [NSPredicate predicateWithFormat:@"identifier = %@",self.identifier];
	fetch.predicate = predicate;
	
	NSUInteger count = [self.managedObjectContext countForFetchRequest:fetch error:error];
	
	return (count == 0);
}

@end
