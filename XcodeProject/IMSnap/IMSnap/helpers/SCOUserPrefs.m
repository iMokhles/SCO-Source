//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "SCOUserPrefs.h"

@implementation SCOUserPrefs

+ (SCOUserPrefs *)standardDefaults {
	static SCOUserPrefs *__sharedInstance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
    	NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    	NSString *documentsURLPath = [documentsURL path];
    	NSString *plistId = @"tv.appDel.scappDel";
    	NSString *plistFile = [NSString stringWithFormat:@"Preferences/%@.plist", plistId];
    	NSString *plistFilePath = [documentsURLPath stringByAppendingPathComponent:plistFile];

        __sharedInstance = [[self alloc] initWithPlistPath:plistFilePath];
    });
    
    return __sharedInstance;
}

- (id)initWithPlistPath:(NSString *)arg1 {

	self = [super init];
	if (self) {
		[self setPlistPath:arg1];
		NSMutableDictionary *prefsMutableDict = [NSMutableDictionary dictionaryWithContentsOfFile:[self plistPath]];
//        BOOL boolVar = NO;
		NSMutableDictionary *prefsDict = nil;
		if (prefsMutableDict != nil) {
			prefsDict = prefsMutableDict;
		} else {
			NSMutableDictionary *newDict = [NSMutableDictionary new];
			prefsDict = newDict;
		}

		[self setDictionary:prefsDict];

		NSMutableDictionary *newDefaultDict = [NSMutableDictionary new];
        [self setDefaultsDictionary:newDefaultDict];

	}

	return self;
}

- (void)registerDefaults:(NSDictionary *)arg1 {
	if (arg1) {
		[[self defaultsDictionary] addEntriesFromDictionary:arg1];
	}
}

- (id)objectForKey:(id)arg1 {
	NSMutableDictionary *prefsDict = [self dictionary];
	id value = [prefsDict objectForKey:arg1];
	if (value) {
		return value;
	}
	NSMutableDictionary *prefsDefaultDict = [self defaultsDictionary];
	id value2 = [prefsDefaultDict objectForKey:arg1];
	if (value2) {
		return value2;
	}
	return nil;
}
- (_Bool)boolForKey:(id)arg1 {
	return [[self objectForKey:arg1] boolValue];
}
- (long long)integerForKey:(id)arg1 {
	return [[self objectForKey:arg1] integerValue];
}
- (float)floatForKey:(id)arg1 {
	return [[self objectForKey:arg1] floatValue];
}
- (NSDate *)dateForKey:(id)arg1 {
	id value = [self objectForKey:arg1];
	if ([value isKindOfClass:[NSDate class]]) {
		return value;
	}
	return nil;
}
- (NSData *)dataForKey:(id)arg1 {
	id value = [self objectForKey:arg1];
	if ([value isKindOfClass:[NSData class]]) {
		return value;
	}
	return nil;
}
- (NSDictionary *)dictionaryForKey:(id)arg1 {
	id value = [self objectForKey:arg1];
	if ([value isKindOfClass:[NSDictionary class]]) {
		return value;
	}
	return nil;
}
- (NSArray *)arrayForKey:(id)arg1 {
	id value = [self objectForKey:arg1];
	if ([value isKindOfClass:[NSArray class]]) {
		return value;
	}
	return nil;
}
- (NSString *)stringForKey:(id)arg1 {
	id value = [self objectForKey:arg1];
	if ([value isKindOfClass:[NSString class]]) {
		return value;
	}
	return nil;
}
- (double)doubleForKey:(id)arg1 {
	return [[self objectForKey:arg1] doubleValue];
}
- (void)setDate:(id)arg1 forKey:(id)arg2 {
	[[self dictionary] setObject:arg1 forKey:arg2];
}
- (void)setData:(id)arg1 forKey:(id)arg2 {
	[[self dictionary] setObject:arg1 forKey:arg2];
}
- (void)setDictionary:(id)arg1 forKey:(id)arg2 {
	[[self dictionary] setObject:arg1 forKey:arg2];
}
- (void)setArray:(id)arg1 forKey:(id)arg2 {
	[[self dictionary] setObject:arg1 forKey:arg2];
}
- (void)setString:(id)arg1 forKey:(id)arg2 {
	[[self dictionary] setObject:arg1 forKey:arg2];
}
- (void)setDouble:(double)arg1 forKey:(id)arg2 {
	[[self dictionary] setObject:[NSNumber numberWithDouble:arg1] forKey:arg2];
}
- (void)setFloat:(float)arg1 forKey:(id)arg2 {
	[[self dictionary] setObject:[NSNumber numberWithFloat:arg1] forKey:arg2];
}
- (void)setInteger:(long long)arg1 forKey:(id)arg2 {
	[[self dictionary] setObject:[NSNumber numberWithInteger:arg1] forKey:arg2];
}
- (void)setBool:(_Bool)arg1 forKey:(id)arg2 {
	[[self dictionary] setObject:[NSNumber numberWithBool:arg1] forKey:arg2];
}
- (void)setObject:(id)arg1 forKey:(id)arg2 {
	if (arg2) {
		if (arg1) {
			[[self dictionary] setObject:arg1 forKey:arg2];
		} else {
			id value = [[self dictionary] objectForKey:arg2];
			if (value) {
				[[self dictionary] removeObjectForKey:arg2];
			}
		}
	}
}
- (_Bool)empty {
	NSMutableDictionary *prefsDict = [self dictionary];
	if (prefsDict) {
		if ([[self dictionary] count] == 0) {
			return YES;
		}
		return NO;
	}
	return YES;
}
- (_Bool)synchronize {
	NSMutableDictionary *prefsDict = [self dictionary];
	BOOL isSaved = NO;
	if (prefsDict) {
		if ([[self dictionary] writeToFile:[self plistPath] atomically:YES]) {
			isSaved = YES;
		}
	}

	return isSaved;
}
- (void)removeObjectForKey:(id)arg1 {
	[[self dictionary] setObject:@(0) forKey:arg1];
}


@end

