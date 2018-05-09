//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "SCAppDelLocationPickerResults.h"
#import "SCAppDelLocationPicker.h"

@implementation SCAppDelLocationPickerResults


- (UITableViewCell *)tableView:(UITableView *)arg1 cellForRowAtIndexPath:(NSIndexPath *)arg2 {
	static NSString *identifier = @"SCAppDelLocationCell";
    UITableViewCell *cell = [arg1 dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [SCAppDelLocationPicker applyInitialCellConfigurations:cell];
    }
	SCAppDelLocation *location = [[self resultLocations] objectAtIndex:[arg2 row]];
	[SCAppDelLocationPicker configureCell:cell withLocation:location];
    return cell;

}

- (long long)tableView:(UITableView *)arg1 numberOfRowsInSection:(long long)arg2 {
	return [[self resultLocations] count];
}

@end

