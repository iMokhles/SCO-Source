#import "Sr.h"

@implementation Sr
- (NSData *)imageData {

	return UIImagePNGRepresentation([self image])
}
- (UIImage *)image {

	return [UIImage imageWithContentsOfFile:[self path]];
}
- (NSDictionary *)snapchatFilterDictionary {

	NSString *selfKey = [self key];
	NSString *selfPath = [self path];
	NSString selfImage = [self image];

	NSURL *pathUrl = [NSURL fileURLWithPath:selfPath];
	NSString *urlPathAbs = [pathUrl absoluteString];

	NSDictionary *scDict = [NSDictionary dictionaryWithObjects:@[
		selfKey,
		urlPathAbs,
		[NSNumber numberWithInt:0],
		[NSNumber numberWithInt:0],
		[NSNumber numberWithInt:0],
		[NSNumber numberWithInt:0],
		[NSNumber numberWithInt:0],
		@[@"scale_aspect_fit", @"bottom"],
		[NSNumber numberWithInt:2],
		@"BOTTOM_RIGHT"
		] forKeys:@[
		@"filter_id",
		@"image",
		@"hide_sponsored_slug", 
		@"is_dynamic_geofilter",
		@"is_featured",
		@"is_lens",
		@"is_sponsored",
		@"position",
		@"priority",
		@"sponsored_slug_position"

	]];

	return scDict;
}
@end
