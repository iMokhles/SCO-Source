//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <Foundation/Foundation.h>
#import "User.h"

//
//#import "SCAuthenticationService-Protocol.h"
//#import "SCFriendManagerProvider-Protocol.h"
//#import "SCLegacyLoginUpdatesDelegate-Protocol.h"
//#import "SCNetworkingRankingUserInfoProvider-Protocol.h"
//#import "SCRegisterAccountV2ViewControllerDelegate-Protocol.h"
//#import "SCRequestAuthenticator-Protocol.h"
//#import "SCStoriesService-Protocol.h"
//#import "SCTimeProfilable-Protocol.h"
//#import "SCUpdatesResponseListenerAnnouncerChangeListener-Protocol.h"
//#import "SCUserProvider-Protocol.h"

//@class NSDate, NSString, NSTimer, SCAppNotificationProvider, SCBadgeUpdater, SCChatLoader, SCConversationMediaLoader, SCListenableUpdatesResponseAnnouncer, SCNotificationProcessingManager, SCQueuePerformer, SCScopedAccess, SCSnapLoader, SCStories, SCStoriesUnarchiver, SCStoryLoader, SCUserNavigationTracker, SOJUUpdatesResponse, User;
//@protocol OS_dispatch_queue, SCServerFeedEventGenerator;

@interface Manager : NSObject
////<SCFriendManagerProvider, SCRequestAuthenticator, SCTimeProfilable, SCUpdatesResponseListenerAnnouncerChangeListener, SCUserProvider, SCRegisterAccountV2ViewControllerDelegate, SCAuthenticationService, SCStoriesService, SCLegacyLoginUpdatesDelegate, SCNetworkingRankingUserInfoProvider>
//{
////    SCQueuePerformer *_updatesAnnouncerPerformer;
////    SCListenableUpdatesResponseAnnouncer *_updatesResponseAnnouncer;
////    SOJUUpdatesResponse *_lastUpdatesResponse;
//    NSObject *_userLock;
//    NSObject *_allUpdatesLock;
////    SCBadgeUpdater *_badgeUpdater;
////    SCUserNavigationTracker *_userNavigationTracker;
////    id <SCServerFeedEventGenerator> _generator;
////    SCScopedAccess *_scopedLazyUFSDataCoordinator;
//    _Bool _shouldRecordFirstSnapWhenLaunchApp;
//    _Bool _fetchingAllUpdatesFromServer;
//    _Bool _startupToContentReady;
//    _Bool _pendingConversationsAfterQuickLogin;
//    _Bool _pendingFriendsDependentsAfterQuickLogin;
//    _Bool _pendingStoriesAfterQuickLogin;
////    SCStoriesUnarchiver *_storiesUnarchiver;
//    User *_user;
////    SCNotificationProcessingManager *_notificationController;
////    SCAppNotificationProvider *_notificationProvider;
////    SCStories *_stories;
////    SCConversationMediaLoader *_conversationMediaLoader;
////    SCStoryLoader *_storyLoader;
////    SCSnapLoader *_snapLoader;
////    SCChatLoader *_chatLoader;
//    NSTimer *_centralTimer;
//    NSDate *_referenceDateForFeedTimestamps;
//    unsigned long long _sessionCount;
////    NSObject<OS_dispatch_queue> *_flushEventsQueue;
//}
//
//+ (int)context;
//+ (void)clearUnusedMediaURLsExcludingURLsFromSnaps:(id)arg1 andStories:(id)arg2;
+ (Manager *)shared;
//+ (_Bool)isInitialized;
////+ (void)sendReportWithParams:(id)arg1 authenticator:(id)arg2 endpoint:(id)arg3 successBlock:(CDUnknownBlockType)arg4 failureBlock:(CDUnknownBlockType)arg5;
////+ (void)reportSnapWithParameters:(id)arg1 authenticator:(id)arg2 successBlock:(CDUnknownBlockType)arg3 failureBlock:(CDUnknownBlockType)arg4;
////+ (void)fetchPreCacheDataForLocationWithParameters:(id)arg1 requestParser:(id)arg2 callbackQueue:(id)arg3 successBlock:(CDUnknownBlockType)arg4 failureBlock:(CDUnknownBlockType)arg5;
////+ (void)fetchDataForLocationWithParameters:(id)arg1 callbackQueue:(id)arg2 referenceId:(id)arg3 successBlock:(CDUnknownBlockType)arg4 failureBlock:(CDUnknownBlockType)arg5;
////+ (void)registerDeviceTokenWithParameters:(id)arg1 authenticator:(id)arg2 successBlock:(CDUnknownBlockType)arg3 failureBlock:(CDUnknownBlockType)arg4;
////+ (void)fetchDescriptionForSharedStoryIdWithParameters:(id)arg1 successBlock:(CDUnknownBlockType)arg2 failureBlock:(CDUnknownBlockType)arg3;
////+ (void)flushEvents:(id)arg1 successBlock:(CDUnknownBlockType)arg2 failureBlock:(CDUnknownBlockType)arg3;
////+ (void)fetchAllUpdatesWithParameters:(id)arg1 optionalParameters:(id)arg2 successBlock:(CDUnknownBlockType)arg3 failureBlock:(CDUnknownBlockType)arg4;
////@property(readonly, nonatomic) NSObject<OS_dispatch_queue> *flushEventsQueue; // @synthesize flushEventsQueue=_flushEventsQueue;
//@property(nonatomic) unsigned long long sessionCount; // @synthesize sessionCount=_sessionCount;
//@property(nonatomic) _Bool pendingStoriesAfterQuickLogin; // @synthesize pendingStoriesAfterQuickLogin=_pendingStoriesAfterQuickLogin;
//@property(nonatomic) _Bool pendingFriendsDependentsAfterQuickLogin; // @synthesize pendingFriendsDependentsAfterQuickLogin=_pendingFriendsDependentsAfterQuickLogin;
//@property(nonatomic) _Bool pendingConversationsAfterQuickLogin; // @synthesize pendingConversationsAfterQuickLogin=_pendingConversationsAfterQuickLogin;
//@property(nonatomic) _Bool startupToContentReady; // @synthesize startupToContentReady=_startupToContentReady;
//@property(nonatomic) _Bool fetchingAllUpdatesFromServer; // @synthesize fetchingAllUpdatesFromServer=_fetchingAllUpdatesFromServer;
//@property(nonatomic) _Bool shouldRecordFirstSnapWhenLaunchApp; // @synthesize shouldRecordFirstSnapWhenLaunchApp=_shouldRecordFirstSnapWhenLaunchApp;
//@property(retain, nonatomic) NSDate *referenceDateForFeedTimestamps; // @synthesize referenceDateForFeedTimestamps=_referenceDateForFeedTimestamps;
//@property(retain, nonatomic) NSTimer *centralTimer; // @synthesize centralTimer=_centralTimer;
////@property(retain, nonatomic) SCChatLoader *chatLoader; // @synthesize chatLoader=_chatLoader;
////@property(retain, nonatomic) SCSnapLoader *snapLoader; // @synthesize snapLoader=_snapLoader;
////@property(retain, nonatomic) SCStoryLoader *storyLoader; // @synthesize storyLoader=_storyLoader;
////@property(retain, nonatomic) SCConversationMediaLoader *conversationMediaLoader; // @synthesize conversationMediaLoader=_conversationMediaLoader;
////@property(retain, nonatomic) SCStories *stories; // @synthesize stories=_stories;
////@property(retain, nonatomic) SCAppNotificationProvider *notificationProvider; // @synthesize notificationProvider=_notificationProvider;
////@property(retain, nonatomic) SCNotificationProcessingManager *notificationController; // @synthesize notificationController=_notificationController;
@property(retain, nonatomic) User *user; // @synthesize user=_user;
////@property(retain, nonatomic) SCStoriesUnarchiver *storiesUnarchiver; // @synthesize storiesUnarchiver=_storiesUnarchiver;
//- (void)startBadgeUpdater;
//- (double)timeEnteredBackground;
//- (_Bool)shouldReturnToCamera:(double)arg1;
//- (_Bool)shouldOpenToCameraAfterBackgroundingOnViewController:(id)arg1;
//- (_Bool)isOfficialStoryCollaborator;
//- (void)_setDirectToStorageFromResponse:(id)arg1;
//- (void)_setMobEnabledValueFromResponse:(id)arg1;
//- (void)_didReceiveUpdatesResponse:(id)arg1;
//- (void)didAddListener:(id)arg1;
//- (void)setUpdatesResponseAnnouncer:(id)arg1;
//- (void)_removeDocumentFilesAfterLogout;
//- (void)_scheduleStorageManagementAfter:(double)arg1;
//- (void)postServerChallenge;
////- (void)clearExpiredAndViewedStoriesWithCompletion:(CDUnknownBlockType)arg1;
//- (void)didAppStartupComplete;
//- (_Bool)userHasValidRequest;
//- (void)willEnterForegroundFromRemoteNotification:(_Bool)arg1 isColdStart:(_Bool)arg2;
//- (void)didEnterBackground;
//- (void)loadRecentSnapsAndMedia;
//- (void)prepareForBecomeActiveFromRemoteNotification:(_Bool)arg1;
//- (void)prepareForResignActive;
//- (void)startTimerIfNecessary;
- (void)markSnapAsViewed:(id)arg1 cellViewPosition:(long long)arg2;
- (void)markSnapAsViewed:(id)arg12;
//- (void)tick:(id)arg1;
//- (void)registerDeviceToken:(id)arg1 voipToken:(id)arg2;
//- (void)checkMobile;
//- (void)doLogoutRequest:(_Bool)arg1;
//- (void)logoutForced:(_Bool)arg1;
//- (void)_logApplicationLogout:(_Bool)arg1 reason:(unsigned long long)arg2;
//- (id)_logoutReasonFor:(unsigned long long)arg1;
//- (void)forceLogout:(unsigned long long)arg1;
//- (void)logout:(unsigned long long)arg1;
//- (_Bool)canLoadMoreConversationsAutomatically;
//- (_Bool)shouldShowFeedLoadingView;
//- (void)loadMoreConversationsIfPossibleForceOnFailed:(_Bool)arg1;
////- (CDUnknownBlockType)fetchConversationsFailureBlock;
//- (void)_didFetchStoriesFailure:(id)arg1;
//- (void)_didFetchUpdatesFailure:(id)arg1;
////- (void)_didFetchStoriesSuccessWithTriggerType:(long long)arg1 requestMetadata:(id)arg2 conversationFeedIds:(id)arg3 storiesResponse:(id)arg4 completionHandler:(CDUnknownBlockType)arg5;
////- (CDUnknownBlockType)fetchConversationsSuccessBlock;
////- (CDUnknownBlockType)fetchStoriesFailureBlockWithTriggerType:(long long)arg1 completionHandler:(CDUnknownBlockType)arg2;
////- (void)_applyStoriesResponse:(id)arg1 conversationFeedIds:(id)arg2 triggerType:(long long)arg3 requestMetadata:(id)arg4 skipApplyingResponse:(_Bool)arg5 isPullToRefresh:(_Bool)arg6 completion:(CDUnknownBlockType)arg7;
////- (CDUnknownBlockType)_fetchStoriesSuccessBlockWithRequestMetadata:(id)arg1 conversationFeedIds:(id)arg2 triggerType:(long long)arg3 completionHandler:(CDUnknownBlockType)arg4;
//- (void)updateCacheLimit;
////- (CDUnknownBlockType)fetchUpdatesSuccessBlockWithTriggerType:(long long)arg1;
////- (void)_fetchStoriesWithTriggerType:(long long)arg1 completionHandler:(CDUnknownBlockType)arg2 forceMakingRequest:(_Bool)arg3 requestSource:(long long)arg4;
////- (void)fetchStoriesWithCompletion:(CDUnknownBlockType)arg1 forceMakingRequest:(_Bool)arg2 requestSource:(long long)arg3;
//- (void)fetchStoriesWithTriggerType:(long long)arg1 requestSource:(long long)arg2;
////- (void)_handleDeltaFetchCompletionWithGroupDeltaRequest:(struct NSArray *)arg1 chatDeltaRequest:(struct NSDictionary *)arg2 snapDeltaRequest:(struct NSDictionary *)arg3 parameters:(id)arg4 successBlock:(CDUnknownBlockType)arg5 failureBlock:(CDUnknownBlockType)arg6;
////- (void)fetchAllConversationsWithTriggerType:(long long)arg1 parameters:(id)arg2 successBlock:(CDUnknownBlockType)arg3 failureBlock:(CDUnknownBlockType)arg4;
////- (void)_fetchUpdatesWithCompletionHandler:(CDUnknownBlockType)arg1 isAllUpdates:(_Bool)arg2 includeConversations:(_Bool)arg3 triggerType:(long long)arg4;
//- (unsigned long long)fideliusStatus;
//- (void)_didFetchUpdatesWithIsPullToRefresh:(_Bool)arg1 isAllUpdates:(_Bool)arg2 completion:(CDUnknownBlockType)arg3;
//- (void)_logFetchUpdatesOnFeedWithIsPullToRefresh:(_Bool)arg1 isAllUpdates:(_Bool)arg2 isFullResponse:(_Bool)arg3;
////- (void)_didFetchUpdatesSuccessfullyWithServerInfo:(id)arg1 updatesResponse:(id)arg2 friendsResponse:(id)arg3 identityCheckResponse:(id)arg4 chatConversationsResponse:(id)arg5 groupConversationsResponse:(id)arg6 conversationResponseInfo:(id)arg7 feedResponseInfo:(id)arg8 messagingGatewayInfo:(id)arg9 securityResponseInfo:(id)arg10 fideliusStatus:(unsigned long long)arg11 triggerType:(long long)arg12 isAllUpdates:(_Bool)arg13 completion:(CDUnknownBlockType)arg14;
////- (void)_fetchUpdatesSuccessWithResponse:(id)arg1 isAllUpdates:(_Bool)arg2 triggerType:(long long)arg3 fideliusStatus:(unsigned long long)arg4 onCompletion:(CDUnknownBlockType)arg5;
//- (void)fetchConversationsUpdatesWithNotificationReport;
//- (void)fetchConversationsUpdates;
//- (void)unarchiveMoreConversations;
//- (void)_fetchMoreConversations;
//- (void)_fetchMoreConversationsV2;
////- (void)_fetchConversationsWithFriends:(_Bool)arg1 triggerType:(long long)arg2 completion:(CDUnknownBlockType)arg3;
//- (void)_fetchUpdatesFromLaunchIncludeConversations:(_Bool)arg1 triggerType:(long long)arg2;
//- (void)fetchConversationsUpdatesAndStories;
//- (void)_fetchConversationDeltaFetchInfoWithTriggerType:(long long)arg1 completion:(CDUnknownBlockType)arg2;
////- (void)_fetchFriendsWithCompletion:(CDUnknownBlockType)arg1;
//- (void)_fetchFriendsAndChecksumsWithTriggerType:(long long)arg1 completion:(CDUnknownBlockType)arg2;
////- (void)_fetchChecksumsAndFriendsAndConversationsDeltaFetchInfoWithTriggerType:(long long)arg1 completion:(CDUnknownBlockType)arg2;
////- (void)_createFriendFeedRequestWithTriggerType:(long long)arg1 layoutType:(long long)arg2 chatFeedIterToken:(id)arg3 sessionId:(id)arg4 requestId:(id)arg5 excludeFriends:(_Bool)arg6 knownChatFeedItems:(id)arg7 completion:(CDUnknownBlockType)arg8;
//- (void)applyCheetahStoriesRequestMetadata:(id)arg1 storiesResponse:(id)arg2 feedItemResponse:(id)arg3 triggerType:(long long)arg4;
//- (void)_addInteractionEventsForServerFeedItems:(id)arg1 triggerType:(long long)arg2;
//- (void)_parseRankingMetaData:(id)arg1 friendsFeedUserSignals:(id)arg2;
//- (_Bool)_hasNewChatOrSnap:(id)arg1;
////- (void)_fetchCheetahFriendFeedWithTriggerType:(long long)arg1 layoutType:(long long)arg2 chatFeedIterToken:(id)arg3 knownChatFeedItems:(id)arg4 completion:(CDUnknownBlockType)arg5;
////- (void)_fetchCheetahFriendFeedWithTriggerType:(long long)arg1 chatFeedIterToken:(id)arg2 knownChatFeedItems:(id)arg3 completion:(CDUnknownBlockType)arg4;
////- (void)_fetchCheetahFriendFeedWithTriggerType:(long long)arg1 layoutType:(long long)arg2 completion:(CDUnknownBlockType)arg3;
//- (void)_fetchCheetahFriendFeedWithTriggerType:(long long)arg1 completion:(CDUnknownBlockType)arg2;
//- (id)parametersForFetchUpdates;
//- (void)markViewedStories:(_Bool)arg1;
//- (void)_flushLoggerEvents;
//- (void)markViewedSnaps;
//- (void)markViewedAddedFriends;
//- (id)getUpdatedSnapsJsonWithUpdatedSnaps:(id)arg1;
//- (id)registerDidSucceedWithResponse:(id)arg1 tempIdentity:(id)arg2;
//- (void)_performPostQuickLoginUpdates;
//- (void)finishRegistration:(id)arg1;
//- (_Bool)hasEnteredAnEmail;
//- (long long)preferredVerificationMethod;
//- (void)loginDidFailWithUsernameOrEmail:(id)arg1 errorInfo:(id)arg2;
//- (void)loginDidSucceedWithResponse:(id)arg1 tempIdentity:(id)arg2 userSession:(id)arg3;
//- (void)loginDidSucceedWithVerificationNeeded:(id)arg1;
//- (id)authenticator_DO_NOT_USE_OR_YOU_WILL_BE_FIRED;
//- (id)username;
//- (id)authToken;
//- (_Bool)isUserCreated;
//- (_Bool)userDataAvailable;
//- (id)init;
//- (id)friendManager;
//
//// Remaining properties
//@property(readonly, copy) NSString *debugDescription;
//@property(readonly, copy) NSString *description;
//@property(readonly) unsigned long long hash;
//@property(readonly) Class superclass;

@end

