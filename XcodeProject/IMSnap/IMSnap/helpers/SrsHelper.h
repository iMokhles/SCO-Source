#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Sr.h"
#import "SCAppDelPrefs.h";

@interface SrsHelper : NSObject

+ (NSMutableDictionary *)filtersByAddingEnabledFiltersToSnapchatDictionaryFilters:(NSDictionary *)arg1;
+ (NSMutableArray *)filtersByAddingEnabledFiltersToSnapchatFilters:(NSArray *)arg1;
+ (Sr *)createAndSaveFilterForImage:(UIImage *)arg1;
+ (_Bool)deleteFilter:(Sr *)arg1;
+ (Sr *)filterForKey:(NSString *)arg1;
+ (void)saveEnabledFiltersKeys:(id)arg1;
+ (id)enabledFiltersKeys;
+ (long long)enabledFiltersCount;
+ (void)fetchEnabledFiltersWithCompletion:(void (^)(NSArray *filters))completion;
+ (void)fetchFiltersWithCompletion:(void (^)(NSArray *filters))completion;
+ (id)scoffiltersDirectoryPath;
+ (id)filtersDirectoryPath;
+ (id)sharedInstance;
@property(retain, nonatomic) NSDictionary *enabledImagesFiltersDictionaryForSnapchat; // @synthesize enabledImagesFiltersDictionaryForSnapchat=_enabledImagesFiltersDictionaryForSnapchat;
@property(retain, nonatomic) NSArray *enabledImagesFiltersForSnapchat; // @synthesize enabledImagesFiltersForSnapchat=_enabledImagesFiltersForSnapchat;
@property(retain, nonatomic) NSDictionary *enabledFiltersDictionaryForSnapchat; // @synthesize enabledFiltersDictionaryForSnapchat=_enabledFiltersDictionaryForSnapchat;
@property(retain, nonatomic) NSArray *enabledFiltersForSnapchat; // @synthesize enabledFiltersForSnapchat=_enabledFiltersForSnapchat;

- (void)updateEnabledFiltersForSnapchatWithCompletion:(void (^)(NSArray *filters, NSDictionary *filtersDict))arg1;

@end
