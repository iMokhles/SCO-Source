//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "SCOGroupsViewController.h"
#import "SCAppDelPrefs.h"
#import "SCOGroup.h"
#import "SCOEditGroupViewController.h"
#import "SCOGroupsHelper.h"

@implementation SCOGroupsViewController
+ (SCOGroupsViewController *)createInstance {
  SCOGroupsViewController *groupsVC = [[SCOGroupsViewController alloc] initWithStyle:0];
  [groupsVC setGroups:[SCOGroupsHelper allSortedGroups]];
  return groupsVC;
}

- (void)viewDidLoad {
	[super viewDidLoad];

  [self setTitle:[[SCAppDelPrefs sharedInstance] localizedStringForKey:@"GROUPS"]];

  [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:4 target:self action:@selector(addButtonPressed)]];
  [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:0 target:self action:@selector(dismissButtonPressed)]];
  [self.tableView setSeparatorColor:[UIColor redColor]];

}
- (void)viewWillAppear:(_Bool)arg1 {
  [super viewWillAppear:arg1];

  [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
  [self.navigationController.navigationBar setTintColor:[UIColor greenColor]];
  [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];

}
- (void)dismissButtonPressed {
  [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)showEditControllerWithGroup:(SCOGroup *)arg1 {
  SCOEditGroupViewController *editGroupVC = [[SCOEditGroupViewController alloc] initWithGroup:arg1 saveBlock:^(SCOGroup *group){
    [SCOGroupsHelper addOrUpdateGroup:group];
    [self setGroups:[SCOGroupsHelper allSortedGroups]];
    [self.tableView reloadData];
  }];
  [self.navigationController pushViewController:editGroupVC animated:YES];
}
- (void)addButtonPressed {
  [self showEditControllerWithGroup:nil];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [[self groups] count];
}
- (UITableViewCell *)tableView:(UITableView *)arg1 cellForRowAtIndexPath:(NSIndexPath *)arg2 {
  static NSString *identifier = @"cell";
  UITableViewCell *cell = [arg1 dequeueReusableCellWithIdentifier:identifier];
  if (cell == nil) {
      cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
      UIView *selectedView = [[UIView alloc] init];
      [selectedView setBackgroundColor:[UIColor redColor]];
      [cell setSelectedBackgroundView:selectedView];
  }

  SCOGroup *group = [[self groups] objectAtIndex:arg2.row];

  [cell.textLabel setText:group.title];
  NSString *friendsCount = [[SCAppDelPrefs sharedInstance] localizedStringForKey:@"%zd FRIENDS"];
  [cell.detailTextLabel setText:[NSString stringWithFormat:friendsCount, [[group friends] count]]];
  [cell.detailTextLabel setTextColor:[UIColor blackColor]];
  [cell setAccessoryType:1];
  return cell;
}
- (void)tableView:(UITableView *)arg1 didSelectRowAtIndexPath:(NSIndexPath *)arg2 {
  [arg1 deselectRowAtIndexPath:arg2 animated:NO];
  SCOGroup *group = [[self groups] objectAtIndex:arg2.row];
  [self showEditControllerWithGroup:group];
}
- (_Bool)tableView:(UITableView *)arg1 canEditRowAtIndexPath:(NSIndexPath *)arg2 {
    return YES;
}
- (void)tableView:(UITableView *)arg1 commitEditingStyle:(NSInteger)arg2 forRowAtIndexPath:(NSIndexPath *)arg3 {
  if (arg2 == 1) {
    SCOGroup *group = [[self groups] objectAtIndex:arg3.row];
    [SCOGroupsHelper deleteGroup:group];
    [[self groups] removeObjectAtIndex:arg3.row];
    [arg1 deleteRowsAtIndexPaths:@[arg3] withRowAnimation:100];
  }
}
- (void)tableView:(UITableView *)arg1 willDisplayCell:(UITableViewCell *)arg2 forRowAtIndexPath:(NSIndexPath *)arg3 {
  if ([arg1 respondsToSelector:@selector(setSeparatorInset:)]) {
    [arg1 setSeparatorInset:UIEdgeInsetsZero];
  } else if ([arg1 respondsToSelector:@selector(setLayoutMargins:)]) {
    [arg1 setLayoutMargins:UIEdgeInsetsZero];
  }
}
- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
  } else if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
    [self.tableView setLayoutMargins:UIEdgeInsetsZero];
  }
}
- (_Bool)shouldAutorotateToInterfaceOrientation:(long long)arg1 {
  return UIInterfaceOrientationIsPortrait(arg1);
}
@end
