//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface SCOGroupsViewController : UITableViewController
{
    NSMutableArray *_groups;
}

+ (id)createInstance;
@property(retain, nonatomic) NSMutableArray *groups;
- (_Bool)shouldAutorotateToInterfaceOrientation:(long long)arg1;
- (void)viewDidLayoutSubviews;
- (void)tableView:(id)arg1 willDisplayCell:(id)arg2 forRowAtIndexPath:(id)arg3;
- (void)tableView:(id)arg1 commitEditingStyle:(long long)arg2 forRowAtIndexPath:(id)arg3;
- (_Bool)tableView:(id)arg1 canEditRowAtIndexPath:(id)arg2;
- (void)tableView:(id)arg1 didSelectRowAtIndexPath:(id)arg2;
- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2;
- (long long)tableView:(id)arg1 numberOfRowsInSection:(long long)arg2;
- (long long)numberOfSectionsInTableView:(id)arg1;
- (void)addButtonPressed;
- (void)showEditControllerWithGroup:(id)arg1;
- (void)dismissButtonPressed;
- (void)viewWillAppear:(_Bool)arg1;
- (void)viewDidLoad;

@end