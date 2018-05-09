//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SCOGroup.h"
#import "AWNavigationMenuItem.h"
#import "SendViewController.h"
#import "SCOGroupsHelper.h"
#import "SCAppDelPrefs.h"
#import "SCHeader.h"

//@class AWNavigationMenuItem, NSArray, NSString, SendViewController;

@interface SCOGroupsHelper : NSObject <AWNavigationMenuItemDataSource, AWNavigationMenuItemDelegate>
//{
//    AWNavigationMenuItem *_menuItem;
//    NSArray *_groups;
//    SendViewController *_sendController;
//}

+ (void)addOrUpdateGroup:(SCOGroup *)arg1;
+ (void)deleteGroup:(SCOGroup *)arg1;
+ (id)allSortedGroups;
+ (SCOGroupsHelper *)sharedInstance;
@property(nonatomic) __weak SendViewController *sendController; // @synthesize sendController=_sendController;
@property(retain, nonatomic) NSArray *groups; // @synthesize groups=_groups;
@property(retain, nonatomic) AWNavigationMenuItem *menuItem; // @synthesize menuItem=_menuItem;
- (void)navigationMenuItemWillFold:(AWNavigationMenuItem *)arg1;
- (void)navigationMenuItemWillUnfold:(AWNavigationMenuItem *)arg1;
- (void)navigationMenuItem:(AWNavigationMenuItem *)arg1 selectionDidChange:(NSUInteger)arg2;
- (CGRect)maskViewFrameInNavigationMenuItem:(AWNavigationMenuItem *)arg1;
- (NSAttributedString *)navigationMenuItem:(AWNavigationMenuItem *)arg1 attributedMenuTitleAtIndex:(NSUInteger)arg2;
- (NSString *)navigationMenuItem:(AWNavigationMenuItem *)arg1 menuTitleAtIndex:(NSUInteger)arg2;
- (NSUInteger *)numberOfRowsInNavigationMenuItem:(AWNavigationMenuItem *)arg1;
- (id)selectedIndexes;
- (id)viewToDisplayMenuOn;
- (void)addButtonToSendVieWController:(SendViewController *)arg1;
- (void)reloadMenu;

// Remaining properties
//@property(readonly, copy) NSString *debugDescription;
//@property(readonly, copy) NSString *description;
//@property(readonly) unsigned long long hash;
//@property(readonly) Class superclass;

@end
