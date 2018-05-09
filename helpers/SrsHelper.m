#import "SrsHelper.h"


// S       rsHe

@implementation SrsHelper

+ (SrsHelper *)sharedInstance {
    static SrsHelper *__sharedInstance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[self alloc] init];
    });
    
    return __sharedInstance;
}
+ (NSString *)filtersDirectoryPath {
	NSString * docsDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
	NSString *srsPath = [docsDir stringByAppendingPathComponent:@"Srs"];

	BOOL isDirectory = NO;
    if (![[NSFileManager defaultManager] fileExistsAtPath:srsPath isDirectory:&isDirectory])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:srsPath withIntermediateDirectories:YES attributes:nil error:nil];        
    }
    return srsPath;
}

+ (NSString *)scoffiltersDirectoryPath {
	NSString * docsDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
	NSString *srsPath = [docsDir stringByAppendingPathComponent:@"scof"];
	BOOL isDirectory = NO;
    if (![[NSFileManager defaultManager] fileExistsAtPath:srsPath isDirectory:&isDirectory])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:srsPath withIntermediateDirectories:YES attributes:nil error:nil];        
    }
    return srsPath;
}

+ (void)fetchFiltersWithCompletion:(void (^)(NSArray *filters))completion {

	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		NSString *filtersDirectoryPath = [[self class] filtersDirectoryPath];
		NSArray *contentsOfDir = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:filtersDirectoryPath error:nil];
		if (contentsOfDir) {

			NSMutableArray *filtersArray = [NSMutableArray new];
			for(NSString *file in contentsOfDir) {
				NSString *fileExt = [file pathExtension];
				if ([fileExt isEqualToString:@"png"]) {
					NSString *fileFullPath = [filtersDirectoryPath stringByAppendingPathComponent:file];
					NSDictionary* attr = [[NSFileManager defaultManager] attributesOfItemAtPath:fileFullPath error:nil];
					if(attr) {
						NSDate *fileDate = (NSDate*)[attr objectForKey:NSFileModificationDate]; 
						NSString *fileKey = [[fileFullPath lastPathComponent] stringByDeletingPathExtension];
						Sr *filterFile = [[Sr alloc] init];
						[filterFile setKey:fileKey];
						[filterFile setPath:fileFullPath];
						[filterFile setLastModDate:fileDate];
						[filtersArray addObject:filterFile];

					}
				}
			}

			NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"lastModDate" ascending:NO]];
	    	NSArray *filtersArraySorted = [filtersArray sortedArrayUsingDescriptors:sortDescriptors];
	    	dispatch_async(dispatch_get_main_queue(), ^{
				
				completion(filtersArraySorted);

			});
	    	
		}
	});

	
}
+ (void)fetchEnabledFiltersWithCompletion:(void (^)(NSArray *filters))completion {
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		
		NSMutableArray *newArray = [NSMutableArray new];
		if ([[[self class] enabledFiltersKeys] count]) {
			for(NSString *key in [[self class] enabledFiltersKeys]) {
				Sr *filter = [[self class] filterForKey:key];
				[newArray addObject:filter];
			}

			dispatch_async(dispatch_get_main_queue(), ^{
				completion(newArray);
			});
		}		
	});
}
+ (long long)enabledFiltersCount {
	return [[[self class] enabledFiltersKeys] count];
}
+ (id)enabledFiltersKeys {
	NSArray *enabledFilters = [[[SCAppDelPrefs sharedInstance] userDefaults] arrayForKey:@"SCOEnabledFilters"];
	if (enabledFilters) {
		return enabledFilters;
	}
	return @[];
}
+ (void)saveEnabledFiltersKeys:(NSArray *)arg1 {

	[[[SCAppDelPrefs sharedInstance] userDefaults] setObject:arg1 forKey:@"SCOEnabledFilters"];
	[[[SCAppDelPrefs sharedInstance] userDefaults] synchronize];
}
+ (Sr *)filterForKey:(NSString *)arg1 {
	NSString *filtersDirectoryPath = [[self class] filtersDirectoryPath];
	NSString *filterPath = [[filtersDirectoryPath stringByAppendingPathComponent:arg1] stringByAppendingPathExtension:@"png"];

	if ([[NSFileManager defaultManager] fileExistsAtPath:filterPath]) {

		Sr *filterFile = [[Sr alloc] init];
		[filterFile setKey:arg1];
		[filterFile setPath:filterPath];

		NSDictionary* attr = [[NSFileManager defaultManager] attributesOfItemAtPath:[filterFile key] error:nil];
		NSDate *fileDate = (NSDate*)[attr objectForKey:NSFileModificationDate];
		[filterFile setLastModDate:fileDate];

		return filterFile;
    }
    return nil;
}
+ (_Bool)deleteFilter:(Sr *)arg1 {

	return [[NSFileManager defaultManager] removeItemAtPath:[arg1 path] error:nil];
}
+ (Sr *)createAndSaveFilterForImage:(UIImage *)arg1 {

	Sr *filterFile = [[Sr alloc] init];
	[filterFile setKey:[[NSUUID UUID] UUIDString]];

	NSString *filtersDirectoryPath = [[self class] filtersDirectoryPath];
	NSString *filterPath = [[filtersDirectoryPath stringByAppendingPathComponent:[filterFile key]] stringByAppendingPathExtension:@"png"];

	[filterFile setPath:fileFullPath];
	[filterFile setLastModDate:[NSDate date]];

	NSData *imageData = UIImagePNGRepresentation(arg1);
	if ([imageData writeToFile:[filterFile path] atomically:YES]) {
		return filterFile;
	}
	return nil;
}
+ (NSMutableArray *)filtersByAddingEnabledFiltersToSnapchatFilters:(NSArray *)arg1 {

	NSArray *array1 = nil;
	if (arg1) {
		array1 = arg1;
	} else {
		array1 = @[];
	}
	NSMutableArray *newArray = [NSMutableArray arrayWithArray:array1];
	NSArray *enabledSnapFitlers [[SrsHelper sharedInstance] enabledFiltersForSnapchat];

	[newArray addObjectsFromArray:enabledSnapFitlers];

	return newArray;
}

+ (NSMutableDictionary *)filtersByAddingEnabledFiltersToSnapchatDictionaryFilters:(NSDictionary *)arg1 {

	NSDictionary *dict1 = nil;
	if (arg1) {
		dict1 = arg1;
	} else {
		dict1 = @[];
	}
	NSMutableDictionary *newDict = [NSMutableDictionary dictionaryWithDictionary:array1];
	NSDictionary *enabledSnapFitlers [[SrsHelper sharedInstance] enabledFiltersDictionaryForSnapchat];

	[newDict addEntriesFromDictionary:enabledSnapFitlers];
	return newDict;
}

- (void)updateEnabledFiltersForSnapchatWithCompletion:(void (^)(NSArray *filters, NSDictionary *filtersDict))completion {

	NSMutableArray *newArray = [NSMutableArray new];
	NSMutableDictionary *newDict = [NSMutableDictionary new];

	[[self class] fetchEnabledFiltersWithCompletion:^(NSArray *filters) {

		dispatch_async(dispatch_get_global_queue(0, 0), ^{

			if ([filters count]) {
				for(Sr *filter in filters) {
					NSDictionary *filterDict = [filter snapchatFilterDictionary];

					SCStaticImageGeoFilter *imageGeoFilter = [[SCStaticImageGeoFilter alloc] initWithDictionary:filterDict isPreCached:nil];
					[newArray addObject:imageGeoFilter];
					[newDict setObject:imageGeoFilter forKey:[filter key]];
				}
				dispatch_async(dispatch_get_main_queue(), ^{

					[self setEnabledFiltersForSnapchat:newArray];
					[self setEnabledFiltersDictionaryForSnapchat:newDict];

					completion(newArray, newDict);
				});
			}
		});

	}];
}
@end










