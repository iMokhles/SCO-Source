//
//  KGWLocationPickerViewController.h
//  KGWLocationPicker
//
//  Created by koogawa on 2016/04/23.
//  Copyright © 2016 koogawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

typedef void (^KGWLocationPickerSuccessReturnBlock)(CLLocationCoordinate2D coordinate);
typedef void (^KGWLocationPickerFauilreBlock)(NSError* error);

@interface KGWLocationPickerViewController : UIViewController

- (id)initWithSucess:(KGWLocationPickerSuccessReturnBlock)sucess onFailure:(KGWLocationPickerFauilreBlock)failure;

@end
