//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <Foundation/Foundation.h>

//@class NSDate, NSDictionary, NSMutableDictionary, NSSet, NSString, SCArchivedChats, SCChatTypingExpirationHandler, SCMediaCardCache, SCUserSession;
//@protocol SCChatConversationFetcher, SCTalkManager;

@interface SCChats : NSObject

//<SCTimeProfilable, NSCoding, SCChatMessageReceiveListener, SCTV3ActiveConversationsListener>
//{
//    struct SC1On1AndGroupSyncState _1On1AndGroupSyncState;
//    SCChatTypingExpirationHandler *_typingExpirationHandler;
//    id <SCTalkManager> _talkManager;
//    NSSet *_previousActiveConversationIds;
//    _Bool _clearing;
//    id <SCChatConversationFetcher> _conversationFetcher;
//    NSString *_activeChatRecipientBeforeBackgrounded;
//    NSString *_lastChatIdWhenActiveChatEntered;
//    NSMutableDictionary *_chats;
//    NSString *_username;
//    SCUserSession *_userSession;
//    NSDictionary *_archivedInitialChatsDeltaRequests;
//    NSDictionary *_archivedSnapsDeltaRequests;
//    NSDate *_lastCleanClearedMessagesDate;
//    SCMediaCardCache *_mediaCardCache;
//    SCArchivedChats *_archivedInitialChats;
//    SCArchivedChats *_archivedPaginatedChats;
//}
//
//+ (int)context;
//+ (_Bool)hasUnviewedChats:(id)arg1;
//+ (_Bool)hasUnviewedCash:(id)arg1;
//+ (_Bool)hasUnviewedSnaps:(id)arg1;
//+ (id)filterOrphanedChats:(id)arg1;
//+ (long long)unreadCountForChats:(id)arg1 logChats:(_Bool)arg2 countOneUnreadMessagePerChat:(_Bool)arg3;
//+ (long long)unreadCountForChats:(id)arg1 logChats:(_Bool)arg2;
//+ (long long)unreadCountForChats:(id)arg1;
//+ (id)archivedPaginatedChatsPath;
//+ (id)archivedInitialChatsPath;
//+ (id)chatConversationsFromResponses:(id)arg1;
//@property(retain, nonatomic) SCArchivedChats *archivedPaginatedChats; // @synthesize archivedPaginatedChats=_archivedPaginatedChats;
//@property(retain, nonatomic) SCArchivedChats *archivedInitialChats; // @synthesize archivedInitialChats=_archivedInitialChats;
//@property(retain, nonatomic) SCMediaCardCache *mediaCardCache; // @synthesize mediaCardCache=_mediaCardCache;
//@property(retain, nonatomic) NSDate *lastCleanClearedMessagesDate; // @synthesize lastCleanClearedMessagesDate=_lastCleanClearedMessagesDate;
//@property(nonatomic, getter=isClearing) _Bool clearing; // @synthesize clearing=_clearing;
//@property(retain, nonatomic) NSDictionary *archivedSnapsDeltaRequests; // @synthesize archivedSnapsDeltaRequests=_archivedSnapsDeltaRequests;
//@property(retain, nonatomic) NSDictionary *archivedInitialChatsDeltaRequests; // @synthesize archivedInitialChatsDeltaRequests=_archivedInitialChatsDeltaRequests;
//@property(nonatomic) __weak SCUserSession *userSession; // @synthesize userSession=_userSession;
//@property(retain, nonatomic) NSString *username; // @synthesize username=_username;
//@property(retain, nonatomic) NSMutableDictionary *chats; // @synthesize chats=_chats;
//@property(retain, nonatomic) NSString *lastChatIdWhenActiveChatEntered; // @synthesize lastChatIdWhenActiveChatEntered=_lastChatIdWhenActiveChatEntered;
//@property(retain, nonatomic) NSString *activeChatRecipientBeforeBackgrounded; // @synthesize activeChatRecipientBeforeBackgrounded=_activeChatRecipientBeforeBackgrounded;
//@property(readonly, nonatomic) id <SCChatConversationFetcher> conversationFetcher; // @synthesize conversationFetcher=_conversationFetcher;
//- (void).cxx_destruct;
//- (void)onActiveConversationsChanged;
//- (void)syncLastAcknowledgedSentReleasedMessageId:(id)arg1;
//- (void)syncOneOnOneAndGroup;
//- (void)unarchivePaginatedChatsAndSyncOneOnOneAndGroup;
//- (void)updateWithContentInviteSOJUReceivedSnap:(id)arg1;
//- (void)_bitmojiAvatarIdDidChange;
//- (void)messageStateDidChange:(id)arg1 recipient:(id)arg2;
//- (id)chatEventsAfterUpdatingWithChatConversations:(id)arg1 originType:(long long)arg2;
//- (id)clearFeedIdsAfterRemovingChats:(id)arg1;
//- (void)removeChat:(id)arg1;
//- (void)removeAllChats;
//- (void)removeOldChats;
//- (void)removeChatForBlockedOrDeletedFriend:(id)arg1;
//- (void)clearChatForRecipient:(id)arg1;
//- (void)cleanUpClearedMessages;
//- (void)releaseLeftoverMessages;
//- (_Bool)hasStaleChatsBasedOnFirstPageChatConversations:(id)arg1;
//- (id)latestInteractionTimestamp;
//- (id)originatingChatsFromChatConversations:(id)arg1;
//- (id)localStaleChatsWithChatConversations:(id)arg1;
//- (id)oldChats;
//- (id)invalidChats;
//- (void)removeExpiredMessages;
//- (void)retrySendingAllFailedMessagesWithRecipient:(id)arg1 userSession:(id)arg2;
//- (void)retryPendingOrFailedMessagesIfPossible;
//- (void)unpreserveMessage:(id)arg1;
//- (void)preserveMessage:(id)arg1;
//- (void)unsaveMessage:(id)arg1;
//- (void)saveMessage:(id)arg1;
//- (void)sendSnapState:(id)arg1;
//- (void)removeMessage:(id)arg1;
//- (void)insertSendingMessage:(id)arg1;
//- (void)sendMedia:(id)arg1 completionHandler:(CDUnknownBlockType)arg2;
//- (void)mediaMessage:(id)arg1 didSentWithSuccess:(_Bool)arg2;
//- (id)chatForBaseMessage:(id)arg1;
//- (id)messageWithMessageId:(id)arg1 inConversation:(id)arg2;
//- (id)chatForConversationId:(id)arg1;
//- (void)removeMessageByMessageId:(id)arg1 recipient:(id)arg2;
//- (id)addOrUpdateMediaMessageWithRecipient:(id)arg1 uploadedMediaProviders:(id)arg2 messageMetadata:(id)arg3;
//- (void)attemptSentUploadedMediaWithRecipient:(id)arg1 uploadedMediaProviders:(id)arg2 messageMetadata:(id)arg3 chatText:(id)arg4 completionHandler:(CDUnknownBlockType)arg5;
//- (void)fetchOneOnOneConversationsDeltaFetchInfoWithCompletion:(CDUnknownBlockType)arg1;
//- (id)snapDeltaChatConversationRequests;
//- (id)deltaChatConversationRequestsWithChats:(id)arg1;
//- (id)deltaChatConversationRequests;
//- (id)allChats;
//- (id)orderedChats;
//- (id)uniqueChats;
//- (void)fetchChatAsyncIfNecessaryForUsername:(id)arg1 completionHandler:(CDUnknownBlockType)arg2;
//- (id)findOrCreateChatAndFetchUpdatesForUsername:(id)arg1;
- (id)chatForUsername:(id)arg1;
//- (_Bool)firstChatHasLoadedSnap;
//- (_Bool)activeBackgroundedChatHasUnreadMessageOrCallInProgress;
//- (void)loadBatchOfSnapsWithRecipient:(id)arg1;
//- (void)removeSnap:(id)arg1;
//- (void)addSnap:(id)arg1 contentInviteRecipient:(id)arg2;
//- (void)addSnap:(id)arg1;
//- (_Bool)shouldAcceptMessageFromSender:(id)arg1;
//- (void)didReceiveMischiefs:(id)arg1 hasStaleChats:(_Bool)arg2 originType:(long long)arg3 source:(long long)arg4;
//- (void)didReceiveConversations:(id)arg1 originType:(long long)arg2 source:(long long)arg3;
//- (void)didReceiveWireMessage:(id)arg1;
//- (void)didLoadMoreChatConversations:(id)arg1;
//- (void)logReceivedNewSnapsForChat:(id)arg1;
//- (void)logReceivedMessagesForNewChat:(id)arg1;
//- (void)logChatConversations:(id)arg1 logId:(id)arg2;
//- (id)chatAfterUpdatingWithChatConversation:(id)arg1;
//- (void)updateWithChatConversation:(id)arg1;
//- (void)addChatConversations:(id)arg1;
//- (void)updateWithChatConversations:(id)arg1 hasStaleChats:(_Bool)arg2 originType:(long long)arg3;
//- (void)_addInteractionEventBatchForChat:(id)arg1;
//- (void)_resetTypingStateWithConvId:(id)arg1;
//- (void)didReceivePushTypeTypingForChat:(id)arg1;
//- (void)didUpdateNoficationSettingForUser:(id)arg1 enabled:(_Bool)arg2;
//- (void)sccpConnected;
//- (void)sccpDisconnected:(id)arg1;
//- (void)chatsDidChange;
//- (_Bool)paginatedChatsLoaded;
//- (_Bool)initialChatsLoaded;
//- (void)unarchivedPaginatedChatsWithCompletion:(CDUnknownBlockType)arg1;
//- (void)waitUntilPaginatedChatsLoadedOnQueue:(id)arg1 loadedBlock:(CDUnknownBlockType)arg2;
//- (void)waitUntilInitialChatsLoadedOnQueue:(id)arg1 loadedBlock:(CDUnknownBlockType)arg2;
//- (void)waitUntilChatsLoadedOnQueue:(id)arg1 loadedBlock:(CDUnknownBlockType)arg2;
//- (void)removeArchivedPaginatedChatsIfNotLoaded;
//- (void)appendArchivedChats:(id)arg1;
//- (void)ensureNonNilObjects;
//- (id)initWithCoder:(id)arg1;
//- (void)archiveChatsWithCoder:(id)arg1;
//- (void)encodeWithCoder:(id)arg1;
//- (void)dealloc;
//- (id)initWithUsername:(id)arg1;
//- (id)init;
//- (id)bitmojiManager;
//- (void)setBitmojiManager:(id)arg1;
//
//// Remaining properties
//@property(readonly, copy) NSString *debugDescription;
//@property(readonly, copy) NSString *description;
//@property(readonly) unsigned long long hash;
//@property(readonly) Class superclass;

@end

