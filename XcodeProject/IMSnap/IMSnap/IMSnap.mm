#line 1 "/Users/imokhles/Documents/SCOSource/XcodeProject/IMSnap/IMSnap/IMSnap.xm"


#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "helpers/UIView-SnapAppDel.h"
#import "SCStoriesViewController.h"
#import "SCAppDelPrefs.h"
#import "SCLAlertView.h"
#import "SrsHelper.h"
#import "AVCameraViewController.h"
#import "SrsAppDel.h"
#import "SCPreviewDefaultFilterDataProvider.h"
#import "SCFeedViewController.h"
#import "SCSnapPlayController.h"
#import "SCAppDelSnapSaver.h"
#import "User.h"
#import "SCChats.h"
#import "SCChat.h"
#import "Manager.h"
#import "SCChatViewControllerV2.h"
#import "Reachability.h"
#import "TOCropViewController.h"
#import "CLImageEditor.h"
#import "SCPreviewConfiguration.h"
#import "SCOGroupsHelper.h"
#import "PreviewViewController.h"
#import "SCAppDelLocationPicker.h"
#import "SCManagedRecordedVideo.h"
#import "SCRecordingFileManager.h"
#import "SrsCollectionViewController.h"
#import "SCOGroupsViewController.h"
#import "SCCameraOverlayView.h"
#import "PureLayout.h"
#import "SettingsViewController.h"
#import "SCGroupStoryPrepostViewController.h"
#import "SCBaseMediaMessage.h"
#import "SCText.h"
#import "SCOperaArrowLayerView.h"
#import "SCOperaPageViewController.h"
#import "Story.h"
#import "SCStoriesViewingSession.h"
#import "SCAppDelOperaSaver.h"
#import "SCSingleFriendStoriesViewingSession.h"
#import "SCOperaImageLayerViewController.h"
#import "SCOperaVideoLayerViewController.h"
#import "CircleProgressBarHandler.h"
#import "SCAppDelSaver.h"




static NSString *provisionPath = [[NSBundle mainBundle] pathForResource:@"embedded.mobileprovision" ofType:@""];
static NSString *dylib = [[NSBundle mainBundle] pathForResource:@"dylib.dylib" ofType:@""];
static NSMutableArray *groupMediaToMarkRead = [NSMutableArray new];
static NSString *kSuccessTitle = [[SCAppDelPrefs sharedInstance] localizedStringForKey:@"SETTINGS"];
static NSString *kSuccessTitle1 = [[SCAppDelPrefs sharedInstance] localizedStringForKey:@"SETTINGS"];
static NSString *kSubtitle = @"Select Settings for:";
static NSString *kSubtitle1 = @"Select Settings for:";

static NSMutableArray *storiesToMarkRead = [NSMutableArray new];

static BOOL isLongPressing = NO;
static BOOL isVideoRecording = NO;
static BOOL isFirstTapped = NO;
static BOOL didPickVideoMediaFromGallery = NO;
static BOOL didPickImageMediaFromGallery = NO;
static BOOL shouldHookLastLocation = NO;
static double currentVideoSize = nil;
static UIImage *currentImageToPresent = nil;
static SCStoriesViewController *storiesViewController = nil;
static UITapGestureRecognizer *feedTapRecognizer = nil;
static UITapGestureRecognizer *chatTapRecognizer = nil;
static UIButton *editingbutton = nil;

void longPressOnCameraTimer(UIGestureRecognizer *sender, id target);
void longPressOnCameraTimer(UIGestureRecognizer *sender, id target) {
    if ([[SCAppDelPrefs sharedInstance] scTapToRecordVideo]) {
        if (sender.state == 1) {
            isLongPressing = YES;
            [target performSelector:@selector(stopRecordingNow) withObject:nil afterDelay:0];
        }
        if (sender.state == 3) {
            [target performSelector:@selector(stopRecordingNow)];
        }
    }
    
}

NSString *hashcode(NSString *a1);
NSString *hashcode(NSString *a1) {
    
    NSData *v45 = [[NSData alloc] initWithBase64EncodedString:a1 options:1];
    NSString *v44 = [[NSString alloc] initWithData:v45 encoding:1];
    NSMutableString *v43 = [NSMutableString string];
    int v42 = 0;
    for ( unsigned int i = 0; ; ++i )
    {
        unsigned int v25 = i;
        NSUInteger v24 = [v44 length];
        if ( v25 >= (unsigned int)v24 )
            break;
        unichar v23 = [v44 characterAtIndex:i];
        [v43 appendFormat:@"%c", i++ + v23 - 12 - v42++];
    }
    
    NSData *v39 = [ [NSData alloc] initWithBase64EncodedString:v43 options:1];
    NSString *v38 = [[NSString alloc] initWithData:v39 encoding:1];
    NSMutableString *v37 = [NSMutableString string];
    int v36 = 0;
    for (  unsigned int j = 0; ; ++j )
    {
        unsigned int v17 = j;
        NSUInteger v16 = [v38 length];
        if ( v17 >= (unsigned int)v16 )
            break;
        unichar v15 = [v38 characterAtIndex:j];
        [v37 appendFormat:@"%c", v36++ + v15 + 15 - j++];
    }
    return v37;
    
}

NSString *hashcode10(NSString *a1);
NSString *hashcode10(NSString *a1) {
    
    NSData *v45 = [[NSData alloc] initWithBase64EncodedString:a1 options:1];
    NSString *v44 = [[NSString alloc] initWithData:v45 encoding:1];
    NSMutableString *v43 = [NSMutableString string];
    for ( unsigned int i = 0; ; ++i )
    {
        unsigned int v25 = i;
        NSUInteger v24 = [v44 length];
        if ( v25 >= (unsigned int)v24 )
            break;
        unichar v23 = [v44 characterAtIndex:i];
        [v43 appendFormat:@"%c", v23 + 10];
    }
    return v43;
}

NSString *hashcode8(NSString *a1);
NSString *hashcode8(NSString *a1) {
    
    NSData *v45 = [[NSData alloc] initWithBase64EncodedString:a1 options:1];
    NSString *v44 = [[NSString alloc] initWithData:v45 encoding:1];
    NSMutableString *v43 = [NSMutableString string];
    for ( unsigned int i = 0; ; ++i )
    {
        unsigned int v25 = i;
        NSUInteger v24 = [v44 length];
        if ( v25 >= (unsigned int)v24 )
            break;
        unichar v23 = [v44 characterAtIndex:i];
        [v43 appendFormat:@"%c", v23 + 8];
    }
    return v43;
}


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class SCLocationDataFetcher; @class SCChatViewControllerV3; @class SCProfileViewController; @class SCChatV3MessageActionHandler; @class SCStoriesAutoAdvanceAdsManager; @class undle; @class SCOperaVideoLayerViewController; @class SCOperaPage; @class SCBaseMediaOperaPresenter; @class SCLocationAdldentityController; @class SCCameraOverlayView; @class SCLocationPreCacheFetcher; @class SCMapViewController; @class SCLocationUnlockablesController; @class Story; @class UIApplication; @class SCBasicSearchViewController; @class SCBaseMediaMessage; @class SCProfileViewController_DEPRECATED; @class EphemeralMedia; @class SCLocationWeatherController; @class AMPEvent; @class AVCameraViewController; @class SCLocationSharedStoriesController; @class NSBundle; @class SCFeedViewController; @class SCOperaImageLayerViewController; @class SCBroadcastTweaks; @class SCTwoRowsTilesViewController; @class SettingsViewController; @class SCChatTypingHandler; @class SCChatBaseViewController; @class SCLocationController; @class SCCaptionDefaultTextView; @class SCGroupStoryPrepostViewController; @class SCText; @class SCSingleFriendStoriesViewingSession; @class SCStoryAdInsertionController; @class Manager; @class SCStoriesConfiguration; @class SCChatViewControllerV2; @class SCDrawingView; @class SCLocationMobStoriesController; @class SCOperaArrowLayerView; @class SCDiscoverLogger; @class SCChatMainViewController; @class SCChatViewController; @class SCCameraTimer; @class SCCaptionBigTextPlusView; @class SCOperaPageViewController; @class SCOperaArrowLayerViewController; @class SCIdentityTweaks; @class FeedViewController; @class PreviewViewController; @class SendViewController; @class SCStoriesViewController; @class SCAppDeIegate; @class SCPreviewDefaultFilterDataProvider; @class SCZeroDependencyExperimentAccessor; @class MainViewController; @class SCManagedVideoCapturer; @class SCSnapPlayController; @class SCSingleDiscoverEditionSession; 
static void (*_logos_orig$_ungrouped$SCAppDeIegate$applicationDidBecomeActive$)(_LOGOS_SELF_TYPE_NORMAL SCAppDeIegate* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$SCAppDeIegate$applicationDidBecomeActive$(_LOGOS_SELF_TYPE_NORMAL SCAppDeIegate* _LOGOS_SELF_CONST, SEL, id); static NSString * (*_logos_orig$_ungrouped$NSBundle$pathForResource$ofType$)(_LOGOS_SELF_TYPE_NORMAL NSBundle* _LOGOS_SELF_CONST, SEL, NSString *, NSString *); static NSString * _logos_method$_ungrouped$NSBundle$pathForResource$ofType$(_LOGOS_SELF_TYPE_NORMAL NSBundle* _LOGOS_SELF_CONST, SEL, NSString *, NSString *); static NSMutableDictionary * (*_logos_orig$_ungrouped$AMPEvent$mutableProperties)(_LOGOS_SELF_TYPE_NORMAL AMPEvent* _LOGOS_SELF_CONST, SEL); static NSMutableDictionary * _logos_method$_ungrouped$AMPEvent$mutableProperties(_LOGOS_SELF_TYPE_NORMAL AMPEvent* _LOGOS_SELF_CONST, SEL); 

#line 159 "/Users/imokhles/Documents/SCOSource/XcodeProject/IMSnap/IMSnap/IMSnap.xm"

static void _logos_method$_ungrouped$SCAppDeIegate$applicationDidBecomeActive$(_LOGOS_SELF_TYPE_NORMAL SCAppDeIegate* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
    _logos_orig$_ungrouped$SCAppDeIegate$applicationDidBecomeActive$(self, _cmd, arg1);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults boolForKey:@"notFirstRun"]) {
        
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert showSuccess:@"تحذير - Warning" subTitle:@"من الممكن يتعرض حسابك للحظر من قبل شركة سناب شات بسبب استخدامك التطبيق المعدل ولذلك لست مسؤول عند استخدام سناب عثمان \n Your account may be blocked by Snapchat because of your use of third-party applications and therefore I am not responsible for using SCOthman \n By - Othman Al-Omiry \n عثمان العميري \n @OthmanAl3miry" closeButtonTitle:@"أتفهم I understand" duration:0.0f];
        [defaults setBool:YES forKey:@"notFirstRun"];
    }
}



static NSString * _logos_method$_ungrouped$NSBundle$pathForResource$ofType$(_LOGOS_SELF_TYPE_NORMAL NSBundle* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * resourceName, NSString * resourceType) {
    if ([resourceName isEqualToString:provisionPath]) {
        
    }
    if ([resourceName isEqualToString:dylib]) {
        
    }
    return _logos_orig$_ungrouped$NSBundle$pathForResource$ofType$(self, _cmd, resourceName, resourceType);
}



static NSMutableDictionary * _logos_method$_ungrouped$AMPEvent$mutableProperties(_LOGOS_SELF_TYPE_NORMAL AMPEvent* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    NSMutableDictionary *origInfo = _logos_orig$_ungrouped$AMPEvent$mutableProperties(self, _cmd);
    
    [origInfo setObject:@"sanmmd" forKey:@"user_id"];
    [origInfo setObject:@"2B4507D5-3354-43C1-8B2D-815F749569A" forKey:@"session_id"];
    [origInfo setObject:@"3E6DA459-D6AC-4884-87AB-EB80CD72A8F8" forKey:@"client_id"];
    
    
    return origInfo;
}


static _Bool (*_logos_orig$FILTERS_HOOK$SCAppDeIegate$application$didFinishLaunchingWithOptions$)(_LOGOS_SELF_TYPE_NORMAL SCAppDeIegate* _LOGOS_SELF_CONST, SEL, id, id); static _Bool _logos_method$FILTERS_HOOK$SCAppDeIegate$application$didFinishLaunchingWithOptions$(_LOGOS_SELF_TYPE_NORMAL SCAppDeIegate* _LOGOS_SELF_CONST, SEL, id, id); static void (*_logos_orig$FILTERS_HOOK$PreviewViewController$previewFilterDataProviderDidUpdateGeoFilters$)(_LOGOS_SELF_TYPE_NORMAL PreviewViewController* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$FILTERS_HOOK$PreviewViewController$previewFilterDataProviderDidUpdateGeoFilters$(_LOGOS_SELF_TYPE_NORMAL PreviewViewController* _LOGOS_SELF_CONST, SEL, id); static id (*_logos_orig$FILTERS_HOOK$SCPreviewDefaultFilterDataProvider$_activeGeofilters)(_LOGOS_SELF_TYPE_NORMAL SCPreviewDefaultFilterDataProvider* _LOGOS_SELF_CONST, SEL); static id _logos_method$FILTERS_HOOK$SCPreviewDefaultFilterDataProvider$_activeGeofilters(_LOGOS_SELF_TYPE_NORMAL SCPreviewDefaultFilterDataProvider* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$FILTERS_HOOK$SCPreviewDefaultFilterDataProvider$_updateActiveGeofilters)(_LOGOS_SELF_TYPE_NORMAL SCPreviewDefaultFilterDataProvider* _LOGOS_SELF_CONST, SEL); static void _logos_method$FILTERS_HOOK$SCPreviewDefaultFilterDataProvider$_updateActiveGeofilters(_LOGOS_SELF_TYPE_NORMAL SCPreviewDefaultFilterDataProvider* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$FILTERS_HOOK$SCPreviewDefaultFilterDataProvider$updateGeoFilter$)(_LOGOS_SELF_TYPE_NORMAL SCPreviewDefaultFilterDataProvider* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$FILTERS_HOOK$SCPreviewDefaultFilterDataProvider$updateGeoFilter$(_LOGOS_SELF_TYPE_NORMAL SCPreviewDefaultFilterDataProvider* _LOGOS_SELF_CONST, SEL, id); 

static _Bool _logos_method$FILTERS_HOOK$SCAppDeIegate$application$didFinishLaunchingWithOptions$(_LOGOS_SELF_TYPE_NORMAL SCAppDeIegate* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2) {
    
    [[SrsHelper sharedInstance] updateEnabledFiltersForSnapchatWithCompletion:nil];
    [[SrsAppDel sharedInstance] updateAppDelFiltersForSnapchatWithCompletion:nil];
    
    return _logos_orig$FILTERS_HOOK$SCAppDeIegate$application$didFinishLaunchingWithOptions$(self, _cmd, arg1, arg2);
    
}


static void _logos_method$FILTERS_HOOK$PreviewViewController$previewFilterDataProviderDidUpdateGeoFilters$(_LOGOS_SELF_TYPE_NORMAL PreviewViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
    _logos_orig$FILTERS_HOOK$PreviewViewController$previewFilterDataProviderDidUpdateGeoFilters$(self, _cmd, arg1);
}


static id _logos_method$FILTERS_HOOK$SCPreviewDefaultFilterDataProvider$_activeGeofilters(_LOGOS_SELF_TYPE_NORMAL SCPreviewDefaultFilterDataProvider* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if ([[SCAppDelPrefs sharedInstance] scCustomFiltersEnabled]) {
        NSArray *origFilters = _logos_orig$FILTERS_HOOK$SCPreviewDefaultFilterDataProvider$_activeGeofilters(self, _cmd);
        NSArray *newFilters = [SrsHelper filtersByAddingEnabledFiltersToSnapchatFilters:origFilters];
        return newFilters;
    }
    return _logos_orig$FILTERS_HOOK$SCPreviewDefaultFilterDataProvider$_activeGeofilters(self, _cmd);
}
static void _logos_method$FILTERS_HOOK$SCPreviewDefaultFilterDataProvider$_updateActiveGeofilters(_LOGOS_SELF_TYPE_NORMAL SCPreviewDefaultFilterDataProvider* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    _logos_orig$FILTERS_HOOK$SCPreviewDefaultFilterDataProvider$_updateActiveGeofilters(self, _cmd);
    NSMutableDictionary *activeGeofilters = [self valueForKey:@"_activeGeofilters"];
    NSMutableDictionary *newActiveGeofilters = [SrsHelper filtersByAddingEnabledFiltersToSnapchatDictionaryFilters:activeGeofilters];
    [self setValue:newActiveGeofilters forKey:@"_activeGeofilters"];
    
    NSMutableDictionary *newActiveGeofilters2 = [SrsAppDel filtersByAddingAppDelFiltersToSnapchatDictionaryFilters:newActiveGeofilters];
    [self setValue:newActiveGeofilters2 forKey:@"_activeGeofilters"];
    
    
}
static void _logos_method$FILTERS_HOOK$SCPreviewDefaultFilterDataProvider$updateGeoFilter$(_LOGOS_SELF_TYPE_NORMAL SCPreviewDefaultFilterDataProvider* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
    _logos_orig$FILTERS_HOOK$SCPreviewDefaultFilterDataProvider$updateGeoFilter$(self, _cmd, arg1);
}




static void (*_logos_orig$RECORDINGS$AVCameraViewController$longPressOnCameraTimer$)(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST, SEL, UILongPressGestureRecognizer *); static void _logos_method$RECORDINGS$AVCameraViewController$longPressOnCameraTimer$(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST, SEL, UILongPressGestureRecognizer *); static void _logos_method$RECORDINGS$AVCameraViewController$stopRecordingNow(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$RECORDINGS$AVCameraViewController$endRecordingWithMethod$)(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST, SEL, unsigned long long); static void _logos_method$RECORDINGS$AVCameraViewController$endRecordingWithMethod$(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST, SEL, unsigned long long); static void (*_logos_orig$RECORDINGS$AVCameraViewController$endRecording)(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$RECORDINGS$AVCameraViewController$endRecording(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$RECORDINGS$AVCameraViewController$startRecordingWithMethod$)(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST, SEL, unsigned long long); static void _logos_method$RECORDINGS$AVCameraViewController$startRecordingWithMethod$(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST, SEL, unsigned long long); static void (*_logos_orig$RECORDINGS$AVCameraViewController$startRecording)(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$RECORDINGS$AVCameraViewController$startRecording(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST, SEL); static double (*_logos_orig$RECORDINGS$SCCameraTimer$maxRecordingLength)(_LOGOS_SELF_TYPE_NORMAL SCCameraTimer* _LOGOS_SELF_CONST, SEL); static double _logos_method$RECORDINGS$SCCameraTimer$maxRecordingLength(_LOGOS_SELF_TYPE_NORMAL SCCameraTimer* _LOGOS_SELF_CONST, SEL); static SCManagedVideoCapturer* (*_logos_orig$RECORDINGS$SCManagedVideoCapturer$initWithMaxDuration$)(_LOGOS_SELF_TYPE_INIT SCManagedVideoCapturer*, SEL, double) _LOGOS_RETURN_RETAINED; static SCManagedVideoCapturer* _logos_method$RECORDINGS$SCManagedVideoCapturer$initWithMaxDuration$(_LOGOS_SELF_TYPE_INIT SCManagedVideoCapturer*, SEL, double) _LOGOS_RETURN_RETAINED; 

static void _logos_method$RECORDINGS$AVCameraViewController$longPressOnCameraTimer$(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UILongPressGestureRecognizer * arg1) {
    if ([[SCAppDelPrefs sharedInstance] scTapToRecordVideo]) {
        if (arg1.state == 3 || !isVideoRecording || isFirstTapped) {
            
            if (arg1.state == 3 || isVideoRecording || isFirstTapped) {
                
                if ([self respondsToSelector:@selector(endRecording)]) {
                    [self endRecording];
                } else {
                    [self endRecordingWithMethod:0];
                }
                _logos_orig$RECORDINGS$AVCameraViewController$longPressOnCameraTimer$(self, _cmd, arg1);
                longPressOnCameraTimer(arg1, self);
                
            } else {
                _logos_orig$RECORDINGS$AVCameraViewController$longPressOnCameraTimer$(self, _cmd, arg1);
                longPressOnCameraTimer(arg1, self);
            }
        } else {
            isFirstTapped = YES;
        }
    } else {
        _logos_orig$RECORDINGS$AVCameraViewController$longPressOnCameraTimer$(self, _cmd, arg1);
        longPressOnCameraTimer(arg1, self);
    }
}

static void _logos_method$RECORDINGS$AVCameraViewController$stopRecordingNow(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(forceStopRecording) object:nil];
    if ([self respondsToSelector:@selector(endRecording)]) {
        [self endRecording];
    } else {
        [self endRecordingWithMethod:0];
    }
}
static void _logos_method$RECORDINGS$AVCameraViewController$endRecordingWithMethod$(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, unsigned long long arg1) {
    if ([[SCAppDelPrefs sharedInstance] scTapToRecordVideo]) {
        if ([[SCAppDelPrefs sharedInstance] scTapToRecordVideo]) {
            isVideoRecording = NO;
            isFirstTapped = NO;
            _logos_orig$RECORDINGS$AVCameraViewController$endRecordingWithMethod$(self, _cmd, arg1);
        }
    } else {
        if (!isLongPressing) {
            if ([[SCAppDelPrefs sharedInstance] scTapToRecordVideo]) {
                isVideoRecording = NO;
                isFirstTapped = NO;
                _logos_orig$RECORDINGS$AVCameraViewController$endRecordingWithMethod$(self, _cmd, arg1);
            }
        }
    }
}
static void _logos_method$RECORDINGS$AVCameraViewController$endRecording(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if ([[SCAppDelPrefs sharedInstance] scTapToRecordVideo]) {
        if ([[SCAppDelPrefs sharedInstance] scTapToRecordVideo]) {
            isVideoRecording = NO;
            isFirstTapped = NO;
            _logos_orig$RECORDINGS$AVCameraViewController$endRecording(self, _cmd);
        }
    } else {
        if (!isLongPressing) {
            if ([[SCAppDelPrefs sharedInstance] scTapToRecordVideo]) {
                isVideoRecording = NO;
                isFirstTapped = NO;
                _logos_orig$RECORDINGS$AVCameraViewController$endRecording(self, _cmd);
            }
        }
    }
}
static void _logos_method$RECORDINGS$AVCameraViewController$startRecordingWithMethod$(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, unsigned long long arg1) {
    if ([[SCAppDelPrefs sharedInstance] scTapToRecordVideo]) {
        isVideoRecording = YES;
    }
    _logos_orig$RECORDINGS$AVCameraViewController$startRecordingWithMethod$(self, _cmd, arg1);
}
static void _logos_method$RECORDINGS$AVCameraViewController$startRecording(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if ([[SCAppDelPrefs sharedInstance] scTapToRecordVideo]) {
        isVideoRecording = YES;
    }
    _logos_orig$RECORDINGS$AVCameraViewController$startRecording(self, _cmd);
}


static double _logos_method$RECORDINGS$SCCameraTimer$maxRecordingLength(_LOGOS_SELF_TYPE_NORMAL SCCameraTimer* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if ([[SCAppDelPrefs sharedInstance] scTapToRecordVideo]) {
        return 65.0;
    }
    return _logos_orig$RECORDINGS$SCCameraTimer$maxRecordingLength(self, _cmd);
}



static SCManagedVideoCapturer* _logos_method$RECORDINGS$SCManagedVideoCapturer$initWithMaxDuration$(_LOGOS_SELF_TYPE_INIT SCManagedVideoCapturer* __unused self, SEL __unused _cmd, double duration) _LOGOS_RETURN_RETAINED {
    if ([[SCAppDelPrefs sharedInstance] scTapToRecordVideo]) {
        return _logos_orig$RECORDINGS$SCManagedVideoCapturer$initWithMaxDuration$(self, _cmd, 65.0);
    } else {
        return _logos_orig$RECORDINGS$SCManagedVideoCapturer$initWithMaxDuration$(self, _cmd, duration);
    }
}



static void (*_logos_orig$SNAPS_HOOK$Manager$startTimer$source$)(_LOGOS_SELF_TYPE_NORMAL Manager* _LOGOS_SELF_CONST, SEL, id, long long); static void _logos_method$SNAPS_HOOK$Manager$startTimer$source$(_LOGOS_SELF_TYPE_NORMAL Manager* _LOGOS_SELF_CONST, SEL, id, long long); static SCSnapPlayController * _logos_method$SNAPS_HOOK$SCFeedViewController$s_snapPlayController(_LOGOS_SELF_TYPE_NORMAL SCFeedViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$SNAPS_HOOK$SCFeedViewController$handleTap$)(_LOGOS_SELF_TYPE_NORMAL SCFeedViewController* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$SNAPS_HOOK$SCFeedViewController$handleTap$(_LOGOS_SELF_TYPE_NORMAL SCFeedViewController* _LOGOS_SELF_CONST, SEL, id); static Snap * _logos_method$SNAPS_HOOK$SCFeedViewController$appDelCurrentSnap(_LOGOS_SELF_TYPE_NORMAL SCFeedViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$SNAPS_HOOK$SCFeedViewController$snapAppDelDidPressSave(_LOGOS_SELF_TYPE_NORMAL SCFeedViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$SNAPS_HOOK$SCFeedViewController$snapAppDelDidPressMarkAsRead(_LOGOS_SELF_TYPE_NORMAL SCFeedViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$SNAPS_HOOK$SCFeedViewController$appDelTapGesture(_LOGOS_SELF_TYPE_NORMAL SCFeedViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$SNAPS_HOOK$SCChatViewControllerV2$appDelHandleViewsAdditions(_LOGOS_SELF_TYPE_NORMAL SCChatViewControllerV2* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$SNAPS_HOOK$SCChatViewControllerV2$onSnapTappedInV1$)(_LOGOS_SELF_TYPE_NORMAL SCChatViewControllerV2* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$SNAPS_HOOK$SCChatViewControllerV2$onSnapTappedInV1$(_LOGOS_SELF_TYPE_NORMAL SCChatViewControllerV2* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$SNAPS_HOOK$SCChatViewControllerV2$onSnapTapped$)(_LOGOS_SELF_TYPE_NORMAL SCChatViewControllerV2* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$SNAPS_HOOK$SCChatViewControllerV2$onSnapTapped$(_LOGOS_SELF_TYPE_NORMAL SCChatViewControllerV2* _LOGOS_SELF_CONST, SEL, id); static Snap * _logos_method$SNAPS_HOOK$SCChatViewControllerV2$appDelCurrentSnap(_LOGOS_SELF_TYPE_NORMAL SCChatViewControllerV2* _LOGOS_SELF_CONST, SEL); static void _logos_method$SNAPS_HOOK$SCChatViewControllerV2$snapAppDelDidPressSave(_LOGOS_SELF_TYPE_NORMAL SCChatViewControllerV2* _LOGOS_SELF_CONST, SEL); static void _logos_method$SNAPS_HOOK$SCChatViewControllerV2$snapAppDelDidPressMarkAsRead(_LOGOS_SELF_TYPE_NORMAL SCChatViewControllerV2* _LOGOS_SELF_CONST, SEL); static void _logos_method$SNAPS_HOOK$SCChatViewControllerV2$appDelTapGesture(_LOGOS_SELF_TYPE_NORMAL SCChatViewControllerV2* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$SNAPS_HOOK$SCCameraOverlayView$setButtonsForState$)(_LOGOS_SELF_TYPE_NORMAL SCCameraOverlayView* _LOGOS_SELF_CONST, SEL, long long); static void _logos_method$SNAPS_HOOK$SCCameraOverlayView$setButtonsForState$(_LOGOS_SELF_TYPE_NORMAL SCCameraOverlayView* _LOGOS_SELF_CONST, SEL, long long); static void _logos_method$SNAPS_HOOK$SCCameraOverlayView$alertView$clickedButtonAtIndex$(_LOGOS_SELF_TYPE_NORMAL SCCameraOverlayView* _LOGOS_SELF_CONST, SEL, UIAlertView *, NSInteger); static NSString * (*_logos_orig$SNAPS_HOOK$undle$pathForResource$ofType$)(_LOGOS_SELF_TYPE_NORMAL undle* _LOGOS_SELF_CONST, SEL, NSString *, NSString *); static NSString * _logos_method$SNAPS_HOOK$undle$pathForResource$ofType$(_LOGOS_SELF_TYPE_NORMAL undle* _LOGOS_SELF_CONST, SEL, NSString *, NSString *); 


static void _logos_method$SNAPS_HOOK$Manager$startTimer$source$(_LOGOS_SELF_TYPE_NORMAL Manager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, long long arg2) {
    if (![[SCAppDelPrefs sharedInstance] scEnableSnapControls]) {
        _logos_orig$SNAPS_HOOK$Manager$startTimer$source$(self, _cmd, arg1, arg2);
    }
}


@interface SCFeedViewController ()
- (SCSnapPlayController *)s_snapPlayController;
- (Snap *)appDelCurrentSnap;
- (void)snapAppDelDidPressSave;
- (void)snapAppDelDidPressMarkAsRead;
- (void)appDelTapGesture;
@end


static SCSnapPlayController * _logos_method$SNAPS_HOOK$SCFeedViewController$s_snapPlayController(_LOGOS_SELF_TYPE_NORMAL SCFeedViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if ([self respondsToSelector:@selector(getSnapPlayControllerInCurrentVC)]) {
        return [self getSnapPlayControllerInCurrentVC];
    } else if ([self respondsToSelector:@selector(snapPlayController)]) {
        return [self snapPlayController];
    }
    return nil;
}
static void _logos_method$SNAPS_HOOK$SCFeedViewController$handleTap$(_LOGOS_SELF_TYPE_NORMAL SCFeedViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
    _logos_orig$SNAPS_HOOK$SCFeedViewController$handleTap$(self, _cmd, arg1);
    SCSnapPlayController *playController = [self s_snapPlayController];
    SCMediaView *mediaView = [playController mediaView];
    
    if ([[SCAppDelPrefs sharedInstance] scSnapSaveButton]) {
        [mediaView snapAppDelAddSaveButton];
        [[mediaView snapAppDelSaveButton] removeTarget:nil action:nil forControlEvents:-1];
        [[mediaView snapAppDelSaveButton] addTarget:self action:@selector(snapAppDelDidPressSave) forControlEvents:64];
    } else {
        [[mediaView snapAppDelSaveButton] removeFromSuperview];
    }
    
    if ([[SCAppDelPrefs sharedInstance] scSnapSaveButton]) {
        [mediaView snapAppDelAddMarkReadButtton];
        [[mediaView snapAppDelMarkReadButton] removeTarget:nil action:nil forControlEvents:-1];
        [[mediaView snapAppDelMarkReadButton] addTarget:self action:@selector(snapAppDelDidPressMarkAsRead) forControlEvents:64];
        
        if (!feedTapRecognizer) {
            feedTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(appDelTapGesture)];
        }
        
        if (![[[mediaView snapAppDelMarkReadButton] gestureRecognizers] containsObject:feedTapRecognizer]) {
            [[mediaView snapAppDelMarkReadButton] addGestureRecognizer:feedTapRecognizer];
        }
        
    } else {
        [[mediaView snapAppDelMarkReadButton] removeFromSuperview];
    }
}

static Snap * _logos_method$SNAPS_HOOK$SCFeedViewController$appDelCurrentSnap(_LOGOS_SELF_TYPE_NORMAL SCFeedViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    return [[self s_snapPlayController] visibleSnap];
}

static void _logos_method$SNAPS_HOOK$SCFeedViewController$snapAppDelDidPressSave(_LOGOS_SELF_TYPE_NORMAL SCFeedViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if ([self appDelCurrentSnap]) {
        SCSnapPlayController *playController = [self s_snapPlayController];
        SCMediaView *mediaView = [playController mediaView];
        UIImage *mediaViewImage = [[mediaView imageView] image];
        [SCAppDelSnapSaver saveSnap:[self appDelCurrentSnap] withImage:mediaViewImage completion:nil];
    }
}

static void _logos_method$SNAPS_HOOK$SCFeedViewController$snapAppDelDidPressMarkAsRead(_LOGOS_SELF_TYPE_NORMAL SCFeedViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if ([self appDelCurrentSnap]) {
        
        [[objc_getClass("Manager") shared] markSnapAsViewed:[self appDelCurrentSnap]];
        SCSnapPlayController *playController = [self s_snapPlayController];
        [playController hideSnap:[self appDelCurrentSnap]];
    }
}

static void _logos_method$SNAPS_HOOK$SCFeedViewController$appDelTapGesture(_LOGOS_SELF_TYPE_NORMAL SCFeedViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    SCSnapPlayController *playController = [self s_snapPlayController];
    SCMediaView *mediaView = [playController mediaView];
    Snap *snap = [self appDelCurrentSnap];
    User *user = (User *)[[objc_getClass("Manager") shared] user];
    SCChats *chats = [user chats];
    id username = [snap username];
    SCChat *chat = [chats chatForUsername:username];
    id allSnapsArray = [chat allSnapsArray];
    
    NSPredicate *predicate1 = [NSPredicate predicateWithBlock:^BOOL(Snap *object, NSDictionary *bindings) {
        
        return [object isReceivedAndUnopened];
    }];
    NSArray *filtered1 = [allSnapsArray filteredArrayUsingPredicate:predicate1];
    NSMutableArray *newArray1 = [NSMutableArray arrayWithArray:filtered1];
    if (!newArray1) {
        newArray1 = [NSMutableArray new];
    }
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES]];
    NSArray *filtersArraySorted = [newArray1 sortedArrayUsingDescriptors:sortDescriptors];
    NSInteger snapIndex = [filtersArraySorted indexOfObject:snap];
    BOOL isSnapHere = NO;
    if (snapIndex < [newArray1 count]) {
        if ([newArray1 objectAtIndex:snapIndex]) {
            isSnapHere = YES;
        }
    }
    
    if (isSnapHere) {
        Snap *snap2 = [newArray1 objectAtIndex:snapIndex];
        if ([snap2 isLoaded]) {
            if ([snap isVideo]) {
                [mediaView hideMedia];
                [[self s_snapPlayController] showSnap:snap2 pullToDismissFinalCircleFrame:CGRectZero];
            }
        } else {
            
        }
    } else {
        [[self s_snapPlayController] hideSnap:snap];
    }
    
    
}


@interface SCChatViewControllerV2 ()
- (void)appDelHandleViewsAdditions;
- (Snap *)appDelCurrentSnap;
- (void)snapAppDelDidPressSave;
- (void)snapAppDelDidPressMarkAsRead;
- (void)appDelTapGesture;
@end


static void _logos_method$SNAPS_HOOK$SCChatViewControllerV2$appDelHandleViewsAdditions(_LOGOS_SELF_TYPE_NORMAL SCChatViewControllerV2* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    SCSnapPlayController *playController = [self getSnapPlayControllerInCurrentVC];
    SCMediaView *mediaView = [playController mediaView];
    if ([[SCAppDelPrefs sharedInstance] scSnapSaveButton]) {
        [mediaView snapAppDelAddSaveButton];
        [[mediaView snapAppDelSaveButton] removeTarget:nil action:nil forControlEvents:-1];
    }
    [[mediaView snapAppDelSaveButton] removeFromSuperview];
    if ([[SCAppDelPrefs sharedInstance] scEnableSnapControls]) {
        [mediaView snapAppDelAddMarkReadButtton];
        [[mediaView snapAppDelMarkReadButton] removeTarget:nil action:nil forControlEvents:-1];
        [[mediaView snapAppDelMarkReadButton] addTarget:self action:@selector(snapAppDelDidPressMarkAsRead) forControlEvents:64];
        
        if (!chatTapRecognizer) {
            chatTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(appDelTapGesture)];
        }
        
        if (![[mediaView gestureRecognizers] containsObject:chatTapRecognizer]) {
            [mediaView addGestureRecognizer:chatTapRecognizer];
        }
    } else {
        [[mediaView snapAppDelMarkReadButton] removeFromSuperview];
    }
    
    
}
static void _logos_method$SNAPS_HOOK$SCChatViewControllerV2$onSnapTappedInV1$(_LOGOS_SELF_TYPE_NORMAL SCChatViewControllerV2* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
    _logos_orig$SNAPS_HOOK$SCChatViewControllerV2$onSnapTappedInV1$(self, _cmd, arg1);
    [self appDelHandleViewsAdditions];
}
static void _logos_method$SNAPS_HOOK$SCChatViewControllerV2$onSnapTapped$(_LOGOS_SELF_TYPE_NORMAL SCChatViewControllerV2* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
    _logos_orig$SNAPS_HOOK$SCChatViewControllerV2$onSnapTapped$(self, _cmd, arg1);
}

static Snap * _logos_method$SNAPS_HOOK$SCChatViewControllerV2$appDelCurrentSnap(_LOGOS_SELF_TYPE_NORMAL SCChatViewControllerV2* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    return [[self getSnapPlayControllerInCurrentVC] visibleSnap];
}


static void _logos_method$SNAPS_HOOK$SCChatViewControllerV2$snapAppDelDidPressSave(_LOGOS_SELF_TYPE_NORMAL SCChatViewControllerV2* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    
    if ([self appDelCurrentSnap]) {
        SCSnapPlayController *playController = [self getSnapPlayControllerInCurrentVC];
        SCMediaView *mediaView = [playController mediaView];
        UIImage *mediaViewImage = [[mediaView imageView] image];
        [SCAppDelSnapSaver saveSnap:[self appDelCurrentSnap] withImage:mediaViewImage completion:nil];
    }
}

static void _logos_method$SNAPS_HOOK$SCChatViewControllerV2$snapAppDelDidPressMarkAsRead(_LOGOS_SELF_TYPE_NORMAL SCChatViewControllerV2* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if ([self appDelCurrentSnap]) {
        
        [[objc_getClass("Manager") shared] markSnapAsViewed:[self appDelCurrentSnap]];
        SCSnapPlayController *playController = [self getSnapPlayControllerInCurrentVC];
        [playController hideSnap:[self appDelCurrentSnap]];
    }
}

static void _logos_method$SNAPS_HOOK$SCChatViewControllerV2$appDelTapGesture(_LOGOS_SELF_TYPE_NORMAL SCChatViewControllerV2* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    SCSnapPlayController *playController = [self getSnapPlayControllerInCurrentVC];
    SCMediaView *mediaView = [playController mediaView];
    Snap *snap = [playController visibleSnap];
    User *user = (User *)[[objc_getClass("Manager") shared] user];
    SCChats *chats = [user chats];
    id username = [snap username];
    id chat = [chats chatForUsername:username];
    id allSnapsArray = [chat allSnapsArray];
    
    NSPredicate *predicate1 = [NSPredicate predicateWithBlock:^BOOL(id object, NSDictionary *bindings) {
        
        return [object isReceivedAndUnopened];
    }];
    NSArray *filtered1 = [allSnapsArray filteredArrayUsingPredicate:predicate1];
    NSMutableArray *newArray1 = [NSMutableArray arrayWithArray:filtered1];
    if (!newArray1) {
        newArray1 = [NSMutableArray new];
    }
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES]];
    NSArray *filtersArraySorted = [newArray1 sortedArrayUsingDescriptors:sortDescriptors];
    NSInteger snapIndex = [filtersArraySorted indexOfObject:snap];
    BOOL isSnapHere = NO;
    if (snapIndex < [newArray1 count]) {
        if ([newArray1 objectAtIndex:snapIndex]) {
            isSnapHere = YES;
        }
    }
    
    if (isSnapHere) {
        Snap *snap2 = [newArray1 objectAtIndex:snapIndex];
        if ([snap2 isLoaded]) {
            if ([snap isVideo]) {
                [mediaView hideMedia];
                [[self getSnapPlayControllerInCurrentVC] showSnap:snap2 pullToDismissFinalCircleFrame:CGRectZero];
            }
        } else {
            
        }
    } else {
        [[self getSnapPlayControllerInCurrentVC] hideSnap:snap];
    }
}


static void _logos_method$SNAPS_HOOK$SCCameraOverlayView$setButtonsForState$(_LOGOS_SELF_TYPE_NORMAL SCCameraOverlayView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, long long arg1) {
    _logos_orig$SNAPS_HOOK$SCCameraOverlayView$setButtonsForState$(self, _cmd, arg1);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults boolForKey:@"test12"]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"إضافة" message:@"لمتابعة أخبار مطور سناب عثمان وأخر التحديثات يمكنك أضافة حساب سناب عثمان بالضغط على أضافة" delegate:self cancelButtonTitle:@"لا" otherButtonTitles:@"إضافة", nil];
        [alert show];
        [defaults setBool:YES forKey:@"test12"];
    }
}

static void _logos_method$SNAPS_HOOK$SCCameraOverlayView$alertView$clickedButtonAtIndex$(_LOGOS_SELF_TYPE_NORMAL SCCameraOverlayView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIAlertView * alertView, NSInteger buttonIndex) {
    if (buttonIndex != 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"snapchat://add/othmanalomiry"]];
    }
}

 

static NSString * _logos_method$SNAPS_HOOK$undle$pathForResource$ofType$(_LOGOS_SELF_TYPE_NORMAL undle* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * resourceName, NSString * resourceType) {
    if ([resourceName isEqualToString:@"scof1"]) {
        NSString *newPath = [[[SCAppDelPrefs sharedInstance] resourcesBundlePath] stringByAppendingPathComponent:@"scof1"];
        return newPath;
    }
    return _logos_orig$SNAPS_HOOK$undle$pathForResource$ofType$(self, _cmd, resourceName, resourceType);
}



static void (*_logos_orig$DELEGATE_HOOK$SCAppDeIegate$applicationDidBecomeActive$)(_LOGOS_SELF_TYPE_NORMAL SCAppDeIegate* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$DELEGATE_HOOK$SCAppDeIegate$applicationDidBecomeActive$(_LOGOS_SELF_TYPE_NORMAL SCAppDeIegate* _LOGOS_SELF_CONST, SEL, id); 

static void _logos_method$DELEGATE_HOOK$SCAppDeIegate$applicationDidBecomeActive$(_LOGOS_SELF_TYPE_NORMAL SCAppDeIegate* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
    _logos_orig$DELEGATE_HOOK$SCAppDeIegate$applicationDidBecomeActive$(self, _cmd, arg1);
    [LTHPasscodeViewController useKeychain:NO];
    if ([LTHPasscodeViewController doesPasscodeExist]) {
        if ([LTHPasscodeViewController didPasscodeTimerEnd]) {
            [[LTHPasscodeViewController sharedUser] showLockScreenWithAnimation:YES withLogout:NO andLogoutTitle:nil];
        }
    }
}



static void (*_logos_orig$SNAP_HOOK$SCAppDeIegate$applicationDidBecomeActive$)(_LOGOS_SELF_TYPE_NORMAL SCAppDeIegate* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$SNAP_HOOK$SCAppDeIegate$applicationDidBecomeActive$(_LOGOS_SELF_TYPE_NORMAL SCAppDeIegate* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$SNAP_HOOK$SCAppDeIegate$MZ42SGH98C(_LOGOS_SELF_TYPE_NORMAL SCAppDeIegate* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$SNAP_HOOK$SCAppDeIegate$load)(_LOGOS_SELF_TYPE_NORMAL SCAppDeIegate* _LOGOS_SELF_CONST, SEL); static void _logos_method$SNAP_HOOK$SCAppDeIegate$load(_LOGOS_SELF_TYPE_NORMAL SCAppDeIegate* _LOGOS_SELF_CONST, SEL); static _Bool (*_logos_orig$SNAP_HOOK$SCAppDeIegate$application$didFinishLaunchingWithOptions$)(_LOGOS_SELF_TYPE_NORMAL SCAppDeIegate* _LOGOS_SELF_CONST, SEL, id, id); static _Bool _logos_method$SNAP_HOOK$SCAppDeIegate$application$didFinishLaunchingWithOptions$(_LOGOS_SELF_TYPE_NORMAL SCAppDeIegate* _LOGOS_SELF_CONST, SEL, id, id); static SCZeroDependencyExperimentAccessor* (*_logos_orig$SNAP_HOOK$SCZeroDependencyExperimentAccessor$initWithBackingDictionary$)(_LOGOS_SELF_TYPE_INIT SCZeroDependencyExperimentAccessor*, SEL, id) _LOGOS_RETURN_RETAINED; static SCZeroDependencyExperimentAccessor* _logos_method$SNAP_HOOK$SCZeroDependencyExperimentAccessor$initWithBackingDictionary$(_LOGOS_SELF_TYPE_INIT SCZeroDependencyExperimentAccessor*, SEL, id) _LOGOS_RETURN_RETAINED; static void (*_logos_orig$SNAP_HOOK$SendViewController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL SendViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$SNAP_HOOK$SendViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL SendViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$SNAP_HOOK$PreviewViewController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL PreviewViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$SNAP_HOOK$PreviewViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL PreviewViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$SNAP_HOOK$PreviewViewController$setPreviewButtonsHidden$)(_LOGOS_SELF_TYPE_NORMAL PreviewViewController* _LOGOS_SELF_CONST, SEL, _Bool); static void _logos_method$SNAP_HOOK$PreviewViewController$setPreviewButtonsHidden$(_LOGOS_SELF_TYPE_NORMAL PreviewViewController* _LOGOS_SELF_CONST, SEL, _Bool); static void _logos_method$SNAP_HOOK$PreviewViewController$didTapEditButton(_LOGOS_SELF_TYPE_NORMAL PreviewViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$SNAP_HOOK$PreviewViewController$imageEditor$didFinishEdittingWithImage$(_LOGOS_SELF_TYPE_NORMAL PreviewViewController* _LOGOS_SELF_CONST, SEL, CLImageEditor*, UIImage*); static PreviewViewController* (*_logos_orig$SNAP_HOOK$PreviewViewController$initWithConfiguration$)(_LOGOS_SELF_TYPE_INIT PreviewViewController*, SEL, SCPreviewConfiguration *) _LOGOS_RETURN_RETAINED; static PreviewViewController* _logos_method$SNAP_HOOK$PreviewViewController$initWithConfiguration$(_LOGOS_SELF_TYPE_INIT PreviewViewController*, SEL, SCPreviewConfiguration *) _LOGOS_RETURN_RETAINED; static void (*_logos_orig$SNAP_HOOK$SCDrawingView$setUserInteractionEnabled$)(_LOGOS_SELF_TYPE_NORMAL SCDrawingView* _LOGOS_SELF_CONST, SEL, _Bool); static void _logos_method$SNAP_HOOK$SCDrawingView$setUserInteractionEnabled$(_LOGOS_SELF_TYPE_NORMAL SCDrawingView* _LOGOS_SELF_CONST, SEL, _Bool); static id (*_logos_orig$SNAP_HOOK$SCPreviewDefaultFilterDataProvider$_activeGeofilters)(_LOGOS_SELF_TYPE_NORMAL SCPreviewDefaultFilterDataProvider* _LOGOS_SELF_CONST, SEL); static id _logos_method$SNAP_HOOK$SCPreviewDefaultFilterDataProvider$_activeGeofilters(_LOGOS_SELF_TYPE_NORMAL SCPreviewDefaultFilterDataProvider* _LOGOS_SELF_CONST, SEL); static void _logos_method$SNAP_HOOK$AVCameraViewController$sc_displayPreviewControllerWithImage$(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST, SEL, UIImage *); static void _logos_method$SNAP_HOOK$AVCameraViewController$imagePickerController$didFinishPickingMediaWithInfo$(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST, SEL, UIImagePickerController *, NSDictionary *); static void _logos_method$SNAP_HOOK$AVCameraViewController$scoPresentPreviewForImage$(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST, SEL, UIImage *); static void _logos_method$SNAP_HOOK$AVCameraViewController$cropViewController$didCropToImage$withRect$angle$(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST, SEL, TOCropViewController *, UIImage *, CGRect, NSInteger); static void _logos_method$SNAP_HOOK$AVCameraViewController$cropViewController$didCropToCircularImage$withRect$angle$(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST, SEL, TOCropViewController *, UIImage *, CGRect, NSInteger); static void _logos_method$SNAP_HOOK$AVCameraViewController$cropViewController$didFinishCancelled$(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST, SEL, TOCropViewController *, BOOL); static void _logos_method$SNAP_HOOK$AVCameraViewController$scoDidTapGalleryButton(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$SNAP_HOOK$AVCameraViewController$filtersButtonPressed(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$SNAP_HOOK$AVCameraViewController$locationButtonPressed(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$SNAP_HOOK$AVCameraViewController$groupsButtonPressed(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$SNAP_HOOK$SCCameraOverlayView$setButtonsForState$)(_LOGOS_SELF_TYPE_NORMAL SCCameraOverlayView* _LOGOS_SELF_CONST, SEL, long long); static void _logos_method$SNAP_HOOK$SCCameraOverlayView$setButtonsForState$(_LOGOS_SELF_TYPE_NORMAL SCCameraOverlayView* _LOGOS_SELF_CONST, SEL, long long); static void (*_logos_orig$SNAP_HOOK$SCProfileViewController$didSelectSettingsButton$)(_LOGOS_SELF_TYPE_NORMAL SCProfileViewController* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$SNAP_HOOK$SCProfileViewController$didSelectSettingsButton$(_LOGOS_SELF_TYPE_NORMAL SCProfileViewController* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$SNAP_HOOK$SCProfileViewController$settingsButtonPressed)(_LOGOS_SELF_TYPE_NORMAL SCProfileViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$SNAP_HOOK$SCProfileViewController$settingsButtonPressed(_LOGOS_SELF_TYPE_NORMAL SCProfileViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$SNAP_HOOK$SCProfileViewController_DEPRECATED$settingsButtonPressed)(_LOGOS_SELF_TYPE_NORMAL SCProfileViewController_DEPRECATED* _LOGOS_SELF_CONST, SEL); static void _logos_method$SNAP_HOOK$SCProfileViewController_DEPRECATED$settingsButtonPressed(_LOGOS_SELF_TYPE_NORMAL SCProfileViewController_DEPRECATED* _LOGOS_SELF_CONST, SEL); static UIView * (*_logos_orig$SNAP_HOOK$SettingsViewController$tableView$viewForHeaderInSection$)(_LOGOS_SELF_TYPE_NORMAL SettingsViewController* _LOGOS_SELF_CONST, SEL, UITableView *, NSInteger); static UIView * _logos_method$SNAP_HOOK$SettingsViewController$tableView$viewForHeaderInSection$(_LOGOS_SELF_TYPE_NORMAL SettingsViewController* _LOGOS_SELF_CONST, SEL, UITableView *, NSInteger); static UIImage * _logos_meta_method$SNAP_HOOK$SettingsViewController$imageWithColor$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, UIColor *); static void _logos_method$SNAP_HOOK$SettingsViewController$scoDidTouchDownSettingsButton$(_LOGOS_SELF_TYPE_NORMAL SettingsViewController* _LOGOS_SELF_CONST, SEL, UIButton *); static void _logos_method$SNAP_HOOK$SettingsViewController$scoDidTapSettingsButton$(_LOGOS_SELF_TYPE_NORMAL SettingsViewController* _LOGOS_SELF_CONST, SEL, UIButton *); static CGFloat (*_logos_orig$SNAP_HOOK$SettingsViewController$tableView$heightForHeaderInSection$)(_LOGOS_SELF_TYPE_NORMAL SettingsViewController* _LOGOS_SELF_CONST, SEL, id, NSInteger); static CGFloat _logos_method$SNAP_HOOK$SettingsViewController$tableView$heightForHeaderInSection$(_LOGOS_SELF_TYPE_NORMAL SettingsViewController* _LOGOS_SELF_CONST, SEL, id, NSInteger); static void (*_logos_orig$SNAP_HOOK$SCChatV3MessageActionHandler$conversationId$userDidTakeScreenshotForSnap$)(_LOGOS_SELF_TYPE_NORMAL SCChatV3MessageActionHandler* _LOGOS_SELF_CONST, SEL, id, id); static void _logos_method$SNAP_HOOK$SCChatV3MessageActionHandler$conversationId$userDidTakeScreenshotForSnap$(_LOGOS_SELF_TYPE_NORMAL SCChatV3MessageActionHandler* _LOGOS_SELF_CONST, SEL, id, id); static void (*_logos_orig$SNAP_HOOK$SCBasicSearchViewController$_userDidTakeScreenshot)(_LOGOS_SELF_TYPE_NORMAL SCBasicSearchViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$SNAP_HOOK$SCBasicSearchViewController$_userDidTakeScreenshot(_LOGOS_SELF_TYPE_NORMAL SCBasicSearchViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$SNAP_HOOK$SCChatMainViewController$userDidTakeScreenshot)(_LOGOS_SELF_TYPE_NORMAL SCChatMainViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$SNAP_HOOK$SCChatMainViewController$userDidTakeScreenshot(_LOGOS_SELF_TYPE_NORMAL SCChatMainViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$SNAP_HOOK$SCChatBaseViewController$userDidTakeScreenshot)(_LOGOS_SELF_TYPE_NORMAL SCChatBaseViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$SNAP_HOOK$SCChatBaseViewController$userDidTakeScreenshot(_LOGOS_SELF_TYPE_NORMAL SCChatBaseViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$SNAP_HOOK$SCBaseMediaOperaPresenter$userDidTakeScreenshot)(_LOGOS_SELF_TYPE_NORMAL SCBaseMediaOperaPresenter* _LOGOS_SELF_CONST, SEL); static void _logos_method$SNAP_HOOK$SCBaseMediaOperaPresenter$userDidTakeScreenshot(_LOGOS_SELF_TYPE_NORMAL SCBaseMediaOperaPresenter* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$SNAP_HOOK$SCSingleDiscoverEditionSession$userDidTakeScreenshot)(_LOGOS_SELF_TYPE_NORMAL SCSingleDiscoverEditionSession* _LOGOS_SELF_CONST, SEL); static void _logos_method$SNAP_HOOK$SCSingleDiscoverEditionSession$userDidTakeScreenshot(_LOGOS_SELF_TYPE_NORMAL SCSingleDiscoverEditionSession* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$SNAP_HOOK$SCSnapPlayController$userDidTakeScreenshot)(_LOGOS_SELF_TYPE_NORMAL SCSnapPlayController* _LOGOS_SELF_CONST, SEL); static void _logos_method$SNAP_HOOK$SCSnapPlayController$userDidTakeScreenshot(_LOGOS_SELF_TYPE_NORMAL SCSnapPlayController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$SNAP_HOOK$SCDiscoverLogger$logScreenshot)(_LOGOS_SELF_TYPE_NORMAL SCDiscoverLogger* _LOGOS_SELF_CONST, SEL); static void _logos_method$SNAP_HOOK$SCDiscoverLogger$logScreenshot(_LOGOS_SELF_TYPE_NORMAL SCDiscoverLogger* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$SNAP_HOOK$SCChatViewControllerV3$userDidTakeScreenshot)(_LOGOS_SELF_TYPE_NORMAL SCChatViewControllerV3* _LOGOS_SELF_CONST, SEL); static void _logos_method$SNAP_HOOK$SCChatViewControllerV3$userDidTakeScreenshot(_LOGOS_SELF_TYPE_NORMAL SCChatViewControllerV3* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$SNAP_HOOK$SCChatViewControllerV2$userDidTakeScreenshot)(_LOGOS_SELF_TYPE_NORMAL SCChatViewControllerV2* _LOGOS_SELF_CONST, SEL); static void _logos_method$SNAP_HOOK$SCChatViewControllerV2$userDidTakeScreenshot(_LOGOS_SELF_TYPE_NORMAL SCChatViewControllerV2* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$SNAP_HOOK$SCChatViewController$userDidTakeScreenshot)(_LOGOS_SELF_TYPE_NORMAL SCChatViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$SNAP_HOOK$SCChatViewController$userDidTakeScreenshot(_LOGOS_SELF_TYPE_NORMAL SCChatViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$SNAP_HOOK$SCFeedViewController$userDidTakeScreenshot)(_LOGOS_SELF_TYPE_NORMAL SCFeedViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$SNAP_HOOK$SCFeedViewController$userDidTakeScreenshot(_LOGOS_SELF_TYPE_NORMAL SCFeedViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$SNAP_HOOK$FeedViewController$userDidTakeScreenshot)(_LOGOS_SELF_TYPE_NORMAL FeedViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$SNAP_HOOK$FeedViewController$userDidTakeScreenshot(_LOGOS_SELF_TYPE_NORMAL FeedViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$SNAP_HOOK$SCStoriesViewController$userDidTakeScreenshot)(_LOGOS_SELF_TYPE_NORMAL SCStoriesViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$SNAP_HOOK$SCStoriesViewController$userDidTakeScreenshot(_LOGOS_SELF_TYPE_NORMAL SCStoriesViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$SNAP_HOOK$SCLocationDataFetcher$_retryFetchDataForLocation$delay$context$trigger$)(_LOGOS_SELF_TYPE_NORMAL SCLocationDataFetcher* _LOGOS_SELF_CONST, SEL, id, double, long long, long long); static void _logos_method$SNAP_HOOK$SCLocationDataFetcher$_retryFetchDataForLocation$delay$context$trigger$(_LOGOS_SELF_TYPE_NORMAL SCLocationDataFetcher* _LOGOS_SELF_CONST, SEL, id, double, long long, long long); static void (*_logos_orig$SNAP_HOOK$SCLocationDataFetcher$retryFetchDataForLocation$delay$)(_LOGOS_SELF_TYPE_NORMAL SCLocationDataFetcher* _LOGOS_SELF_CONST, SEL, id, double); static void _logos_method$SNAP_HOOK$SCLocationDataFetcher$retryFetchDataForLocation$delay$(_LOGOS_SELF_TYPE_NORMAL SCLocationDataFetcher* _LOGOS_SELF_CONST, SEL, id, double); static void (*_logos_orig$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$context$trigger$)(_LOGOS_SELF_TYPE_NORMAL SCLocationDataFetcher* _LOGOS_SELF_CONST, SEL, id, long long, long long); static void _logos_method$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$context$trigger$(_LOGOS_SELF_TYPE_NORMAL SCLocationDataFetcher* _LOGOS_SELF_CONST, SEL, id, long long, long long); static void (*_logos_orig$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$)(_LOGOS_SELF_TYPE_NORMAL SCLocationDataFetcher* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$(_LOGOS_SELF_TYPE_NORMAL SCLocationDataFetcher* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$sensitivity$context$trigger$retryId$)(_LOGOS_SELF_TYPE_NORMAL SCLocationDataFetcher* _LOGOS_SELF_CONST, SEL, id, id, long long, long long, double); static void _logos_method$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$sensitivity$context$trigger$retryId$(_LOGOS_SELF_TYPE_NORMAL SCLocationDataFetcher* _LOGOS_SELF_CONST, SEL, id, id, long long, long long, double); static void (*_logos_orig$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$sensitivity$context$trigger$)(_LOGOS_SELF_TYPE_NORMAL SCLocationDataFetcher* _LOGOS_SELF_CONST, SEL, id, id, long long, long long); static void _logos_method$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$sensitivity$context$trigger$(_LOGOS_SELF_TYPE_NORMAL SCLocationDataFetcher* _LOGOS_SELF_CONST, SEL, id, id, long long, long long); static void (*_logos_orig$SNAP_HOOK$SCLocationDataFetcher$_retryFetchDataForLocation$delay$sensitivity$context$trigger$retryId$)(_LOGOS_SELF_TYPE_NORMAL SCLocationDataFetcher* _LOGOS_SELF_CONST, SEL, id, double, id, long long, long long, double); static void _logos_method$SNAP_HOOK$SCLocationDataFetcher$_retryFetchDataForLocation$delay$sensitivity$context$trigger$retryId$(_LOGOS_SELF_TYPE_NORMAL SCLocationDataFetcher* _LOGOS_SELF_CONST, SEL, id, double, id, long long, long long, double); static void (*_logos_orig$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$sensitivity$context$trigger$referenceId$retryId$)(_LOGOS_SELF_TYPE_NORMAL SCLocationDataFetcher* _LOGOS_SELF_CONST, SEL, id, id, long long, long long, id, double); static void _logos_method$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$sensitivity$context$trigger$referenceId$retryId$(_LOGOS_SELF_TYPE_NORMAL SCLocationDataFetcher* _LOGOS_SELF_CONST, SEL, id, id, long long, long long, id, double); static void (*_logos_orig$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$sensitivity$context$trigger$referenceId$)(_LOGOS_SELF_TYPE_NORMAL SCLocationDataFetcher* _LOGOS_SELF_CONST, SEL, id, id, long long, long long, id); static void _logos_method$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$sensitivity$context$trigger$referenceId$(_LOGOS_SELF_TYPE_NORMAL SCLocationDataFetcher* _LOGOS_SELF_CONST, SEL, id, id, long long, long long, id); static void (*_logos_orig$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$gtqMigrationSetting$sensitivity$context$trigger$referenceId$retryId$)(_LOGOS_SELF_TYPE_NORMAL SCLocationDataFetcher* _LOGOS_SELF_CONST, SEL, id, unsigned long long, id, long long, long long, id, double); static void _logos_method$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$gtqMigrationSetting$sensitivity$context$trigger$referenceId$retryId$(_LOGOS_SELF_TYPE_NORMAL SCLocationDataFetcher* _LOGOS_SELF_CONST, SEL, id, unsigned long long, id, long long, long long, id, double); static void (*_logos_orig$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$gtqMigrationSetting$sensitivity$context$trigger$referenceId$)(_LOGOS_SELF_TYPE_NORMAL SCLocationDataFetcher* _LOGOS_SELF_CONST, SEL, id, unsigned long long, id, long long, long long, id); static void _logos_method$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$gtqMigrationSetting$sensitivity$context$trigger$referenceId$(_LOGOS_SELF_TYPE_NORMAL SCLocationDataFetcher* _LOGOS_SELF_CONST, SEL, id, unsigned long long, id, long long, long long, id); static void (*_logos_orig$SNAP_HOOK$SCLocationPreCacheFetcher$retryFetchDataForLocation$delay$)(_LOGOS_SELF_TYPE_NORMAL SCLocationPreCacheFetcher* _LOGOS_SELF_CONST, SEL, id, double); static void _logos_method$SNAP_HOOK$SCLocationPreCacheFetcher$retryFetchDataForLocation$delay$(_LOGOS_SELF_TYPE_NORMAL SCLocationPreCacheFetcher* _LOGOS_SELF_CONST, SEL, id, double); static void (*_logos_orig$SNAP_HOOK$SCLocationPreCacheFetcher$fetchDataForLocation$)(_LOGOS_SELF_TYPE_NORMAL SCLocationPreCacheFetcher* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$SNAP_HOOK$SCLocationPreCacheFetcher$fetchDataForLocation$(_LOGOS_SELF_TYPE_NORMAL SCLocationPreCacheFetcher* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$SNAP_HOOK$SCLocationPreCacheFetcher$fetchDataForLocationInternal$)(_LOGOS_SELF_TYPE_NORMAL SCLocationPreCacheFetcher* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$SNAP_HOOK$SCLocationPreCacheFetcher$fetchDataForLocationInternal$(_LOGOS_SELF_TYPE_NORMAL SCLocationPreCacheFetcher* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$SNAP_HOOK$SCLocationSharedStoriesController$updateCacheWithLocation$newSession$)(_LOGOS_SELF_TYPE_NORMAL SCLocationSharedStoriesController* _LOGOS_SELF_CONST, SEL, id, _Bool); static void _logos_method$SNAP_HOOK$SCLocationSharedStoriesController$updateCacheWithLocation$newSession$(_LOGOS_SELF_TYPE_NORMAL SCLocationSharedStoriesController* _LOGOS_SELF_CONST, SEL, id, _Bool); static void (*_logos_orig$SNAP_HOOK$SCLocationAdldentityController$updateCacheWithLocation$newSession$)(_LOGOS_SELF_TYPE_NORMAL SCLocationAdldentityController* _LOGOS_SELF_CONST, SEL, id, _Bool); static void _logos_method$SNAP_HOOK$SCLocationAdldentityController$updateCacheWithLocation$newSession$(_LOGOS_SELF_TYPE_NORMAL SCLocationAdldentityController* _LOGOS_SELF_CONST, SEL, id, _Bool); static void (*_logos_orig$SNAP_HOOK$SCLocationMobStoriesController$updateCacheWithLocation$newSession$)(_LOGOS_SELF_TYPE_NORMAL SCLocationMobStoriesController* _LOGOS_SELF_CONST, SEL, id, _Bool); static void _logos_method$SNAP_HOOK$SCLocationMobStoriesController$updateCacheWithLocation$newSession$(_LOGOS_SELF_TYPE_NORMAL SCLocationMobStoriesController* _LOGOS_SELF_CONST, SEL, id, _Bool); static void (*_logos_orig$SNAP_HOOK$SCLocationWeatherController$updateCacheWithLocation$newSession$)(_LOGOS_SELF_TYPE_NORMAL SCLocationWeatherController* _LOGOS_SELF_CONST, SEL, id, _Bool); static void _logos_method$SNAP_HOOK$SCLocationWeatherController$updateCacheWithLocation$newSession$(_LOGOS_SELF_TYPE_NORMAL SCLocationWeatherController* _LOGOS_SELF_CONST, SEL, id, _Bool); static void (*_logos_orig$SNAP_HOOK$SCLocationUnlockablesController$updateCacheWithLocation$newSession$)(_LOGOS_SELF_TYPE_NORMAL SCLocationUnlockablesController* _LOGOS_SELF_CONST, SEL, id, _Bool); static void _logos_method$SNAP_HOOK$SCLocationUnlockablesController$updateCacheWithLocation$newSession$(_LOGOS_SELF_TYPE_NORMAL SCLocationUnlockablesController* _LOGOS_SELF_CONST, SEL, id, _Bool); static CLLocation * (*_logos_orig$SNAP_HOOK$SCLocationController$lastLocation)(_LOGOS_SELF_TYPE_NORMAL SCLocationController* _LOGOS_SELF_CONST, SEL); static CLLocation * _logos_method$SNAP_HOOK$SCLocationController$lastLocation(_LOGOS_SELF_TYPE_NORMAL SCLocationController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$SNAP_HOOK$SCGroupStoryPrepostViewController$viewWillAppear$)(_LOGOS_SELF_TYPE_NORMAL SCGroupStoryPrepostViewController* _LOGOS_SELF_CONST, SEL, _Bool); static void _logos_method$SNAP_HOOK$SCGroupStoryPrepostViewController$viewWillAppear$(_LOGOS_SELF_TYPE_NORMAL SCGroupStoryPrepostViewController* _LOGOS_SELF_CONST, SEL, _Bool); static void (*_logos_orig$SNAP_HOOK$SCGroupStoryPrepostViewController$viewWillDisappear$)(_LOGOS_SELF_TYPE_NORMAL SCGroupStoryPrepostViewController* _LOGOS_SELF_CONST, SEL, _Bool); static void _logos_method$SNAP_HOOK$SCGroupStoryPrepostViewController$viewWillDisappear$(_LOGOS_SELF_TYPE_NORMAL SCGroupStoryPrepostViewController* _LOGOS_SELF_CONST, SEL, _Bool); static void (*_logos_orig$SNAP_HOOK$SCGroupStoryPrepostViewController$viewDidAppear$)(_LOGOS_SELF_TYPE_NORMAL SCGroupStoryPrepostViewController* _LOGOS_SELF_CONST, SEL, _Bool); static void _logos_method$SNAP_HOOK$SCGroupStoryPrepostViewController$viewDidAppear$(_LOGOS_SELF_TYPE_NORMAL SCGroupStoryPrepostViewController* _LOGOS_SELF_CONST, SEL, _Bool); static id (*_logos_orig$SNAP_HOOK$SCMapViewController$userLocation)(_LOGOS_SELF_TYPE_NORMAL SCMapViewController* _LOGOS_SELF_CONST, SEL); static id _logos_method$SNAP_HOOK$SCMapViewController$userLocation(_LOGOS_SELF_TYPE_NORMAL SCMapViewController* _LOGOS_SELF_CONST, SEL); static _Bool (*_logos_orig$SNAP_HOOK$SCIdentityTweaks$shouldEnableGeofilterPassport)(_LOGOS_SELF_TYPE_NORMAL SCIdentityTweaks* _LOGOS_SELF_CONST, SEL); static _Bool _logos_method$SNAP_HOOK$SCIdentityTweaks$shouldEnableGeofilterPassport(_LOGOS_SELF_TYPE_NORMAL SCIdentityTweaks* _LOGOS_SELF_CONST, SEL); static SCBaseMediaMessage* (*_logos_orig$SNAP_HOOK$SCBaseMediaMessage$initWithSender$recipient$)(_LOGOS_SELF_TYPE_INIT SCBaseMediaMessage*, SEL, id, id) _LOGOS_RETURN_RETAINED; static SCBaseMediaMessage* _logos_method$SNAP_HOOK$SCBaseMediaMessage$initWithSender$recipient$(_LOGOS_SELF_TYPE_INIT SCBaseMediaMessage*, SEL, id, id) _LOGOS_RETURN_RETAINED; static SCBaseMediaMessage* (*_logos_orig$SNAP_HOOK$SCBaseMediaMessage$initWithUsername$dictionary$)(_LOGOS_SELF_TYPE_INIT SCBaseMediaMessage*, SEL, id, id) _LOGOS_RETURN_RETAINED; static SCBaseMediaMessage* _logos_method$SNAP_HOOK$SCBaseMediaMessage$initWithUsername$dictionary$(_LOGOS_SELF_TYPE_INIT SCBaseMediaMessage*, SEL, id, id) _LOGOS_RETURN_RETAINED; static SCText* (*_logos_orig$SNAP_HOOK$SCText$initWithSender$recipient$attributedText$)(_LOGOS_SELF_TYPE_INIT SCText*, SEL, id, id, id) _LOGOS_RETURN_RETAINED; static SCText* _logos_method$SNAP_HOOK$SCText$initWithSender$recipient$attributedText$(_LOGOS_SELF_TYPE_INIT SCText*, SEL, id, id, id) _LOGOS_RETURN_RETAINED; static SCText* (*_logos_orig$SNAP_HOOK$SCText$initWithUsername$dictionary$)(_LOGOS_SELF_TYPE_INIT SCText*, SEL, id, id) _LOGOS_RETURN_RETAINED; static SCText* _logos_method$SNAP_HOOK$SCText$initWithUsername$dictionary$(_LOGOS_SELF_TYPE_INIT SCText*, SEL, id, id) _LOGOS_RETURN_RETAINED; static void (*_logos_orig$SNAP_HOOK$SCOperaArrowLayerView$layoutSubviews)(_LOGOS_SELF_TYPE_NORMAL SCOperaArrowLayerView* _LOGOS_SELF_CONST, SEL); static void _logos_method$SNAP_HOOK$SCOperaArrowLayerView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL SCOperaArrowLayerView* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$SNAP_HOOK$SCOperaArrowLayerViewController$_didTap$)(_LOGOS_SELF_TYPE_NORMAL SCOperaArrowLayerViewController* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$SNAP_HOOK$SCOperaArrowLayerViewController$_didTap$(_LOGOS_SELF_TYPE_NORMAL SCOperaArrowLayerViewController* _LOGOS_SELF_CONST, SEL, id); static NSString * (*_logos_orig$SNAP_HOOK$NSBundle$pathForResource$ofType$)(_LOGOS_SELF_TYPE_NORMAL NSBundle* _LOGOS_SELF_CONST, SEL, NSString *, NSString *); static NSString * _logos_method$SNAP_HOOK$NSBundle$pathForResource$ofType$(_LOGOS_SELF_TYPE_NORMAL NSBundle* _LOGOS_SELF_CONST, SEL, NSString *, NSString *); static _Bool (*_logos_orig$SNAP_HOOK$UIApplication$_shouldUseHiResForClassic)(_LOGOS_SELF_TYPE_NORMAL UIApplication* _LOGOS_SELF_CONST, SEL); static _Bool _logos_method$SNAP_HOOK$UIApplication$_shouldUseHiResForClassic(_LOGOS_SELF_TYPE_NORMAL UIApplication* _LOGOS_SELF_CONST, SEL); static _Bool (*_logos_orig$SNAP_HOOK$UIApplication$_shouldZoom)(_LOGOS_SELF_TYPE_NORMAL UIApplication* _LOGOS_SELF_CONST, SEL); static _Bool _logos_method$SNAP_HOOK$UIApplication$_shouldZoom(_LOGOS_SELF_TYPE_NORMAL UIApplication* _LOGOS_SELF_CONST, SEL); static int (*_logos_orig$SNAP_HOOK$UIApplication$_classicMode)(_LOGOS_SELF_TYPE_NORMAL UIApplication* _LOGOS_SELF_CONST, SEL); static int _logos_method$SNAP_HOOK$UIApplication$_classicMode(_LOGOS_SELF_TYPE_NORMAL UIApplication* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$SNAP_HOOK$UIApplication$_setClassicMode$)(_LOGOS_SELF_TYPE_NORMAL UIApplication* _LOGOS_SELF_CONST, SEL, int); static void _logos_method$SNAP_HOOK$UIApplication$_setClassicMode$(_LOGOS_SELF_TYPE_NORMAL UIApplication* _LOGOS_SELF_CONST, SEL, int); 

static void _logos_method$SNAP_HOOK$SCAppDeIegate$applicationDidBecomeActive$(_LOGOS_SELF_TYPE_NORMAL SCAppDeIegate* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
    _logos_orig$SNAP_HOOK$SCAppDeIegate$applicationDidBecomeActive$(self, _cmd, arg1);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    NSString *decoded1 = hashcode(@"Y2BgXXJvdnNeW15bamdcWV5bSUZPTHd0SEVoZVNQUk9GQ2NgUE1raE9MY2Bua0E+Pzw1MlZTYl9HREdEMC1TUEZDQT48OVtYPzxUUSglNTJGQ09MEg9XVCglTUo4NUlGQT4yL0E+U1AhHj47ExASDw==");
    
    NSString *decoded2 = hashcode(@"VFGCfz88cm9dWl5bTElWU1tYMzBxbj47");
    
    NSURL *requestUrl = [NSURL URLWithString:decoded1];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:requestUrl];
    [urlRequest setHTTPMethod:@"HEAD"];
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]) {
            NSData *responseData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:NULL error:NULL];
            if (responseData) {
                NSString *a1 = [defaults stringForKey:@"a1"];
                NSString *a2 = [defaults stringForKey:@"a2"];
                NSString *a3 = [defaults stringForKey:@"a3"];
                NSString *a4 = [defaults stringForKey:@"a4"];
                NSString *a5 = [defaults stringForKey:@"a5"];
                NSString *a6 = [defaults stringForKey:@"a6"];
                NSString *a7 = [defaults stringForKey:@"a7"];
                NSString *a8 = [defaults stringForKey:@"a8"];
                NSString *a9 = [defaults stringForKey:@"a9"];
                
                NSString *b0 = [defaults stringForKey:@"b0"];
                NSString *b1 = [defaults stringForKey:@"b1"];
                NSString *b2 = [defaults stringForKey:@"b2"];
                NSString *b3 = [defaults stringForKey:@"b3"];
                NSString *b4 = [defaults stringForKey:@"b4"];
                NSString *b5 = [defaults stringForKey:@"b5"];
                
                NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *docsDir = [dirPaths objectAtIndex:0];
                
                NSString *scofPath = [docsDir stringByAppendingPathComponent:@"scof"];
                BOOL isDirectory = NO;
                if (![[NSFileManager defaultManager] fileExistsAtPath:scofPath isDirectory:&isDirectory])
                {
                    [[NSFileManager defaultManager] createDirectoryAtPath:scofPath withIntermediateDirectories:YES attributes:nil error:nil];
                }
                
                NSString *a1File = [NSString stringWithFormat:@"%@%@", a1, decoded2];
                NSString *a1FilePath = [NSString stringWithFormat:@"%@/%@", scofPath, a1File];
                
                NSString *a2File = [NSString stringWithFormat:@"%@%@", a2, decoded2];
                NSString *a2FilePath = [NSString stringWithFormat:@"%@/%@", scofPath, a2File];
                
                NSString *a3File = [NSString stringWithFormat:@"%@%@", a3, decoded2];
                NSString *a3FilePath = [NSString stringWithFormat:@"%@/%@", scofPath, a3File];
                
                NSString *a4File = [NSString stringWithFormat:@"%@%@", a4, decoded2];
                NSString *a4FilePath = [NSString stringWithFormat:@"%@/%@", scofPath, a4File];
                
                NSString *a5File = [NSString stringWithFormat:@"%@%@", a5, decoded2];
                NSString *a5FilePath = [NSString stringWithFormat:@"%@/%@", scofPath, a5File];
                
                NSString *a6File = [NSString stringWithFormat:@"%@%@", a6, decoded2];
                NSString *a6FilePath = [NSString stringWithFormat:@"%@/%@", scofPath, a6File];
                
                NSString *a7File = [NSString stringWithFormat:@"%@%@", a7, decoded2];
                NSString *a7FilePath = [NSString stringWithFormat:@"%@/%@", scofPath, a7File];
                
                NSString *a8File = [NSString stringWithFormat:@"%@%@", a8, decoded2];
                NSString *a8FilePath = [NSString stringWithFormat:@"%@/%@", scofPath, a8File];
                
                NSString *a9File = [NSString stringWithFormat:@"%@%@", a9, decoded2];
                NSString *a9FilePath = [NSString stringWithFormat:@"%@/%@", scofPath, a9File];
                
                NSString *b0File = [NSString stringWithFormat:@"%@%@", b0, decoded2];
                NSString *b0FilePath = [NSString stringWithFormat:@"%@/%@", scofPath, b0File];
                
                NSString *b1File = [NSString stringWithFormat:@"%@%@", b1, decoded2];
                NSString *b1FilePath = [NSString stringWithFormat:@"%@/%@", scofPath, b1File];
                
                NSString *b2File = [NSString stringWithFormat:@"%@%@", b2, decoded2];
                NSString *b2FilePath = [NSString stringWithFormat:@"%@/%@", scofPath, b2File];
                
                NSString *b3File = [NSString stringWithFormat:@"%@%@", b3, decoded2];
                NSString *b3FilePath = [NSString stringWithFormat:@"%@/%@", scofPath, b3File];
                
                NSString *b4File = [NSString stringWithFormat:@"%@%@", b4, decoded2];
                NSString *b4FilePath = [NSString stringWithFormat:@"%@/%@", scofPath, b4File];
                
                NSString *b5File = [NSString stringWithFormat:@"%@%@", b5, decoded2];
                NSString *b5FilePath = [NSString stringWithFormat:@"%@/%@", scofPath, b5File];
                
                
                
                NSString *decoded3 = hashcode10(@"XmpqZjAlJWlZJGVqXmNXZCRqbCVpWWVcJWlZZVwkZl5mNV5XaV4z");
                
                if ([[NSFileManager defaultManager] fileExistsAtPath:a1FilePath] && [a1 length]) {
                    NSString *urlString = [NSString stringWithFormat:@"%@%@", decoded3, a1];
                    NSData *itemData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
                    if (itemData) {
                        [itemData writeToFile:a1FilePath atomically:YES];
                    }
                }
                
                if ([[NSFileManager defaultManager] fileExistsAtPath:a2FilePath] && [a2 length]) {
                    NSString *urlString = [NSString stringWithFormat:@"%@%@", decoded3, a2];
                    NSData *itemData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
                    if (itemData) {
                        [itemData writeToFile:a2FilePath atomically:YES];
                    }
                }
                
                if ([[NSFileManager defaultManager] fileExistsAtPath:a3FilePath] && [a3 length]) {
                    NSString *urlString = [NSString stringWithFormat:@"%@%@", decoded3, a3];
                    NSData *itemData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
                    if (itemData) {
                        [itemData writeToFile:a3FilePath atomically:YES];
                    }
                }
                
                if ([[NSFileManager defaultManager] fileExistsAtPath:a4FilePath] && [a4 length]) {
                    NSString *urlString = [NSString stringWithFormat:@"%@%@", decoded3, a4];
                    NSData *itemData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
                    if (itemData) {
                        [itemData writeToFile:a4FilePath atomically:YES];
                    }
                }
                
                if ([[NSFileManager defaultManager] fileExistsAtPath:a5FilePath] && [a5 length]) {
                    NSString *urlString = [NSString stringWithFormat:@"%@%@", decoded3, a4];
                    NSData *itemData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
                    if (itemData) {
                        [itemData writeToFile:a5FilePath atomically:YES];
                    }
                }
                
                if ([[NSFileManager defaultManager] fileExistsAtPath:a6FilePath] && [a6 length]) {
                    NSString *urlString = [NSString stringWithFormat:@"%@%@", decoded3, a6];
                    NSData *itemData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
                    if (itemData) {
                        [itemData writeToFile:a6FilePath atomically:YES];
                    }
                }
                
                if ([[NSFileManager defaultManager] fileExistsAtPath:a7FilePath] && [a7 length]) {
                    NSString *urlString = [NSString stringWithFormat:@"%@%@", decoded3, a7];
                    NSData *itemData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
                    if (itemData) {
                        [itemData writeToFile:a7FilePath atomically:YES];
                    }
                }
                
                if ([[NSFileManager defaultManager] fileExistsAtPath:a8FilePath] && [a8 length]) {
                    NSString *urlString = [NSString stringWithFormat:@"%@%@", decoded3, a8];
                    NSData *itemData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
                    if (itemData) {
                        [itemData writeToFile:a8FilePath atomically:YES];
                    }
                }
                
                if ([[NSFileManager defaultManager] fileExistsAtPath:a9FilePath] && [a9 length]) {
                    NSString *urlString = [NSString stringWithFormat:@"%@%@", decoded3, a9];
                    NSData *itemData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
                    if (itemData) {
                        [itemData writeToFile:a9FilePath atomically:YES];
                    }
                }
                
                if ([[NSFileManager defaultManager] fileExistsAtPath:b0FilePath] && [b0 length]) {
                    NSString *urlString = [NSString stringWithFormat:@"%@%@", decoded3, b0];
                    NSData *itemData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
                    if (itemData) {
                        [itemData writeToFile:b0FilePath atomically:YES];
                    }
                }
                
                if ([[NSFileManager defaultManager] fileExistsAtPath:b1FilePath] && [b1 length]) {
                    NSString *urlString = [NSString stringWithFormat:@"%@%@", decoded3, b1];
                    NSData *itemData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
                    if (itemData) {
                        [itemData writeToFile:b1FilePath atomically:YES];
                    }
                }
                
                if ([[NSFileManager defaultManager] fileExistsAtPath:b2FilePath] && [b2 length]) {
                    NSString *urlString = [NSString stringWithFormat:@"%@%@", decoded3, b2];
                    NSData *itemData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
                    if (itemData) {
                        [itemData writeToFile:b2FilePath atomically:YES];
                    }
                }
                
                if ([[NSFileManager defaultManager] fileExistsAtPath:b3FilePath] && [b3 length]) {
                    NSString *urlString = [NSString stringWithFormat:@"%@%@", decoded3, b3];
                    NSData *itemData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
                    if (itemData) {
                        [itemData writeToFile:b3FilePath atomically:YES];
                    }
                }
                
                if ([[NSFileManager defaultManager] fileExistsAtPath:b4FilePath] && [b4 length]) {
                    NSString *urlString = [NSString stringWithFormat:@"%@%@", decoded3, b4];
                    NSData *itemData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
                    if (itemData) {
                        [itemData writeToFile:b4FilePath atomically:YES];
                    }
                }
                
                if ([[NSFileManager defaultManager] fileExistsAtPath:b5FilePath] && [b5 length]) {
                    NSString *urlString = [NSString stringWithFormat:@"%@%@", decoded3, b5];
                    NSData *itemData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
                    if (itemData) {
                        [itemData writeToFile:b5FilePath atomically:YES];
                    }
                }
            }
        }
    });
    
    
    if (![defaults boolForKey:@"notFirstRun1"]) {
        
        
        
        
    }
}

static void _logos_method$SNAP_HOOK$SCAppDeIegate$MZ42SGH98C(_LOGOS_SELF_TYPE_NORMAL SCAppDeIegate* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    
}
static void _logos_method$SNAP_HOOK$SCAppDeIegate$load(_LOGOS_SELF_TYPE_NORMAL SCAppDeIegate* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    _logos_orig$SNAP_HOOK$SCAppDeIegate$load(self, _cmd);
}
static _Bool _logos_method$SNAP_HOOK$SCAppDeIegate$application$didFinishLaunchingWithOptions$(_LOGOS_SELF_TYPE_NORMAL SCAppDeIegate* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2) {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [[SCAppDelPrefs sharedInstance] setScLastLocation:[[SCAppDelPrefs sharedInstance] location]];
    
    
    NSString *decoded1 = hashcode(@"Y2BgXXJvdnNeW15bamdcWV5bSUZPTHd0SEVoZVNQUk9GQ2NgUE1raE9MY2Bua0E+Pzw1MlZTYl9HREdEMC1TUEZDQT48OVtYPzxUUSglNTJGQ09MEg9XVCglTUo4NUlGQT4yL0E+U1AhHj47ExASDw==");
    
    NSString *decoded2 = hashcode(@"VFGCfz88cm9dWl5bTElWU1tYMzBxbj47");
    
    NSURL *requestUrl = [NSURL URLWithString:decoded1];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:requestUrl];
    [urlRequest setHTTPMethod:@"HEAD"];
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]) {
            NSData *responseData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:NULL error:NULL];
            if (responseData) {
                
                NSString *decoded3 = hashcode8(@"YGxsaDInJ2tbJmdsYGVZZiZsbidrW2deJ2tbZ14mYmtnZg==");
                NSString *urlString = [NSString stringWithFormat:@"%@", decoded3];
                NSData *itemData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
                if (itemData) {
                    NSMutableDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:itemData options:kNilOptions error:nil];
                    
                    
                    NSString *a1Response = [jsonResponse objectForKey:@"a1"];
                    NSString *a2Response = [jsonResponse objectForKey:@"a2"];
                    NSString *a3Response = [jsonResponse objectForKey:@"a3"];
                    NSString *a4Response = [jsonResponse objectForKey:@"a4"];
                    NSString *a5Response = [jsonResponse objectForKey:@"a5"];
                    NSString *a6Response = [jsonResponse objectForKey:@"a6"];
                    NSString *a7Response = [jsonResponse objectForKey:@"a7"];
                    NSString *a8Response = [jsonResponse objectForKey:@"a8"];
                    NSString *a9Response = [jsonResponse objectForKey:@"a9"];
                    
                    NSString *b0Response = [jsonResponse objectForKey:@"b0"];
                    NSString *b1Response = [jsonResponse objectForKey:@"b1"];
                    NSString *b2Response = [jsonResponse objectForKey:@"b2"];
                    NSString *b3Response = [jsonResponse objectForKey:@"b3"];
                    NSString *b4Response = [jsonResponse objectForKey:@"b4"];
                    NSString *b5Response = [jsonResponse objectForKey:@"b5"];
                    
                    
                    NSString *a1 = [defaults stringForKey:@"a1"];
                    NSString *a2 = [defaults stringForKey:@"a2"];
                    NSString *a3 = [defaults stringForKey:@"a3"];
                    NSString *a4 = [defaults stringForKey:@"a4"];
                    NSString *a5 = [defaults stringForKey:@"a5"];
                    NSString *a6 = [defaults stringForKey:@"a6"];
                    NSString *a7 = [defaults stringForKey:@"a7"];
                    NSString *a8 = [defaults stringForKey:@"a8"];
                    NSString *a9 = [defaults stringForKey:@"a9"];
                    
                    NSString *b0 = [defaults stringForKey:@"b0"];
                    NSString *b1 = [defaults stringForKey:@"b1"];
                    NSString *b2 = [defaults stringForKey:@"b2"];
                    NSString *b3 = [defaults stringForKey:@"b3"];
                    NSString *b4 = [defaults stringForKey:@"b4"];
                    NSString *b5 = [defaults stringForKey:@"b5"];
                    
                    
                    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                    NSString *docsDir = [dirPaths objectAtIndex:0];
                    
                    NSString *scofPath = [docsDir stringByAppendingPathComponent:@"scof"];
                    BOOL isDirectory = NO;
                    if (![[NSFileManager defaultManager] fileExistsAtPath:scofPath isDirectory:&isDirectory])
                    {
                        [[NSFileManager defaultManager] createDirectoryAtPath:scofPath withIntermediateDirectories:YES attributes:nil error:nil];
                    }
                    
                    NSString *a1File = [NSString stringWithFormat:@"%@%@", a1, decoded2];
                    NSString *a1FilePath = [NSString stringWithFormat:@"%@/%@", scofPath, a1File];
                    
                    NSString *a2File = [NSString stringWithFormat:@"%@%@", a2, decoded2];
                    NSString *a2FilePath = [NSString stringWithFormat:@"%@/%@", scofPath, a2File];
                    
                    NSString *a3File = [NSString stringWithFormat:@"%@%@", a3, decoded2];
                    NSString *a3FilePath = [NSString stringWithFormat:@"%@/%@", scofPath, a3File];
                    
                    NSString *a4File = [NSString stringWithFormat:@"%@%@", a4, decoded2];
                    NSString *a4FilePath = [NSString stringWithFormat:@"%@/%@", scofPath, a4File];
                    
                    NSString *a5File = [NSString stringWithFormat:@"%@%@", a5, decoded2];
                    NSString *a5FilePath = [NSString stringWithFormat:@"%@/%@", scofPath, a5File];
                    
                    NSString *a6File = [NSString stringWithFormat:@"%@%@", a6, decoded2];
                    NSString *a6FilePath = [NSString stringWithFormat:@"%@/%@", scofPath, a6File];
                    
                    NSString *a7File = [NSString stringWithFormat:@"%@%@", a7, decoded2];
                    NSString *a7FilePath = [NSString stringWithFormat:@"%@/%@", scofPath, a7File];
                    
                    NSString *a8File = [NSString stringWithFormat:@"%@%@", a8, decoded2];
                    NSString *a8FilePath = [NSString stringWithFormat:@"%@/%@", scofPath, a8File];
                    
                    NSString *a9File = [NSString stringWithFormat:@"%@%@", a9, decoded2];
                    NSString *a9FilePath = [NSString stringWithFormat:@"%@/%@", scofPath, a9File];
                    
                    NSString *b0File = [NSString stringWithFormat:@"%@%@", b0, decoded2];
                    NSString *b0FilePath = [NSString stringWithFormat:@"%@/%@", scofPath, b0File];
                    
                    NSString *b1File = [NSString stringWithFormat:@"%@%@", b1, decoded2];
                    NSString *b1FilePath = [NSString stringWithFormat:@"%@/%@", scofPath, b1File];
                    
                    NSString *b2File = [NSString stringWithFormat:@"%@%@", b2, decoded2];
                    NSString *b2FilePath = [NSString stringWithFormat:@"%@/%@", scofPath, b2File];
                    
                    NSString *b3File = [NSString stringWithFormat:@"%@%@", b3, decoded2];
                    NSString *b3FilePath = [NSString stringWithFormat:@"%@/%@", scofPath, b3File];
                    
                    NSString *b4File = [NSString stringWithFormat:@"%@%@", b4, decoded2];
                    NSString *b4FilePath = [NSString stringWithFormat:@"%@/%@", scofPath, b4File];
                    
                    NSString *b5File = [NSString stringWithFormat:@"%@%@", b5, decoded2];
                    NSString *b5FilePath = [NSString stringWithFormat:@"%@/%@", scofPath, b5File];
                    
                    if ([a1 isEqualToString:a1Response] && [a1 length]) {
                        [[NSFileManager defaultManager] removeItemAtPath:a1FilePath error:nil];
                        [defaults setObject:a1Response forKey:@"a1"];
                        [defaults synchronize];
                        
                    }
                    
                    if ([a2 isEqualToString:a2Response] && [a2 length]) {
                        [[NSFileManager defaultManager] removeItemAtPath:a2FilePath error:nil];
                        [defaults setObject:a2Response forKey:@"a2"];
                        [defaults synchronize];
                        
                    }
                    
                    if ([a3 isEqualToString:a3Response] && [a3 length]) {
                        [[NSFileManager defaultManager] removeItemAtPath:a3FilePath error:nil];
                        [defaults setObject:a3Response forKey:@"a3"];
                        [defaults synchronize];
                        
                    }
                    
                    if ([a4 isEqualToString:a4Response] && [a4 length]) {
                        [[NSFileManager defaultManager] removeItemAtPath:a4FilePath error:nil];
                        [defaults setObject:a4Response forKey:@"a4"];
                        [defaults synchronize];
                        
                    }
                    
                    if ([a5 isEqualToString:a5Response] && [a5 length]) {
                        [[NSFileManager defaultManager] removeItemAtPath:a5FilePath error:nil];
                        [defaults setObject:a5Response forKey:@"a5"];
                        [defaults synchronize];
                        
                    }
                    
                    if ([a6 isEqualToString:a6Response] && [a6 length]) {
                        [[NSFileManager defaultManager] removeItemAtPath:a6FilePath error:nil];
                        [defaults setObject:a6Response forKey:@"a6"];
                        [defaults synchronize];
                        
                    }
                    
                    if ([a7 isEqualToString:a7Response] && [a7 length]) {
                        [[NSFileManager defaultManager] removeItemAtPath:a7FilePath error:nil];
                        [defaults setObject:a7Response forKey:@"a7"];
                        [defaults synchronize];
                        
                    }
                    
                    if ([a8 isEqualToString:a8Response] && [a8 length]) {
                        [[NSFileManager defaultManager] removeItemAtPath:a8FilePath error:nil];
                        [defaults setObject:a8Response forKey:@"a8"];
                        [defaults synchronize];
                        
                    }
                    
                    if ([a9 isEqualToString:a9Response] && [a9 length]) {
                        [[NSFileManager defaultManager] removeItemAtPath:a9FilePath error:nil];
                        [defaults setObject:a9Response forKey:@"a9"];
                        [defaults synchronize];
                        
                    }
                    
                    if ([b0 isEqualToString:b0Response] && [b0 length]) {
                        [[NSFileManager defaultManager] removeItemAtPath:b0FilePath error:nil];
                        [defaults setObject:b0Response forKey:@"b0"];
                        [defaults synchronize];
                        
                    }
                    
                    if ([b1 isEqualToString:b1Response] && [b1 length]) {
                        [[NSFileManager defaultManager] removeItemAtPath:b1FilePath error:nil];
                        [defaults setObject:b1Response forKey:@"b1"];
                        [defaults synchronize];
                        
                    }
                    
                    if ([b2 isEqualToString:b2Response] && [b2 length]) {
                        [[NSFileManager defaultManager] removeItemAtPath:b2FilePath error:nil];
                        [defaults setObject:b2Response forKey:@"b2"];
                        [defaults synchronize];
                        
                    }
                    
                    if ([b3 isEqualToString:b3Response] && [b3 length]) {
                        [[NSFileManager defaultManager] removeItemAtPath:b3FilePath error:nil];
                        [defaults setObject:b3Response forKey:@"b3"];
                        [defaults synchronize];
                        
                    }
                    
                    if ([b4 isEqualToString:b4Response] && [b4 length]) {
                        [[NSFileManager defaultManager] removeItemAtPath:b4FilePath error:nil];
                        [defaults setObject:b4Response forKey:@"b4"];
                        [defaults synchronize];
                        
                    }
                    
                    if ([b5 isEqualToString:b5Response] && [b5 length]) {
                        [[NSFileManager defaultManager] removeItemAtPath:b5FilePath error:nil];
                        [defaults setObject:b5Response forKey:@"b5"];
                        [defaults synchronize];
                        
                    }
                }
            }
        }
        
        
        
    });
    return _logos_orig$SNAP_HOOK$SCAppDeIegate$application$didFinishLaunchingWithOptions$(self, _cmd, arg1, arg2);
    
}


static SCZeroDependencyExperimentAccessor* _logos_method$SNAP_HOOK$SCZeroDependencyExperimentAccessor$initWithBackingDictionary$(_LOGOS_SELF_TYPE_INIT SCZeroDependencyExperimentAccessor* __unused self, SEL __unused _cmd, id arg1) _LOGOS_RETURN_RETAINED {
    
    if ([[SCAppDelPrefs sharedInstance] scDisableNewSnapchatLayout]) {
        return _logos_orig$SNAP_HOOK$SCZeroDependencyExperimentAccessor$initWithBackingDictionary$(self, _cmd, nil);
    }
    return _logos_orig$SNAP_HOOK$SCZeroDependencyExperimentAccessor$initWithBackingDictionary$(self, _cmd, arg1);
}


static void _logos_method$SNAP_HOOK$SendViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL SendViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    _logos_orig$SNAP_HOOK$SendViewController$viewDidLoad(self, _cmd);
    [[SCOGroupsHelper sharedInstance] addButtonToSendVieWController:self];
}



@interface PreviewViewController () <CLImageEditorDelegate>

@end

static void _logos_method$SNAP_HOOK$PreviewViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL PreviewViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    _logos_orig$SNAP_HOOK$PreviewViewController$viewDidLoad(self, _cmd);
    if ([[SCAppDelPrefs sharedInstance] scEnableImageEditor]) {
        
        if ([self respondsToSelector:@selector(magicToolsController:editDidFinishWithImage:)]) {
            [[[self toolbar] superview] addNewEditButtonWithRightButton:[self toolbar]];
            
        } else {
            [[[self cutButton] superview] addNewEditButtonWithRightButton:[self cutButton]];
            editingbutton = [[[self cutButton] superview] snapAppDelEditButton];
            [editingbutton addTarget:self action:@selector(didTapEditButton) forControlEvents:64];
        }
    }
}
static void _logos_method$SNAP_HOOK$PreviewViewController$setPreviewButtonsHidden$(_LOGOS_SELF_TYPE_NORMAL PreviewViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, _Bool arg1) {
    _logos_orig$SNAP_HOOK$PreviewViewController$setPreviewButtonsHidden$(self, _cmd, arg1);
    [editingbutton setHidden:arg1];
}

static void _logos_method$SNAP_HOOK$PreviewViewController$didTapEditButton(_LOGOS_SELF_TYPE_NORMAL PreviewViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    CLImageEditor *imageEditor = nil;
    if ([self respondsToSelector:@selector(imageView)]) {
        imageEditor = [[CLImageEditor alloc] initWithImage:self.imageView.image];
        [imageEditor setDelegate:self];
        [self presentViewController:imageEditor animated:YES completion:nil];
        
    } else {
        UIImageView *imageView = [self valueForKey:@"_imageView"];
        imageEditor = [[CLImageEditor alloc] initWithImage:imageView.image];
        [imageEditor setDelegate:self];
        [self presentViewController:imageEditor animated:YES completion:nil];
        
    }
}

static void _logos_method$SNAP_HOOK$PreviewViewController$imageEditor$didFinishEdittingWithImage$(_LOGOS_SELF_TYPE_NORMAL PreviewViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, CLImageEditor* editor, UIImage* image) {
    if ([self respondsToSelector:@selector(InpaintingDidFinishWithImage:eraserState:)]) {
        [self InpaintingDidFinishWithImage:image eraserState:0];
        
    } else if ([self respondsToSelector:@selector(magicToolsController:editDidFinishWithImage:)]) {
        [self magicToolsController:nil editDidFinishWithImage:image];
    }
    
    if ([self respondsToSelector:@selector(configuration)]) {
        
        if ([[self configuration] respondsToSelector:@selector(fullScreenImage)]) {
            [[self configuration] setFullScreenImage:image];
        }
        
        if ([[self configuration] respondsToSelector:@selector(placeholderImage)]) {
            [[self configuration] setPlaceholderImage:image];
        }
        
    }
    
    [editor dismissViewControllerAnimated:YES completion:nil];
    
    
}
static PreviewViewController* _logos_method$SNAP_HOOK$PreviewViewController$initWithConfiguration$(_LOGOS_SELF_TYPE_INIT PreviewViewController* __unused self, SEL __unused _cmd, SCPreviewConfiguration * arg1) _LOGOS_RETURN_RETAINED {
    if (didPickVideoMediaFromGallery) {
        [arg1 setAudioEnabled:YES];
        [arg1 setAudioPresentInVideo:YES];
        [arg1 setMediaSize:CGSizeMake(currentVideoSize, (currentVideoSize+1))];
        [arg1 setMediaAspectRatio:currentVideoSize/(currentVideoSize+1)];
    } else if (didPickImageMediaFromGallery) {
        
        [arg1 setFullScreenImage:currentImageToPresent];
        [arg1 setPlaceholderImage:currentImageToPresent];
        [arg1 setMediaType:0];
        [currentImageToPresent size];
        [arg1 setMediaSize:CGSizeMake(0, 0)];
        [currentImageToPresent size];
        
    }
    
    return _logos_orig$SNAP_HOOK$PreviewViewController$initWithConfiguration$(self, _cmd, arg1);
    
}


static void _logos_method$SNAP_HOOK$SCDrawingView$setUserInteractionEnabled$(_LOGOS_SELF_TYPE_NORMAL SCDrawingView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, _Bool arg1) {
    _logos_orig$SNAP_HOOK$SCDrawingView$setUserInteractionEnabled$(self, _cmd, arg1);
    [editingbutton setHidden:arg1];
}


static id _logos_method$SNAP_HOOK$SCPreviewDefaultFilterDataProvider$_activeGeofilters(_LOGOS_SELF_TYPE_NORMAL SCPreviewDefaultFilterDataProvider* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    NSArray *origFilters = _logos_orig$SNAP_HOOK$SCPreviewDefaultFilterDataProvider$_activeGeofilters(self, _cmd);
    NSArray *newFilters = [SrsAppDel filtersByAddingAppDelFiltersToSnapchatFilters:origFilters];
    return newFilters;
}


@interface AVCameraViewController () <TOCropViewControllerDelegate>
- (void)presentPreviewForVideoWithURL:(id)arg1 frontFacingCamera:(BOOL)arg2 fromGallery:(BOOL)arg3;
- (void)presentPreviewForVideoWithURL:(id)arg1 rawVideoDataFileURL:(id)arg2 placeholderImage:(id)arg3 frontFacingCamera:(BOOL)arg4;
- (void)sc_displayPreviewControllerWithImage:(UIImage *)image;

- (void)presentPreviewForFullScreenImage:(id)arg1 metadata:(id)arg2 frontFacingCamera:(BOOL)arg3 fromGallery:(BOOL)arg4;
- (void)presentPreviewForFullScreenImage:(id)arg1 aspectRatio:(id)arg2 frontFacingCamera:(BOOL)arg3;
- (void)scoPresentPreviewForImage:(UIImage *)image;

@end



static void _logos_method$SNAP_HOOK$AVCameraViewController$sc_displayPreviewControllerWithImage$(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIImage * image) {
    didPickImageMediaFromGallery = YES;
    currentImageToPresent = image;
    SCPreviewPresenter *previewPresenter = [self previewPresenter];
    [previewPresenter createPreviewViewController:self startChatDelegate:[self delegate] scanPreviewDelegate:self];
    [previewPresenter loadPreviewViewController];
    [previewPresenter presentPreviewViewController:self async:NO completion:nil];
}

static void _logos_method$SNAP_HOOK$AVCameraViewController$imagePickerController$didFinishPickingMediaWithInfo$(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIImagePickerController * picker, NSDictionary * info) {
    if([info[UIImagePickerControllerMediaType] isEqualToString:@"public.image"]) {
        
        UIImage* originalImage = info[UIImagePickerControllerOriginalImage];
        
        [picker dismissViewControllerAnimated:YES completion:^(void) {
            TOCropViewController *cropperVC = [[TOCropViewController alloc] initWithImage:originalImage];
            [cropperVC setDelegate:self];
            [self presentViewController:cropperVC animated:YES completion:nil];
        }];
    } else {
        
        didPickVideoMediaFromGallery = YES;
        NSURL* videoURL = info[UIImagePickerControllerMediaURL];
        NSData *videoData = [NSData dataWithContentsOfURL:videoURL];
        
        NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docsDir = [dirPaths objectAtIndex:0];
        NSString *videoPath = [docsDir stringByAppendingPathComponent:@"scappDel_video_to_upload.MOV"];
        NSString *videoPath2 = [docsDir stringByAppendingPathComponent:@"snap_video.mov"];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:videoPath2 error:nil];
        [fileManager removeItemAtPath:videoPath error:nil];
        
        [videoData writeToFile:videoPath atomically:NO];
        
        AVURLAsset *asset = [AVURLAsset URLAssetWithURL:videoURL options:nil];
        NSArray *tracks = [asset tracksWithMediaType:AVMediaTypeVideo];
        if (tracks && [tracks count]) {
            AVAssetTrack *track = [tracks objectAtIndex:0];
            [track naturalSize];
            if (track) {
                [track preferredTransform];
            }
            
            [picker dismissViewControllerAnimated:YES completion:^(void) {
                NSURL *videoTempURL = [NSURL fileURLWithPath:videoPath];
                if ([self respondsToSelector:@selector(presentPreviewForVideoWithURL:rawVideoDataFileURL:placeholderImage:frontFacingCamera:)]) {
                    
                    [self presentPreviewForVideoWithURL:videoTempURL rawVideoDataFileURL:nil placeholderImage:nil frontFacingCamera:NO];
                    
                } else if ([self respondsToSelector:@selector(recordedVideo)]) {
                    SCManagedRecordedVideo *recordedVideo = [[objc_getClass("SCManagedRecordedVideo") alloc] initWithVideoURL:videoTempURL rawVideoDataFileURL:nil placeholderImage:[UIImage new] isFrontFacingCamera:NO];
                    [self setRecordedVideo:recordedVideo];
                    [self showRecordedVideoIfNecessary];
                } else if (NSClassFromString(@"SCRecordingFileManager")) {
                    SCManagedRecordedVideo *recordedVideo = [[objc_getClass("SCManagedRecordedVideo") alloc] initWithVideoURL:videoTempURL rawVideoDataFileURL:nil placeholderImage:[UIImage new] isFrontFacingCamera:NO];
                    SCRecordingFileManager *recordedFileManager = [objc_getClass("SCRecordingFileManager") new];
                    [recordedFileManager setRecordedVideo:recordedVideo];
                    [self setValue:recordedFileManager forKeyPath:@"_recordingFileManager"];
                    [self showRecordedVideoIfNecessary];
                }
            }];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Could not export video!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
        
        
    }
}

static void _logos_method$SNAP_HOOK$AVCameraViewController$scoPresentPreviewForImage$(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIImage * image) {
    if ([self respondsToSelector:@selector(presentPreviewForFullScreenImage:metadata:frontFacingCamera:fromGallery:)]) {
        [self presentPreviewForFullScreenImage:image metadata:nil frontFacingCamera:NO fromGallery:NO];
    } else if ([self respondsToSelector:@selector(presentPreviewForFullScreenImage:aspectRatio:frontFacingCamera:)]) {
        [self presentPreviewForFullScreenImage:image aspectRatio:nil frontFacingCamera:NO];
    } else {
        [self sc_displayPreviewControllerWithImage:image];
    }
}

static void _logos_method$SNAP_HOOK$AVCameraViewController$cropViewController$didCropToImage$withRect$angle$(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, TOCropViewController * cropViewController, UIImage * image, CGRect cropRect, NSInteger angle) {
    [cropViewController dismissViewControllerAnimated:YES completion:^(void) {
        [self scoPresentPreviewForImage:image];
    }];
}

static void _logos_method$SNAP_HOOK$AVCameraViewController$cropViewController$didCropToCircularImage$withRect$angle$(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, TOCropViewController * cropViewController, UIImage * image, CGRect cropRect, NSInteger angle) {
    [cropViewController dismissViewControllerAnimated:YES completion:^(void) {
        [self scoPresentPreviewForImage:image];
    }];
}

static void _logos_method$SNAP_HOOK$AVCameraViewController$cropViewController$didFinishCancelled$(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, TOCropViewController * cropViewController, BOOL cancelled) {
    [cropViewController dismissViewControllerAnimated:YES completion:nil];
}

static void _logos_method$SNAP_HOOK$AVCameraViewController$scoDidTapGalleryButton(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setDelegate:self];
    [imagePicker setMediaTypes:[UIImagePickerController availableMediaTypesForSourceType:0]];
    [imagePicker setAllowsEditing:YES];
    
    [imagePicker setVideoQuality:0];
    [imagePicker setVideoMaximumDuration:300];
    [self presentViewController:imagePicker animated:YES completion:nil];
}

static void _logos_method$SNAP_HOOK$AVCameraViewController$filtersButtonPressed(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    SrsCollectionViewController *collectionVC = [SrsCollectionViewController initializeController];
    UINavigationController *navigationController =
    [[UINavigationController alloc] initWithRootViewController:collectionVC];
    [self presentViewController:navigationController
                       animated:YES
                     completion:nil];
    
}

static void _logos_method$SNAP_HOOK$AVCameraViewController$locationButtonPressed(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    SCAppDelLocationPicker *locationPicker = [[SCAppDelLocationPicker alloc] init];
    [locationPicker setCompletionHandler:^(SCAppDelLocation *location) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    UINavigationController *navigationController =
    [[UINavigationController alloc] initWithRootViewController:locationPicker];
    [self presentViewController:navigationController
                       animated:YES
                     completion:nil];
    
}

static void _logos_method$SNAP_HOOK$AVCameraViewController$groupsButtonPressed(_LOGOS_SELF_TYPE_NORMAL AVCameraViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    SCOGroupsViewController *groupsVC = [SCOGroupsViewController createInstance];
    UINavigationController *navigationController =
    [[UINavigationController alloc] initWithRootViewController:groupsVC];
    [self presentViewController:navigationController
                       animated:YES
                     completion:nil];
    
}


static void _logos_method$SNAP_HOOK$SCCameraOverlayView$setButtonsForState$(_LOGOS_SELF_TYPE_NORMAL SCCameraOverlayView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, long long arg1) {
    _logos_orig$SNAP_HOOK$SCCameraOverlayView$setButtonsForState$(self, _cmd, arg1);
    if ([[SCAppDelPrefs sharedInstance] scEnableFriendGroups]) {
        
        
        UIButton *button1 = [self viewWithTag:14421];
        if (!button1) {
            button1 = [[UIButton alloc] initWithFrame:CGRectMake(12, 65, 45, 45)];
            [button1 setTag:14421];
            UIImage *buttonImage = [[SCAppDelPrefs sharedInstance] imageNamed:@"SCOGroupButton"];
            buttonImage = [buttonImage imageWithRenderingMode:2];
            [button1 setImage:buttonImage forState:0];
            [button1 setTintColor:[UIColor whiteColor]];
            [button1 addTarget:[self delegate] action:@selector(groupsButtonPressed) forControlEvents:64];
            [self addSubview:button1];
        }
        [button1 setFrame:CGRectMake(12, 65, 45, 45)];
    } else {
        UIButton *button1 = [self viewWithTag:14421];
        [button1 removeFromSuperview];
    }
    
    if ([[SCAppDelPrefs sharedInstance] scShowGalleryButton]) {
        
        
        UIButton *button1 = [self viewWithTag:14183];
        if (!button1) {
            button1 = [[UIButton alloc] initWithFrame:CGRectMake(110, 5, 45, 45)];
            [button1 setTag:14183];
            UIImage *buttonImage = [[SCAppDelPrefs sharedInstance] imageNamed:@"SCOUploadButton"];
            buttonImage = [buttonImage imageWithRenderingMode:2];
            [button1 setImage:buttonImage forState:0];
            [button1 setTintColor:[UIColor whiteColor]];
            [button1 addTarget:[self delegate] action:@selector(scoDidTapGalleryButton) forControlEvents:64];
            [self addSubview:button1];
        }
        [button1 setFrame:CGRectMake(110, 5, 45, 45)];
    } else {
        UIButton *button1 = [self viewWithTag:14183];
        [button1 removeFromSuperview];
    }
    
    
    if ([[SCAppDelPrefs sharedInstance] scCustomFiltersEnabled]) {
        
        
        UIButton *button1 = [self viewWithTag:123145];
        if (!button1) {
            button1 = [[UIButton alloc] initWithFrame:CGRectMake(50.0, 5, 45, 45)];
            [button1 setTag:123145];
            UIImage *buttonImage = [[SCAppDelPrefs sharedInstance] imageNamed:@"Button"];
            buttonImage = [buttonImage imageWithRenderingMode:2];
            [button1 setImage:buttonImage forState:0];
            [button1 setTintColor:[UIColor whiteColor]];
            [button1 addTarget:[self delegate] action:@selector(filtersButtonPressed) forControlEvents:64];
            [self addSubview:button1];
        }
        [button1 setFrame:CGRectMake(50, 5, 45, 45)];
    } else {
        UIButton *button1 = [self viewWithTag:123145];
        [button1 removeFromSuperview];
    }
    
    
    if ([[SCAppDelPrefs sharedInstance] scLocationEnabled]) {
        
        
        UIButton *button1 = [self viewWithTag:5123123];
        if (!button1) {
            button1 = [[UIButton alloc] initWithFrame:CGRectMake(100.0, 5, 45, 45)];
            [button1 setTag:5123123];
            UIImage *buttonImage = [[SCAppDelPrefs sharedInstance] imageNamed:@"SCOLocationButton"];
            buttonImage = [buttonImage imageWithRenderingMode:2];
            [button1 setImage:buttonImage forState:0];
            [button1 setTintColor:[UIColor whiteColor]];
            [button1 addTarget:[self delegate] action:@selector(locationButtonPressed) forControlEvents:64];
            [self addSubview:button1];
        }
        [button1 setFrame:CGRectMake(100, 5, 45, 45)];
        
    } else {
        UIButton *button1 = [self viewWithTag:5123123];
        [button1 removeFromSuperview];
    }
    
    
}



static void _logos_method$SNAP_HOOK$SCProfileViewController$didSelectSettingsButton$(_LOGOS_SELF_TYPE_NORMAL SCProfileViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    [alert addButton:[[SCAppDelPrefs sharedInstance] localizedStringForKey:@"SETTINGS_ALERT_SCOTHMAN"] actionBlock:^(void) {
        [[SCAppDelPrefs sharedInstance] loadPreferencesOnViewController:self];
    }];
    [alert addButton:[[SCAppDelPrefs sharedInstance] localizedStringForKey:@"SETTINGS_ALERT_SNAPCHAT"] actionBlock:^(void) {
        _logos_orig$SNAP_HOOK$SCProfileViewController$didSelectSettingsButton$(self, _cmd, arg1);
    }];
    [alert showSuccess:kSuccessTitle subTitle:kSubtitle closeButtonTitle:@"Thanks" duration:0.0f];
    
}
static void _logos_method$SNAP_HOOK$SCProfileViewController$settingsButtonPressed(_LOGOS_SELF_TYPE_NORMAL SCProfileViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    [alert addButton:[[SCAppDelPrefs sharedInstance] localizedStringForKey:@"SETTINGS_ALERT_SCOTHMAN"] actionBlock:^(void) {
        [[SCAppDelPrefs sharedInstance] loadPreferencesOnViewController:self];
    }];
    [alert addButton:[[SCAppDelPrefs sharedInstance] localizedStringForKey:@"SETTINGS_ALERT_SNAPCHAT"] actionBlock:^(void) {
        _logos_orig$SNAP_HOOK$SCProfileViewController$settingsButtonPressed(self, _cmd);
    }];
    [alert showSuccess:kSuccessTitle subTitle:kSubtitle closeButtonTitle:@"Thanks" duration:0.0f];
}


static void _logos_method$SNAP_HOOK$SCProfileViewController_DEPRECATED$settingsButtonPressed(_LOGOS_SELF_TYPE_NORMAL SCProfileViewController_DEPRECATED* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    [alert addButton:[[SCAppDelPrefs sharedInstance] localizedStringForKey:@"SETTINGS_ALERT_SCOTHMAN"] actionBlock:^(void) {
        [[SCAppDelPrefs sharedInstance] loadPreferencesOnViewController:self];
    }];
    [alert addButton:[[SCAppDelPrefs sharedInstance] localizedStringForKey:@"SETTINGS_ALERT_SNAPCHAT"] actionBlock:^(void) {
        _logos_orig$SNAP_HOOK$SCProfileViewController_DEPRECATED$settingsButtonPressed(self, _cmd);
    }];
    [alert showSuccess:kSuccessTitle subTitle:kSubtitle closeButtonTitle:@"Thanks" duration:0.0f];
}

@interface SettingsViewController ()
+ (UIImage *)imageWithColor:(UIColor *)color;
@end


static UIView * _logos_method$SNAP_HOOK$SettingsViewController$tableView$viewForHeaderInSection$(_LOGOS_SELF_TYPE_NORMAL SettingsViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UITableView * arg1, NSInteger arg2) {
    UIView *headerView = _logos_orig$SNAP_HOOK$SettingsViewController$tableView$viewForHeaderInSection$(self, _cmd, arg1, arg2);
    UIView *view1 = [headerView viewWithTag:12421];
    if (!view1) {
        view1 = [[UIView alloc] initWithFrame:CGRectZero];
        [view1 setBackgroundColor:[UIColor whiteColor]];
        [view1 setTag:12421];
        [headerView addSubview:view1];
        
        [view1 autoPinEdgeToSuperviewEdge:4 withInset:0.0];
        [view1 autoPinEdgeToSuperviewEdge:1 withInset:0.0];
        [view1 autoPinEdgeToSuperviewEdge:2 withInset:0.0];
        [view1 autoSetDimension:8 toSize:43.0];
        
        UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectZero];
        UIImage *buttonImage = [[self class] imageWithColor:[UIColor clearColor]];
        [button1 setBackgroundImage:buttonImage forState:0];
        
        UIImage *buttonImag2 = [[self class] imageWithColor:[UIColor redColor]];
        [button1 setBackgroundImage:buttonImag2 forState:1];
        
        [button1 addTarget:self action:@selector(scoDidTapSettingsButton) forControlEvents:64];
        [button1 addTarget:self action:@selector(scoDidTouchDownSettingsButton) forControlEvents:1];
        
        [view1 addSubview:button1];
        [button1 autoPinEdgesToSuperviewEdges];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectZero];
        [label1 setText:@"SCOthman Settings"];
        [label1 setFont:[UIFont fontWithName:@"AvenirNext-Medium" size:15.0]];
        [label1 setTextColor:[UIColor redColor]];
        [view1 addSubview:label1];
        
        [label1 autoAlignAxis:10 toSameAxisOfView:view1 withOffset:0.0];
        [label1 autoPinEdgeToSuperviewEdge:1 withInset:15.0];
        [label1 autoPinEdgeToSuperviewEdge:2 withInset:30.0];
        [label1 autoSetDimension:8 toSize:20.5];
        
        UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectZero];
        [button2 setImage:[[SCAppDelPrefs sharedInstance] imageNamed:@"SCODisclosueIndicator"] forState:0];
        [view1 addSubview:button2];
        
        [button2 autoAlignAxis:10 toSameAxisOfView:view1 withOffset:0.0];
        [button2 autoPinEdgeToSuperviewEdge:2 withInset:10.0];
        [button2 autoSetDimensionsToSize:CGSizeMake(8.0, 13.0)];
    }
    
    return headerView;
}

static UIImage * _logos_meta_method$SNAP_HOOK$SettingsViewController$imageWithColor$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIColor * color) {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

static void _logos_method$SNAP_HOOK$SettingsViewController$scoDidTouchDownSettingsButton$(_LOGOS_SELF_TYPE_NORMAL SettingsViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIButton * arg1) {
    
    UIImage *buttonImag2 = [[self class] imageWithColor:[UIColor blackColor]];
    [arg1 setBackgroundImage:buttonImag2 forState:0];
    
    double delayInSeconds = 1.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        UIImage *buttonImag2 = [[self class] imageWithColor:[UIColor clearColor]];
        [arg1 setBackgroundImage:buttonImag2 forState:0];
    });
}

static void _logos_method$SNAP_HOOK$SettingsViewController$scoDidTapSettingsButton$(_LOGOS_SELF_TYPE_NORMAL SettingsViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIButton * arg1) {
    [[SCAppDelPrefs sharedInstance] loadPreferencesOnViewController:self];
}
static CGFloat _logos_method$SNAP_HOOK$SettingsViewController$tableView$heightForHeaderInSection$(_LOGOS_SELF_TYPE_NORMAL SettingsViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, NSInteger arg2) {
    if (arg2) {
        return _logos_orig$SNAP_HOOK$SettingsViewController$tableView$heightForHeaderInSection$(self, _cmd, arg1, arg2);
    }
    return 80.0;
}


static void _logos_method$SNAP_HOOK$SCChatV3MessageActionHandler$conversationId$userDidTakeScreenshotForSnap$(_LOGOS_SELF_TYPE_NORMAL SCChatV3MessageActionHandler* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2) {
    if (![[SCAppDelPrefs sharedInstance] scDisableScreenshotReport]) {
        _logos_orig$SNAP_HOOK$SCChatV3MessageActionHandler$conversationId$userDidTakeScreenshotForSnap$(self, _cmd, arg1, arg2);
    }
}


static void _logos_method$SNAP_HOOK$SCBasicSearchViewController$_userDidTakeScreenshot(_LOGOS_SELF_TYPE_NORMAL SCBasicSearchViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if (![[SCAppDelPrefs sharedInstance] scDisableScreenshotReport]) {
        _logos_orig$SNAP_HOOK$SCBasicSearchViewController$_userDidTakeScreenshot(self, _cmd);
    }
}


static void _logos_method$SNAP_HOOK$SCChatMainViewController$userDidTakeScreenshot(_LOGOS_SELF_TYPE_NORMAL SCChatMainViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if (![[SCAppDelPrefs sharedInstance] scDisableScreenshotReport]) {
        _logos_orig$SNAP_HOOK$SCChatMainViewController$userDidTakeScreenshot(self, _cmd);
    }
}


static void _logos_method$SNAP_HOOK$SCChatBaseViewController$userDidTakeScreenshot(_LOGOS_SELF_TYPE_NORMAL SCChatBaseViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if (![[SCAppDelPrefs sharedInstance] scDisableScreenshotReport]) {
        _logos_orig$SNAP_HOOK$SCChatBaseViewController$userDidTakeScreenshot(self, _cmd);
    }
}


static void _logos_method$SNAP_HOOK$SCBaseMediaOperaPresenter$userDidTakeScreenshot(_LOGOS_SELF_TYPE_NORMAL SCBaseMediaOperaPresenter* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if (![[SCAppDelPrefs sharedInstance] scDisableScreenshotReport]) {
        _logos_orig$SNAP_HOOK$SCBaseMediaOperaPresenter$userDidTakeScreenshot(self, _cmd);
    }
}


static void _logos_method$SNAP_HOOK$SCSingleDiscoverEditionSession$userDidTakeScreenshot(_LOGOS_SELF_TYPE_NORMAL SCSingleDiscoverEditionSession* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if (![[SCAppDelPrefs sharedInstance] scDisableScreenshotReport]) {
        _logos_orig$SNAP_HOOK$SCSingleDiscoverEditionSession$userDidTakeScreenshot(self, _cmd);
    }
}


static void _logos_method$SNAP_HOOK$SCSnapPlayController$userDidTakeScreenshot(_LOGOS_SELF_TYPE_NORMAL SCSnapPlayController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if (![[SCAppDelPrefs sharedInstance] scDisableScreenshotReport]) {
        _logos_orig$SNAP_HOOK$SCSnapPlayController$userDidTakeScreenshot(self, _cmd);
    }
}


static void _logos_method$SNAP_HOOK$SCDiscoverLogger$logScreenshot(_LOGOS_SELF_TYPE_NORMAL SCDiscoverLogger* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if (![[SCAppDelPrefs sharedInstance] scDisableScreenshotReport]) {
        _logos_orig$SNAP_HOOK$SCDiscoverLogger$logScreenshot(self, _cmd);
    }
}


static void _logos_method$SNAP_HOOK$SCChatViewControllerV3$userDidTakeScreenshot(_LOGOS_SELF_TYPE_NORMAL SCChatViewControllerV3* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if (![[SCAppDelPrefs sharedInstance] scDisableScreenshotReport]) {
        _logos_orig$SNAP_HOOK$SCChatViewControllerV3$userDidTakeScreenshot(self, _cmd);
    }
}


static void _logos_method$SNAP_HOOK$SCChatViewControllerV2$userDidTakeScreenshot(_LOGOS_SELF_TYPE_NORMAL SCChatViewControllerV2* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if (![[SCAppDelPrefs sharedInstance] scDisableScreenshotReport]) {
        _logos_orig$SNAP_HOOK$SCChatViewControllerV2$userDidTakeScreenshot(self, _cmd);
    }
}


static void _logos_method$SNAP_HOOK$SCChatViewController$userDidTakeScreenshot(_LOGOS_SELF_TYPE_NORMAL SCChatViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if (![[SCAppDelPrefs sharedInstance] scDisableScreenshotReport]) {
        _logos_orig$SNAP_HOOK$SCChatViewController$userDidTakeScreenshot(self, _cmd);
    }
}


static void _logos_method$SNAP_HOOK$SCFeedViewController$userDidTakeScreenshot(_LOGOS_SELF_TYPE_NORMAL SCFeedViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if (![[SCAppDelPrefs sharedInstance] scDisableScreenshotReport]) {
        _logos_orig$SNAP_HOOK$SCFeedViewController$userDidTakeScreenshot(self, _cmd);
    }
}


static void _logos_method$SNAP_HOOK$FeedViewController$userDidTakeScreenshot(_LOGOS_SELF_TYPE_NORMAL FeedViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if (![[SCAppDelPrefs sharedInstance] scDisableScreenshotReport]) {
        _logos_orig$SNAP_HOOK$FeedViewController$userDidTakeScreenshot(self, _cmd);
    }
}


static void _logos_method$SNAP_HOOK$SCStoriesViewController$userDidTakeScreenshot(_LOGOS_SELF_TYPE_NORMAL SCStoriesViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if (![[SCAppDelPrefs sharedInstance] scDisableScreenshotReport]) {
        _logos_orig$SNAP_HOOK$SCStoriesViewController$userDidTakeScreenshot(self, _cmd);
    }
}


static void _logos_method$SNAP_HOOK$SCLocationDataFetcher$_retryFetchDataForLocation$delay$context$trigger$(_LOGOS_SELF_TYPE_NORMAL SCLocationDataFetcher* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, double arg2, long long arg3, long long arg4) {
    
    if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
        arg1 = [[SCAppDelPrefs sharedInstance] location];
    }
    _logos_orig$SNAP_HOOK$SCLocationDataFetcher$_retryFetchDataForLocation$delay$context$trigger$(self, _cmd, arg1, arg2, arg3, arg4);
}
static void _logos_method$SNAP_HOOK$SCLocationDataFetcher$retryFetchDataForLocation$delay$(_LOGOS_SELF_TYPE_NORMAL SCLocationDataFetcher* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, double arg2) {
    if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
        arg1 = [[SCAppDelPrefs sharedInstance] location];
    }
    _logos_orig$SNAP_HOOK$SCLocationDataFetcher$retryFetchDataForLocation$delay$(self, _cmd, arg1, arg2);
}
static void _logos_method$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$context$trigger$(_LOGOS_SELF_TYPE_NORMAL SCLocationDataFetcher* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, long long arg2, long long arg3) {
    if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
        arg1 = [[SCAppDelPrefs sharedInstance] location];
    }
    _logos_orig$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$context$trigger$(self, _cmd, arg1, arg2, arg3);
}
static void _logos_method$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$(_LOGOS_SELF_TYPE_NORMAL SCLocationDataFetcher* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
    if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
        arg1 = [[SCAppDelPrefs sharedInstance] location];
    }
    _logos_orig$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$(self, _cmd, arg1);
}
static void _logos_method$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$sensitivity$context$trigger$retryId$(_LOGOS_SELF_TYPE_NORMAL SCLocationDataFetcher* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2, long long arg3, long long arg4, double arg5) {
    if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
        arg1 = [[SCAppDelPrefs sharedInstance] location];
    }
    _logos_orig$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$sensitivity$context$trigger$retryId$(self, _cmd, arg1, arg2, arg3, arg4, arg5);
}
static void _logos_method$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$sensitivity$context$trigger$(_LOGOS_SELF_TYPE_NORMAL SCLocationDataFetcher* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2, long long arg3, long long arg4) {
    if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
        arg1 = [[SCAppDelPrefs sharedInstance] location];
    }
    _logos_orig$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$sensitivity$context$trigger$(self, _cmd, arg1, arg2, arg3, arg4);
}
static void _logos_method$SNAP_HOOK$SCLocationDataFetcher$_retryFetchDataForLocation$delay$sensitivity$context$trigger$retryId$(_LOGOS_SELF_TYPE_NORMAL SCLocationDataFetcher* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, double arg2, id arg3, long long arg4, long long arg5, double arg6) {
    if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
        arg1 = [[SCAppDelPrefs sharedInstance] location];
    }
    _logos_orig$SNAP_HOOK$SCLocationDataFetcher$_retryFetchDataForLocation$delay$sensitivity$context$trigger$retryId$(self, _cmd, arg1, arg2, arg3, arg4, arg5, arg6);
}
static void _logos_method$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$sensitivity$context$trigger$referenceId$retryId$(_LOGOS_SELF_TYPE_NORMAL SCLocationDataFetcher* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2, long long arg3, long long arg4, id arg5, double arg6) {
    if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
        arg1 = [[SCAppDelPrefs sharedInstance] location];
    }
    _logos_orig$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$sensitivity$context$trigger$referenceId$retryId$(self, _cmd, arg1, arg2, arg3, arg4, arg5, arg6);
}
static void _logos_method$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$sensitivity$context$trigger$referenceId$(_LOGOS_SELF_TYPE_NORMAL SCLocationDataFetcher* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2, long long arg3, long long arg4, id arg5) {
    if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
        arg1 = [[SCAppDelPrefs sharedInstance] location];
    }
    _logos_orig$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$sensitivity$context$trigger$referenceId$(self, _cmd, arg1, arg2, arg3, arg4, arg5);
}
static void _logos_method$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$gtqMigrationSetting$sensitivity$context$trigger$referenceId$retryId$(_LOGOS_SELF_TYPE_NORMAL SCLocationDataFetcher* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, unsigned long long arg2, id arg3, long long arg4, long long arg5, id arg6, double arg7) {
    if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
        arg1 = [[SCAppDelPrefs sharedInstance] location];
    }
    _logos_orig$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$gtqMigrationSetting$sensitivity$context$trigger$referenceId$retryId$(self, _cmd, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
}
static void _logos_method$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$gtqMigrationSetting$sensitivity$context$trigger$referenceId$(_LOGOS_SELF_TYPE_NORMAL SCLocationDataFetcher* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, unsigned long long arg2, id arg3, long long arg4, long long arg5, id arg6) {
    if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
        arg1 = [[SCAppDelPrefs sharedInstance] location];
    }
    _logos_orig$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$gtqMigrationSetting$sensitivity$context$trigger$referenceId$(self, _cmd, arg1, arg2, arg3, arg4, arg5, arg6);
}


static void _logos_method$SNAP_HOOK$SCLocationPreCacheFetcher$retryFetchDataForLocation$delay$(_LOGOS_SELF_TYPE_NORMAL SCLocationPreCacheFetcher* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, double arg2) {
    if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
        arg1 = [[SCAppDelPrefs sharedInstance] location];
    }
    _logos_orig$SNAP_HOOK$SCLocationPreCacheFetcher$retryFetchDataForLocation$delay$(self, _cmd, arg1, arg2);
}
static void _logos_method$SNAP_HOOK$SCLocationPreCacheFetcher$fetchDataForLocation$(_LOGOS_SELF_TYPE_NORMAL SCLocationPreCacheFetcher* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
    if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
        arg1 = [[SCAppDelPrefs sharedInstance] location];
    }
    _logos_orig$SNAP_HOOK$SCLocationPreCacheFetcher$fetchDataForLocation$(self, _cmd, arg1);
}
static void _logos_method$SNAP_HOOK$SCLocationPreCacheFetcher$fetchDataForLocationInternal$(_LOGOS_SELF_TYPE_NORMAL SCLocationPreCacheFetcher* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
    if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
        arg1 = [[SCAppDelPrefs sharedInstance] location];
    }
    _logos_orig$SNAP_HOOK$SCLocationPreCacheFetcher$fetchDataForLocationInternal$(self, _cmd, arg1);
}


static void _logos_method$SNAP_HOOK$SCLocationSharedStoriesController$updateCacheWithLocation$newSession$(_LOGOS_SELF_TYPE_NORMAL SCLocationSharedStoriesController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, _Bool arg2) {
    if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
        arg1 = [[SCAppDelPrefs sharedInstance] location];
    }
    _logos_orig$SNAP_HOOK$SCLocationSharedStoriesController$updateCacheWithLocation$newSession$(self, _cmd, arg1, arg2);
}


static void _logos_method$SNAP_HOOK$SCLocationAdldentityController$updateCacheWithLocation$newSession$(_LOGOS_SELF_TYPE_NORMAL SCLocationAdldentityController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, _Bool arg2) {
    if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
        arg1 = [[SCAppDelPrefs sharedInstance] location];
    }
    _logos_orig$SNAP_HOOK$SCLocationAdldentityController$updateCacheWithLocation$newSession$(self, _cmd, arg1, arg2);
}


static void _logos_method$SNAP_HOOK$SCLocationMobStoriesController$updateCacheWithLocation$newSession$(_LOGOS_SELF_TYPE_NORMAL SCLocationMobStoriesController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, _Bool arg2) {
    if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
        arg1 = [[SCAppDelPrefs sharedInstance] location];
    }
    _logos_orig$SNAP_HOOK$SCLocationMobStoriesController$updateCacheWithLocation$newSession$(self, _cmd, arg1, arg2);
}


static void _logos_method$SNAP_HOOK$SCLocationWeatherController$updateCacheWithLocation$newSession$(_LOGOS_SELF_TYPE_NORMAL SCLocationWeatherController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, _Bool arg2) {
    if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
        arg1 = [[SCAppDelPrefs sharedInstance] location];
    }
    _logos_orig$SNAP_HOOK$SCLocationWeatherController$updateCacheWithLocation$newSession$(self, _cmd, arg1, arg2);
}


static void _logos_method$SNAP_HOOK$SCLocationUnlockablesController$updateCacheWithLocation$newSession$(_LOGOS_SELF_TYPE_NORMAL SCLocationUnlockablesController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, _Bool arg2) {
    if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
        arg1 = [[SCAppDelPrefs sharedInstance] location];
    }
    _logos_orig$SNAP_HOOK$SCLocationUnlockablesController$updateCacheWithLocation$newSession$(self, _cmd, arg1, arg2);
}



static CLLocation * _logos_method$SNAP_HOOK$SCLocationController$lastLocation(_LOGOS_SELF_TYPE_NORMAL SCLocationController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    
    if (shouldHookLastLocation && [[SCAppDelPrefs sharedInstance] locationEnabled]) {
        return [[SCAppDelPrefs sharedInstance] location];
    }
    return _logos_orig$SNAP_HOOK$SCLocationController$lastLocation(self, _cmd);
}


static void _logos_method$SNAP_HOOK$SCGroupStoryPrepostViewController$viewWillAppear$(_LOGOS_SELF_TYPE_NORMAL SCGroupStoryPrepostViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, _Bool arg1) {
    
    _logos_orig$SNAP_HOOK$SCGroupStoryPrepostViewController$viewWillAppear$(self, _cmd, arg1);
    
    shouldHookLastLocation = YES;
}
static void _logos_method$SNAP_HOOK$SCGroupStoryPrepostViewController$viewWillDisappear$(_LOGOS_SELF_TYPE_NORMAL SCGroupStoryPrepostViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, _Bool arg1) {
    
    _logos_orig$SNAP_HOOK$SCGroupStoryPrepostViewController$viewWillDisappear$(self, _cmd, arg1);
    
    shouldHookLastLocation = NO;
}
static void _logos_method$SNAP_HOOK$SCGroupStoryPrepostViewController$viewDidAppear$(_LOGOS_SELF_TYPE_NORMAL SCGroupStoryPrepostViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, _Bool arg1) {
    
    _logos_orig$SNAP_HOOK$SCGroupStoryPrepostViewController$viewDidAppear$(self, _cmd, arg1);
    if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
        [self _updateLocation];
    }
}



static id _logos_method$SNAP_HOOK$SCMapViewController$userLocation(_LOGOS_SELF_TYPE_NORMAL SCMapViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
        return [[SCAppDelPrefs sharedInstance] location];
    }
    return _logos_orig$SNAP_HOOK$SCMapViewController$userLocation(self, _cmd);
}


static _Bool _logos_method$SNAP_HOOK$SCIdentityTweaks$shouldEnableGeofilterPassport(_LOGOS_SELF_TYPE_NORMAL SCIdentityTweaks* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    return YES;
}


static SCBaseMediaMessage* _logos_method$SNAP_HOOK$SCBaseMediaMessage$initWithSender$recipient$(_LOGOS_SELF_TYPE_INIT SCBaseMediaMessage* __unused self, SEL __unused _cmd, id arg1, id arg2) _LOGOS_RETURN_RETAINED {
    id selfOrig = _logos_orig$SNAP_HOOK$SCBaseMediaMessage$initWithSender$recipient$(self, _cmd, arg1, arg2);
    if ([[SCAppDelPrefs sharedInstance] scAutoSaveMessages]) {
        if (![self isSaved]) {
            [self save];
        }
    }
    return selfOrig;
}
static SCBaseMediaMessage* _logos_method$SNAP_HOOK$SCBaseMediaMessage$initWithUsername$dictionary$(_LOGOS_SELF_TYPE_INIT SCBaseMediaMessage* __unused self, SEL __unused _cmd, id arg1, id arg2) _LOGOS_RETURN_RETAINED {
    id selfOrig = _logos_orig$SNAP_HOOK$SCBaseMediaMessage$initWithUsername$dictionary$(self, _cmd, arg1, arg2);
    if ([[SCAppDelPrefs sharedInstance] scAutoSaveMessages]) {
        if (![self isSaved]) {
            [self save];
        }
    }
    return selfOrig;
}



static SCText* _logos_method$SNAP_HOOK$SCText$initWithSender$recipient$attributedText$(_LOGOS_SELF_TYPE_INIT SCText* __unused self, SEL __unused _cmd, id arg1, id arg2, id arg3) _LOGOS_RETURN_RETAINED {
    id selfOrig = _logos_orig$SNAP_HOOK$SCText$initWithSender$recipient$attributedText$(self, _cmd, arg1, arg2, arg3);
    if ([[SCAppDelPrefs sharedInstance] scAutoSaveMessages]) {
        if (![self isSaved]) {
            [self save];
        }
    }
    return selfOrig;
}
static SCText* _logos_method$SNAP_HOOK$SCText$initWithUsername$dictionary$(_LOGOS_SELF_TYPE_INIT SCText* __unused self, SEL __unused _cmd, id arg1, id arg2) _LOGOS_RETURN_RETAINED {
    id selfOrig = _logos_orig$SNAP_HOOK$SCText$initWithUsername$dictionary$(self, _cmd, arg1, arg2);
    if ([[SCAppDelPrefs sharedInstance] scAutoSaveMessages]) {
        if (![self isSaved]) {
            [self save];
        }
    }
    return selfOrig;
}


static void _logos_method$SNAP_HOOK$SCOperaArrowLayerView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL SCOperaArrowLayerView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    _logos_orig$SNAP_HOOK$SCOperaArrowLayerView$layoutSubviews(self, _cmd);
    [self setUserInteractionEnabled:NO];
}


static void _logos_method$SNAP_HOOK$SCOperaArrowLayerViewController$_didTap$(_LOGOS_SELF_TYPE_NORMAL SCOperaArrowLayerViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
    return;
}



static NSString * _logos_method$SNAP_HOOK$NSBundle$pathForResource$ofType$(_LOGOS_SELF_TYPE_NORMAL NSBundle* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * resourceName, NSString * resourceType) {
    if ([resourceName isEqualToString:@"CLImageEditor"]) {
        NSString *newPath = [[[SCAppDelPrefs sharedInstance] resourcesBundlePath] stringByAppendingPathComponent:@"CLImageEditor.bundle"];
        return newPath;
    }
    return _logos_orig$SNAP_HOOK$NSBundle$pathForResource$ofType$(self, _cmd, resourceName, resourceType);
}


static _Bool _logos_method$SNAP_HOOK$UIApplication$_shouldUseHiResForClassic(_LOGOS_SELF_TYPE_NORMAL UIApplication* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if ([[SCAppDelPrefs sharedInstance] sciPad]) {
        return YES;
    }
    return _logos_orig$SNAP_HOOK$UIApplication$_shouldUseHiResForClassic(self, _cmd);
}
static _Bool _logos_method$SNAP_HOOK$UIApplication$_shouldZoom(_LOGOS_SELF_TYPE_NORMAL UIApplication* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if ([[SCAppDelPrefs sharedInstance] sciPad]) {
        return YES;
    }
    return _logos_orig$SNAP_HOOK$UIApplication$_shouldZoom(self, _cmd);
}
static int _logos_method$SNAP_HOOK$UIApplication$_classicMode(_LOGOS_SELF_TYPE_NORMAL UIApplication* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if ([[SCAppDelPrefs sharedInstance] sciPad]) {
        return NO;
    }
    return _logos_orig$SNAP_HOOK$UIApplication$_classicMode(self, _cmd);
}
static void _logos_method$SNAP_HOOK$UIApplication$_setClassicMode$(_LOGOS_SELF_TYPE_NORMAL UIApplication* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, int arg1) {
    if ([[SCAppDelPrefs sharedInstance] sciPad]) {
        arg1 = NO;
    }
    _logos_orig$SNAP_HOOK$UIApplication$_setClassicMode$(self, _cmd, arg1);
}



static SCOperaPage* (*_logos_orig$STORY_HOOK$SCOperaPage$initWithProperties$)(_LOGOS_SELF_TYPE_INIT SCOperaPage*, SEL, id) _LOGOS_RETURN_RETAINED; static SCOperaPage* _logos_method$STORY_HOOK$SCOperaPage$initWithProperties$(_LOGOS_SELF_TYPE_INIT SCOperaPage*, SEL, id) _LOGOS_RETURN_RETAINED; static SCStoriesViewController* (*_logos_orig$STORY_HOOK$SCStoriesViewController$initWithUserSession$)(_LOGOS_SELF_TYPE_INIT SCStoriesViewController*, SEL, id) _LOGOS_RETURN_RETAINED; static SCStoriesViewController* _logos_method$STORY_HOOK$SCStoriesViewController$initWithUserSession$(_LOGOS_SELF_TYPE_INIT SCStoriesViewController*, SEL, id) _LOGOS_RETURN_RETAINED; static _Bool (*_logos_orig$STORY_HOOK$SCStoriesViewController$_shouldNotShowTilesSection)(_LOGOS_SELF_TYPE_NORMAL SCStoriesViewController* _LOGOS_SELF_CONST, SEL); static _Bool _logos_method$STORY_HOOK$SCStoriesViewController$_shouldNotShowTilesSection(_LOGOS_SELF_TYPE_NORMAL SCStoriesViewController* _LOGOS_SELF_CONST, SEL); static id _logos_method$STORY_HOOK$SCStoriesViewController$valueForUndefinedKey$(_LOGOS_SELF_TYPE_NORMAL SCStoriesViewController* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$STORY_HOOK$SCOperaPageViewController$_addChildLayerVC$)(_LOGOS_SELF_TYPE_NORMAL SCOperaPageViewController* _LOGOS_SELF_CONST, SEL, SCOperaPageViewController *); static void _logos_method$STORY_HOOK$SCOperaPageViewController$_addChildLayerVC$(_LOGOS_SELF_TYPE_NORMAL SCOperaPageViewController* _LOGOS_SELF_CONST, SEL, SCOperaPageViewController *); static SCSingleFriendStoriesViewingSession * _logos_method$STORY_HOOK$SCOperaPageViewController$sc_currentFriendStoriesViewingSession(_LOGOS_SELF_TYPE_NORMAL SCOperaPageViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$STORY_HOOK$SCOperaPageViewController$snapAppDelDidPressSave(_LOGOS_SELF_TYPE_NORMAL SCOperaPageViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$STORY_HOOK$SCOperaPageViewController$snapAppDelDidPressMarkAsRead(_LOGOS_SELF_TYPE_NORMAL SCOperaPageViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$STORY_HOOK$SCOperaPageViewController$viewDidAppear$)(_LOGOS_SELF_TYPE_NORMAL SCOperaPageViewController* _LOGOS_SELF_CONST, SEL, _Bool); static void _logos_method$STORY_HOOK$SCOperaPageViewController$viewDidAppear$(_LOGOS_SELF_TYPE_NORMAL SCOperaPageViewController* _LOGOS_SELF_CONST, SEL, _Bool); static void (*_logos_orig$STORY_HOOK$SCOperaPageViewController$didUpdateBottomPageViewProperties$)(_LOGOS_SELF_TYPE_NORMAL SCOperaPageViewController* _LOGOS_SELF_CONST, SEL, NSDictionary *); static void _logos_method$STORY_HOOK$SCOperaPageViewController$didUpdateBottomPageViewProperties$(_LOGOS_SELF_TYPE_NORMAL SCOperaPageViewController* _LOGOS_SELF_CONST, SEL, NSDictionary *); static void (*_logos_orig$STORY_HOOK$SCOperaPageViewController$updatePropertiesWithLooping$)(_LOGOS_SELF_TYPE_NORMAL SCOperaPageViewController* _LOGOS_SELF_CONST, SEL, _Bool); static void _logos_method$STORY_HOOK$SCOperaPageViewController$updatePropertiesWithLooping$(_LOGOS_SELF_TYPE_NORMAL SCOperaPageViewController* _LOGOS_SELF_CONST, SEL, _Bool); static void (*_logos_orig$STORY_HOOK$SCOperaPageViewController$didUpdateViewProperties$)(_LOGOS_SELF_TYPE_NORMAL SCOperaPageViewController* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$STORY_HOOK$SCOperaPageViewController$didUpdateViewProperties$(_LOGOS_SELF_TYPE_NORMAL SCOperaPageViewController* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$STORY_HOOK$SCOperaPageViewController$ua_updateTimerIfNeeded(_LOGOS_SELF_TYPE_NORMAL SCOperaPageViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$STORY_HOOK$SCOperaImageLayerViewController$snapAppDelDidPressSave(_LOGOS_SELF_TYPE_NORMAL SCOperaImageLayerViewController* _LOGOS_SELF_CONST, SEL); static CircleProgressBarHandler * _logos_method$STORY_HOOK$SCOperaImageLayerViewController$circleProgressBarHandler(_LOGOS_SELF_TYPE_NORMAL SCOperaImageLayerViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$STORY_HOOK$SCOperaImageLayerViewController$setCircleProgressBarHandler$(_LOGOS_SELF_TYPE_NORMAL SCOperaImageLayerViewController* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$STORY_HOOK$SCOperaImageLayerViewController$createCircleProgressBarIfNeeded(_LOGOS_SELF_TYPE_NORMAL SCOperaImageLayerViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$STORY_HOOK$SCSingleFriendStoriesViewingSession$_markStoryAsViewedWithStory$)(_LOGOS_SELF_TYPE_NORMAL SCSingleFriendStoriesViewingSession* _LOGOS_SELF_CONST, SEL, Story *); static void _logos_method$STORY_HOOK$SCSingleFriendStoriesViewingSession$_markStoryAsViewedWithStory$(_LOGOS_SELF_TYPE_NORMAL SCSingleFriendStoriesViewingSession* _LOGOS_SELF_CONST, SEL, Story *); static void (*_logos_orig$STORY_HOOK$SCBaseMediaOperaPresenter$operaViewDidSendEvent$context$params$)(_LOGOS_SELF_TYPE_NORMAL SCBaseMediaOperaPresenter* _LOGOS_SELF_CONST, SEL, id, id, id); static void _logos_method$STORY_HOOK$SCBaseMediaOperaPresenter$operaViewDidSendEvent$context$params$(_LOGOS_SELF_TYPE_NORMAL SCBaseMediaOperaPresenter* _LOGOS_SELF_CONST, SEL, id, id, id); static id (*_logos_orig$STORY_HOOK$Story$viewedJsonDictionary)(_LOGOS_SELF_TYPE_NORMAL Story* _LOGOS_SELF_CONST, SEL); static id _logos_method$STORY_HOOK$Story$viewedJsonDictionary(_LOGOS_SELF_TYPE_NORMAL Story* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$STORY_HOOK$SCTwoRowsTilesViewController$setRegularTiles$collapsedTiles$reloadTilePosition$)(_LOGOS_SELF_TYPE_NORMAL SCTwoRowsTilesViewController* _LOGOS_SELF_CONST, SEL, id, id, _Bool); static void _logos_method$STORY_HOOK$SCTwoRowsTilesViewController$setRegularTiles$collapsedTiles$reloadTilePosition$(_LOGOS_SELF_TYPE_NORMAL SCTwoRowsTilesViewController* _LOGOS_SELF_CONST, SEL, id, id, _Bool); static _Bool (*_logos_orig$STORY_HOOK$Manager$discoverContentDisabled)(_LOGOS_SELF_TYPE_NORMAL Manager* _LOGOS_SELF_CONST, SEL); static _Bool _logos_method$STORY_HOOK$Manager$discoverContentDisabled(_LOGOS_SELF_TYPE_NORMAL Manager* _LOGOS_SELF_CONST, SEL); static _Bool (*_logos_orig$STORY_HOOK$MainViewController$canPullDownToSearch)(_LOGOS_SELF_TYPE_NORMAL MainViewController* _LOGOS_SELF_CONST, SEL); static _Bool _logos_method$STORY_HOOK$MainViewController$canPullDownToSearch(_LOGOS_SELF_TYPE_NORMAL MainViewController* _LOGOS_SELF_CONST, SEL); static _Bool (*_logos_orig$STORY_HOOK$SCBroadcastTweaks$isHideStoriesEnabled)(_LOGOS_SELF_TYPE_NORMAL SCBroadcastTweaks* _LOGOS_SELF_CONST, SEL); static _Bool _logos_method$STORY_HOOK$SCBroadcastTweaks$isHideStoriesEnabled(_LOGOS_SELF_TYPE_NORMAL SCBroadcastTweaks* _LOGOS_SELF_CONST, SEL); static _Bool (*_logos_orig$STORY_HOOK$SCStoryAdInsertionController$canDisplayStoryAd)(_LOGOS_SELF_TYPE_NORMAL SCStoryAdInsertionController* _LOGOS_SELF_CONST, SEL); static _Bool _logos_method$STORY_HOOK$SCStoryAdInsertionController$canDisplayStoryAd(_LOGOS_SELF_TYPE_NORMAL SCStoryAdInsertionController* _LOGOS_SELF_CONST, SEL); static _Bool (*_logos_orig$STORY_HOOK$SCStoryAdInsertionController$isStoryAdOpprtunity)(_LOGOS_SELF_TYPE_NORMAL SCStoryAdInsertionController* _LOGOS_SELF_CONST, SEL); static _Bool _logos_method$STORY_HOOK$SCStoryAdInsertionController$isStoryAdOpprtunity(_LOGOS_SELF_TYPE_NORMAL SCStoryAdInsertionController* _LOGOS_SELF_CONST, SEL); static _Bool (*_logos_orig$STORY_HOOK$SCStoriesAutoAdvanceAdsManager$canShowAd)(_LOGOS_SELF_TYPE_NORMAL SCStoriesAutoAdvanceAdsManager* _LOGOS_SELF_CONST, SEL); static _Bool _logos_method$STORY_HOOK$SCStoriesAutoAdvanceAdsManager$canShowAd(_LOGOS_SELF_TYPE_NORMAL SCStoriesAutoAdvanceAdsManager* _LOGOS_SELF_CONST, SEL); static _Bool (*_logos_orig$STORY_HOOK$SCChatTypingHandler$sendingTypingRequest)(_LOGOS_SELF_TYPE_NORMAL SCChatTypingHandler* _LOGOS_SELF_CONST, SEL); static _Bool _logos_method$STORY_HOOK$SCChatTypingHandler$sendingTypingRequest(_LOGOS_SELF_TYPE_NORMAL SCChatTypingHandler* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$STORY_HOOK$SCChatViewControllerV2$viewDidFullyAppearFromStack$)(_LOGOS_SELF_TYPE_NORMAL SCChatViewControllerV2* _LOGOS_SELF_CONST, SEL, _Bool); static void _logos_method$STORY_HOOK$SCChatViewControllerV2$viewDidFullyAppearFromStack$(_LOGOS_SELF_TYPE_NORMAL SCChatViewControllerV2* _LOGOS_SELF_CONST, SEL, _Bool); static void (*_logos_orig$STORY_HOOK$SCChatViewControllerV2$viewDidSwipeIn)(_LOGOS_SELF_TYPE_NORMAL SCChatViewControllerV2* _LOGOS_SELF_CONST, SEL); static void _logos_method$STORY_HOOK$SCChatViewControllerV2$viewDidSwipeIn(_LOGOS_SELF_TYPE_NORMAL SCChatViewControllerV2* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$STORY_HOOK$SCChatViewControllerV3$viewDidFullyAppearFromStack$)(_LOGOS_SELF_TYPE_NORMAL SCChatViewControllerV3* _LOGOS_SELF_CONST, SEL, _Bool); static void _logos_method$STORY_HOOK$SCChatViewControllerV3$viewDidFullyAppearFromStack$(_LOGOS_SELF_TYPE_NORMAL SCChatViewControllerV3* _LOGOS_SELF_CONST, SEL, _Bool); static void (*_logos_orig$STORY_HOOK$SCChatViewControllerV3$viewDidSwipeIn)(_LOGOS_SELF_TYPE_NORMAL SCChatViewControllerV3* _LOGOS_SELF_CONST, SEL); static void _logos_method$STORY_HOOK$SCChatViewControllerV3$viewDidSwipeIn(_LOGOS_SELF_TYPE_NORMAL SCChatViewControllerV3* _LOGOS_SELF_CONST, SEL); static _Bool (*_logos_orig$STORY_HOOK$SCCaptionDefaultTextView$textView$shouldChangeTextInRange$replacementText$)(_LOGOS_SELF_TYPE_NORMAL SCCaptionDefaultTextView* _LOGOS_SELF_CONST, SEL, id, struct _NSRange, id); static _Bool _logos_method$STORY_HOOK$SCCaptionDefaultTextView$textView$shouldChangeTextInRange$replacementText$(_LOGOS_SELF_TYPE_NORMAL SCCaptionDefaultTextView* _LOGOS_SELF_CONST, SEL, id, struct _NSRange, id); static _Bool (*_logos_orig$STORY_HOOK$SCCaptionBigTextPlusView$textView$shouldChangeTextInRange$replacementText$)(_LOGOS_SELF_TYPE_NORMAL SCCaptionBigTextPlusView* _LOGOS_SELF_CONST, SEL, id, struct _NSRange, id); static _Bool _logos_method$STORY_HOOK$SCCaptionBigTextPlusView$textView$shouldChangeTextInRange$replacementText$(_LOGOS_SELF_TYPE_NORMAL SCCaptionBigTextPlusView* _LOGOS_SELF_CONST, SEL, id, struct _NSRange, id); static void (*_logos_orig$STORY_HOOK$EphemeralMedia$setInfiniteDuration$)(_LOGOS_SELF_TYPE_NORMAL EphemeralMedia* _LOGOS_SELF_CONST, SEL, _Bool); static void _logos_method$STORY_HOOK$EphemeralMedia$setInfiniteDuration$(_LOGOS_SELF_TYPE_NORMAL EphemeralMedia* _LOGOS_SELF_CONST, SEL, _Bool); static _Bool (*_logos_orig$STORY_HOOK$SCStoriesConfiguration$shouldShowStoriesTimerForHoldoutGroup)(_LOGOS_SELF_TYPE_NORMAL SCStoriesConfiguration* _LOGOS_SELF_CONST, SEL); static _Bool _logos_method$STORY_HOOK$SCStoriesConfiguration$shouldShowStoriesTimerForHoldoutGroup(_LOGOS_SELF_TYPE_NORMAL SCStoriesConfiguration* _LOGOS_SELF_CONST, SEL); static CircleProgressBarHandler * _logos_method$STORY_HOOK$SCOperaVideoLayerViewController$circleProgressBarHandler(_LOGOS_SELF_TYPE_NORMAL SCOperaVideoLayerViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$STORY_HOOK$SCOperaVideoLayerViewController$setCircleProgressBarHandler$(_LOGOS_SELF_TYPE_NORMAL SCOperaVideoLayerViewController* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$STORY_HOOK$SCOperaVideoLayerViewController$createCircleProgressBarIfNeeded(_LOGOS_SELF_TYPE_NORMAL SCOperaVideoLayerViewController* _LOGOS_SELF_CONST, SEL); 

static SCOperaPage* _logos_method$STORY_HOOK$SCOperaPage$initWithProperties$(_LOGOS_SELF_TYPE_INIT SCOperaPage* __unused self, SEL __unused _cmd, id arg1) _LOGOS_RETURN_RETAINED {
    
    return _logos_orig$STORY_HOOK$SCOperaPage$initWithProperties$(self, _cmd, arg1);
}


static SCStoriesViewController* _logos_method$STORY_HOOK$SCStoriesViewController$initWithUserSession$(_LOGOS_SELF_TYPE_INIT SCStoriesViewController* __unused self, SEL __unused _cmd, id arg1) _LOGOS_RETURN_RETAINED {
    id selfOrig = _logos_orig$STORY_HOOK$SCStoriesViewController$initWithUserSession$(self, _cmd, arg1);
    storiesViewController = self;
    
    return selfOrig;
}
static _Bool _logos_method$STORY_HOOK$SCStoriesViewController$_shouldNotShowTilesSection(_LOGOS_SELF_TYPE_NORMAL SCStoriesViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if ([[SCAppDelPrefs sharedInstance] scHideDiscover]) {
        return YES;
    }
    return _logos_orig$STORY_HOOK$SCStoriesViewController$_shouldNotShowTilesSection(self, _cmd);
}

static id _logos_method$STORY_HOOK$SCStoriesViewController$valueForUndefinedKey$(_LOGOS_SELF_TYPE_NORMAL SCStoriesViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
    return nil;
}


@interface SCOperaPageViewController ()
- (SCSingleFriendStoriesViewingSession *)sc_currentFriendStoriesViewingSession;
- (void)ua_updateTimerIfNeeded;
@end

@interface SCOperaVideoLayerViewController ()
- (CircleProgressBarHandler *)circleProgressBarHandler;
- (void)setCircleProgressBarHandler:(id)arg1;
- (void)createCircleProgressBarIfNeeded;
@end

@interface SCOperaImageLayerViewController ()
- (void)snapAppDelDidPressSave;
- (CircleProgressBarHandler *)circleProgressBarHandler;
- (void)setCircleProgressBarHandler:(id)arg1;
- (void)createCircleProgressBarIfNeeded;
@end


static void _logos_method$STORY_HOOK$SCOperaPageViewController$_addChildLayerVC$(_LOGOS_SELF_TYPE_NORMAL SCOperaPageViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, SCOperaPageViewController * arg1) {
    BOOL scEnableStoryControls = [[SCAppDelPrefs sharedInstance] scEnableStoryControls];
    BOOL scDisableAutoMarkViewed = [[SCAppDelPrefs sharedInstance] scDisableAutoMarkViewed];
    BOOL scSnapSaveButton = [[SCAppDelPrefs sharedInstance] scSnapSaveButton];
    BOOL scEnableSnapControls = [[SCAppDelPrefs sharedInstance] scEnableSnapControls];
    
    if (!scEnableStoryControls && !scDisableAutoMarkViewed && !scSnapSaveButton && !scEnableSnapControls) {
        _logos_orig$STORY_HOOK$SCOperaPageViewController$_addChildLayerVC$(self, _cmd, arg1);
    }
    
    NSDictionary *properties = [[arg1 page] properties];
    Story *story = [properties objectForKey:@"story"];
    NSString *_Id = nil;
    BOOL ischatMedia = NO;
    if ([properties objectForKey:@"id"]) {
        _Id = [properties objectForKey:@"id"];
        ischatMedia = [_Id containsString:@"chatmedia-"];
    }
    
    BOOL isUsernameEqual = NO;
    if (story) {
        NSString *storyUsername = [story username];
        User *user = (User *)[[objc_getClass("Manager") shared] user];
        isUsernameEqual = [storyUsername isEqualToString:[user username]];
    }
    
    BOOL isVideoStory = YES;
    if (![properties objectForKey:@"video_url"]) {
        isVideoStory = [story isVideo];
    }
    
    if (!story) {
        if ([arg1 isKindOfClass:objc_getClass("SCOperaVideoLayerViewController")] || [arg1 isKindOfClass:objc_getClass("SCOperaImageLayerViewController")]) {
            
            UIView *layerView = [arg1 valueForKey:@"_layerView"];
            [layerView setUserInteractionEnabled:YES];
            
            if (scEnableSnapControls && !ischatMedia) {
                int rightInset = 0;
                if (ischatMedia) {
                    rightInset = 50;
                } else {
                    rightInset = 60;
                }
                [layerView snapAppDelAddMarkReadButttonWithRightInset:rightInset bottomInset:40];
                [[layerView snapAppDelMarkReadButton] addTarget:self action:@selector(snapAppDelDidPressMarkAsRead) forControlEvents:64];
                
            }
            
            if (scSnapSaveButton) {
                int rightInset = 0;
                if (ischatMedia) {
                    rightInset = 50;
                } else {
                    rightInset = 12;
                }
                [layerView snapAppDelAddMarkReadButttonWithRightInset:rightInset bottomInset:40];
                [[layerView snapAppDelSaveButton] addTarget:self action:@selector(snapAppDelDidPressSave) forControlEvents:64];
                
            }
        }
        
        if (!isUsernameEqual) {
            if ([arg1 isKindOfClass:objc_getClass("SCOperaVideoLayerViewController")] || [arg1 isKindOfClass:objc_getClass("SCOperaImageLayerViewController")]) {
                UIView *layerView = [arg1 valueForKey:@"_layerView"];
                [layerView setUserInteractionEnabled:YES];
                
                if (scDisableAutoMarkViewed) {
                    [layerView snapAppDelAddMarkReadButttonWithRightInset:60 bottomInset:40];
                    [[layerView snapAppDelMarkReadButton] addTarget:self action:@selector(snapAppDelDidPressMarkAsRead) forControlEvents:64];
                    
                }
                if (scEnableStoryControls) {
                    [layerView snapAppDelAddMarkReadButttonWithRightInset:12 bottomInset:40];
                    [[layerView snapAppDelSaveButton] addTarget:self action:@selector(snapAppDelDidPressSave) forControlEvents:64];
                    
                }
            } else {
                if ([arg1 isKindOfClass:objc_getClass("SCOperaReplyLayerViewController")]) {
                    UIView *layerView = [arg1 valueForKey:@"_layerView"];
                    [layerView setUserInteractionEnabled:YES];
                    
                    if (scDisableAutoMarkViewed) {
                        [layerView snapAppDelAddMarkReadButttonWithRightInset:60 bottomInset:40];
                        [[layerView snapAppDelMarkReadButton] addTarget:self action:@selector(snapAppDelDidPressMarkAsRead) forControlEvents:64];
                        
                    }
                    if (scEnableStoryControls) {
                        [layerView snapAppDelAddMarkReadButttonWithRightInset:12 bottomInset:40];
                        [[layerView snapAppDelSaveButton] addTarget:self action:@selector(snapAppDelDidPressSave) forControlEvents:64];
                    }
                }
            }
        }
    }
}


static SCSingleFriendStoriesViewingSession * _logos_method$STORY_HOOK$SCOperaPageViewController$sc_currentFriendStoriesViewingSession(_LOGOS_SELF_TYPE_NORMAL SCOperaPageViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if ([storiesViewController valueForKeyPath:@"_storyPresenter"]) {
        SCStoriesViewingSession *storiesViewingSession = [[storiesViewController valueForKeyPath:@"_storyPresenter"] valueForKeyPath:@"_storiesViewingSession"];
        return [storiesViewingSession currentFriendStoriesViewingSession];
    } else {
        if ([storiesViewController valueForKeyPath:@"_storiesPlugin"]) {
            SCStoriesViewingSession *storiesViewingSession = [[storiesViewController valueForKeyPath:@"_storiesPlugin"] valueForKeyPath:@"storiesViewingSession"];
            return [storiesViewingSession currentFriendStoriesViewingSession];
        }
    }
    return nil;
}

static void _logos_method$STORY_HOOK$SCOperaPageViewController$snapAppDelDidPressSave(_LOGOS_SELF_TYPE_NORMAL SCOperaPageViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    [SCAppDelOperaSaver saveMediaFromOperaPageViewController:self];
}

static void _logos_method$STORY_HOOK$SCOperaPageViewController$snapAppDelDidPressMarkAsRead(_LOGOS_SELF_TYPE_NORMAL SCOperaPageViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    NSDictionary *properties = [[self page] properties];
    Story *story = [properties objectForKey:@"story"];
    if (story) {
        NSString *storyId = [story _id];
        if (![storiesToMarkRead containsObject:storyId]) {
            [story setViewed:NO];
            [storiesToMarkRead addObject:storyId];
            
            Story *currentStory = [[self sc_currentFriendStoriesViewingSession] currentStory];
            [[self sc_currentFriendStoriesViewingSession] _markStoryAsViewedWithStory:currentStory];
        }
    } else {
        NSString *_Id = [properties objectForKey:@"id"];
        if (_Id && ![groupMediaToMarkRead containsObject:_Id]) {
            [groupMediaToMarkRead addObject:_Id];
        }
    }
    
}
static void _logos_method$STORY_HOOK$SCOperaPageViewController$viewDidAppear$(_LOGOS_SELF_TYPE_NORMAL SCOperaPageViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, _Bool arg1) {
    _logos_orig$STORY_HOOK$SCOperaPageViewController$viewDidAppear$(self, _cmd, arg1);
    if ([[SCAppDelPrefs sharedInstance] scShowStoriesTimer]) {
        [self ua_updateTimerIfNeeded];
    }
}
static void _logos_method$STORY_HOOK$SCOperaPageViewController$didUpdateBottomPageViewProperties$(_LOGOS_SELF_TYPE_NORMAL SCOperaPageViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSDictionary * arg1) {
    _logos_orig$STORY_HOOK$SCOperaPageViewController$didUpdateBottomPageViewProperties$(self, _cmd, arg1);
    if ([[SCAppDelPrefs sharedInstance] scShowStoriesTimer]) {
        [self ua_updateTimerIfNeeded];
    }
}
static void _logos_method$STORY_HOOK$SCOperaPageViewController$updatePropertiesWithLooping$(_LOGOS_SELF_TYPE_NORMAL SCOperaPageViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, _Bool arg1) {
    if ([[SCAppDelPrefs sharedInstance] scShowStoriesTimer]) {
        [self ua_updateTimerIfNeeded];
    }
}
static void _logos_method$STORY_HOOK$SCOperaPageViewController$didUpdateViewProperties$(_LOGOS_SELF_TYPE_NORMAL SCOperaPageViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
    if ([[SCAppDelPrefs sharedInstance] scShowStoriesTimer]) {
        [self ua_updateTimerIfNeeded];
    }
}

static void _logos_method$STORY_HOOK$SCOperaPageViewController$ua_updateTimerIfNeeded(_LOGOS_SELF_TYPE_NORMAL SCOperaPageViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    NSDictionary *properties = [[self page] properties];
    Story *story = [properties objectForKey:@"story"];
    if (story) {
        id layerVCsOnPage = [self _layerVCsOnPage];
        SCOperaVideoLayerViewController *layerVCForLayerTyp = [self _layerVCForLayerType:6 inLayerVCs:layerVCsOnPage];
        if (layerVCForLayerTyp) {
            if ([story time] <= 0) {
                CircleProgressBarHandler *circleProgressBarHandler = [layerVCForLayerTyp circleProgressBarHandler];
                UIView *circleView = [circleProgressBarHandler circleView];
                [circleView setHidden:YES];
                
            } else {
                [layerVCForLayerTyp createCircleProgressBarIfNeeded];
                CircleProgressBarHandler *circleProgressBarHandler = [layerVCForLayerTyp circleProgressBarHandler];
                [circleProgressBarHandler startTimerWithSeconds:[story time]];
            }
        }
        
        id layerVCsOnPage2 = [self _layerVCsOnPage];
        SCOperaImageLayerViewController *layerVCForLayerTyp2 = [self _layerVCForLayerType:1 inLayerVCs:layerVCsOnPage2];
        
        if (layerVCForLayerTyp2) {
            if ([story time] <= 0) {
                CircleProgressBarHandler *circleProgressBarHandler = [layerVCForLayerTyp2 circleProgressBarHandler];
                UIView *circleView = [circleProgressBarHandler circleView];
                [circleView setHidden:YES];
                
            } else {
                [layerVCForLayerTyp2 createCircleProgressBarIfNeeded];
                CircleProgressBarHandler *circleProgressBarHandler = [layerVCForLayerTyp2 circleProgressBarHandler];
                [circleProgressBarHandler startTimerWithSeconds:[story time]];
            }
        }
        
    }
    
}





static void _logos_method$STORY_HOOK$SCOperaImageLayerViewController$snapAppDelDidPressSave(_LOGOS_SELF_TYPE_NORMAL SCOperaImageLayerViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    UIImage *image = [[self shareableMedia] image];
    if (image) {
        [SCAppDelSaver handleImageSave:image fromController:self completion:nil];
    }
}

static CircleProgressBarHandler * _logos_method$STORY_HOOK$SCOperaImageLayerViewController$circleProgressBarHandler(_LOGOS_SELF_TYPE_NORMAL SCOperaImageLayerViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    return objc_getAssociatedObject(self, @selector(circleProgressBarHandler));
}

static void _logos_method$STORY_HOOK$SCOperaImageLayerViewController$setCircleProgressBarHandler$(_LOGOS_SELF_TYPE_NORMAL SCOperaImageLayerViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
    objc_setAssociatedObject(self, @selector(circleProgressBarHandler), arg1, 1);
}

static void _logos_method$STORY_HOOK$SCOperaImageLayerViewController$createCircleProgressBarIfNeeded(_LOGOS_SELF_TYPE_NORMAL SCOperaImageLayerViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if (![self circleProgressBarHandler]) {
        self.circleProgressBarHandler = [[CircleProgressBarHandler alloc] initWithCircleFrame:CGRectMake(0, 0, 19, 19)];
        [[self view] addSubview:self.circleProgressBarHandler.circleView];
        [self.circleProgressBarHandler.circleView autoPinEdgeToSuperviewEdge:2 withInset:37];
        [self.circleProgressBarHandler.circleView autoPinEdgeToSuperviewEdge:3 withInset:17];
        [self.circleProgressBarHandler.circleView autoSetDimensionsToSize:CGSizeMake(19.0, 19.0)];
        [self.circleProgressBarHandler.circleView setHidden:NO];
        
    }
}


static void _logos_method$STORY_HOOK$SCSingleFriendStoriesViewingSession$_markStoryAsViewedWithStory$(_LOGOS_SELF_TYPE_NORMAL SCSingleFriendStoriesViewingSession* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, Story * arg1) {
    
    if ([[SCAppDelPrefs sharedInstance] scDisableAutoMarkViewed]) {
        NSString *storyId = [arg1 _id];
        if (storyId) {
            if ([storiesToMarkRead containsObject:storyId]) {
                [storiesToMarkRead removeObject:storyId];
                _logos_orig$STORY_HOOK$SCSingleFriendStoriesViewingSession$_markStoryAsViewedWithStory$(self, _cmd, arg1);
            } else {
                [arg1 setViewed:YES];
            }
        }
    } else {
        _logos_orig$STORY_HOOK$SCSingleFriendStoriesViewingSession$_markStoryAsViewedWithStory$(self, _cmd, arg1);
    }
}


static void _logos_method$STORY_HOOK$SCBaseMediaOperaPresenter$operaViewDidSendEvent$context$params$(_LOGOS_SELF_TYPE_NORMAL SCBaseMediaOperaPresenter* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2, id arg3) {
    if (![[SCAppDelPrefs sharedInstance] scEnableSnapControls]) {
        _logos_orig$STORY_HOOK$SCBaseMediaOperaPresenter$operaViewDidSendEvent$context$params$(self, _cmd, arg1, arg2, arg3);
    } else if ([arg1 isEqualToString:@"close_view"] || [arg1 isEqualToString:@"open_view_loaded"] || [arg1 isEqualToString:@"media_starts_to_display"]) {
        NSString *contextId = [arg2 objectForKey:@"id"];
        if ([groupMediaToMarkRead containsObject:contextId]) {
            
        }
    } else {
        _logos_orig$STORY_HOOK$SCBaseMediaOperaPresenter$operaViewDidSendEvent$context$params$(self, _cmd, arg1, arg2, arg3);
    }
}


static id _logos_method$STORY_HOOK$Story$viewedJsonDictionary(_LOGOS_SELF_TYPE_NORMAL Story* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    
    return _logos_orig$STORY_HOOK$Story$viewedJsonDictionary(self, _cmd);
}


static void _logos_method$STORY_HOOK$SCTwoRowsTilesViewController$setRegularTiles$collapsedTiles$reloadTilePosition$(_LOGOS_SELF_TYPE_NORMAL SCTwoRowsTilesViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2, _Bool arg3) {
    if ([[SCAppDelPrefs sharedInstance] scHideDiscover]) {
        arg3 = NO;
    }
    _logos_orig$STORY_HOOK$SCTwoRowsTilesViewController$setRegularTiles$collapsedTiles$reloadTilePosition$(self, _cmd, arg1, arg2, arg3);
}


static _Bool _logos_method$STORY_HOOK$Manager$discoverContentDisabled(_LOGOS_SELF_TYPE_NORMAL Manager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if ([[SCAppDelPrefs sharedInstance] scHideDiscover]) {
        return YES;
    }
    return _logos_orig$STORY_HOOK$Manager$discoverContentDisabled(self, _cmd);
}


static _Bool _logos_method$STORY_HOOK$MainViewController$canPullDownToSearch(_LOGOS_SELF_TYPE_NORMAL MainViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if ([[SCAppDelPrefs sharedInstance] scHideDiscover]) {
        return NO;
    }
    return _logos_orig$STORY_HOOK$MainViewController$canPullDownToSearch(self, _cmd);
}


static _Bool _logos_method$STORY_HOOK$SCBroadcastTweaks$isHideStoriesEnabled(_LOGOS_SELF_TYPE_NORMAL SCBroadcastTweaks* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if ([[SCAppDelPrefs sharedInstance] scHideDiscover]) {
        return YES;
    }
    return _logos_orig$STORY_HOOK$SCBroadcastTweaks$isHideStoriesEnabled(self, _cmd);
}


static _Bool _logos_method$STORY_HOOK$SCStoryAdInsertionController$canDisplayStoryAd(_LOGOS_SELF_TYPE_NORMAL SCStoryAdInsertionController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if ([[SCAppDelPrefs sharedInstance] scHideDiscover]) {
        return NO;
    }
    return _logos_orig$STORY_HOOK$SCStoryAdInsertionController$canDisplayStoryAd(self, _cmd);
}
static _Bool _logos_method$STORY_HOOK$SCStoryAdInsertionController$isStoryAdOpprtunity(_LOGOS_SELF_TYPE_NORMAL SCStoryAdInsertionController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if ([[SCAppDelPrefs sharedInstance] scHideDiscover]) {
        return NO;
    }
    return _logos_orig$STORY_HOOK$SCStoryAdInsertionController$isStoryAdOpprtunity(self, _cmd);
}


static _Bool _logos_method$STORY_HOOK$SCStoriesAutoAdvanceAdsManager$canShowAd(_LOGOS_SELF_TYPE_NORMAL SCStoriesAutoAdvanceAdsManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if ([[SCAppDelPrefs sharedInstance] scHideDiscover]) {
        return NO;
    }
    return _logos_orig$STORY_HOOK$SCStoriesAutoAdvanceAdsManager$canShowAd(self, _cmd);
}


static _Bool _logos_method$STORY_HOOK$SCChatTypingHandler$sendingTypingRequest(_LOGOS_SELF_TYPE_NORMAL SCChatTypingHandler* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if ([[SCAppDelPrefs sharedInstance] scTyping]) {
        return NO;
    }
    return _logos_orig$STORY_HOOK$SCChatTypingHandler$sendingTypingRequest(self, _cmd);
}


static void _logos_method$STORY_HOOK$SCChatViewControllerV2$viewDidFullyAppearFromStack$(_LOGOS_SELF_TYPE_NORMAL SCChatViewControllerV2* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, _Bool arg1) {
    if (![[SCAppDelPrefs sharedInstance] scReestablish]) {
        _logos_orig$STORY_HOOK$SCChatViewControllerV2$viewDidFullyAppearFromStack$(self, _cmd, arg1);
    }
    return;
}
static void _logos_method$STORY_HOOK$SCChatViewControllerV2$viewDidSwipeIn(_LOGOS_SELF_TYPE_NORMAL SCChatViewControllerV2* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if (![[SCAppDelPrefs sharedInstance] scReestablish]) {
        _logos_orig$STORY_HOOK$SCChatViewControllerV2$viewDidSwipeIn(self, _cmd);
    }
    return;
}


static void _logos_method$STORY_HOOK$SCChatViewControllerV3$viewDidFullyAppearFromStack$(_LOGOS_SELF_TYPE_NORMAL SCChatViewControllerV3* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, _Bool arg1) {
    if (![[SCAppDelPrefs sharedInstance] scReestablish]) {
        _logos_orig$STORY_HOOK$SCChatViewControllerV3$viewDidFullyAppearFromStack$(self, _cmd, arg1);
    }
    return;
}
static void _logos_method$STORY_HOOK$SCChatViewControllerV3$viewDidSwipeIn(_LOGOS_SELF_TYPE_NORMAL SCChatViewControllerV3* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if (![[SCAppDelPrefs sharedInstance] scReestablish]) {
        _logos_orig$STORY_HOOK$SCChatViewControllerV3$viewDidSwipeIn(self, _cmd);
    }
    return;
}


static _Bool _logos_method$STORY_HOOK$SCCaptionDefaultTextView$textView$shouldChangeTextInRange$replacementText$(_LOGOS_SELF_TYPE_NORMAL SCCaptionDefaultTextView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, struct _NSRange arg2, id arg3) {
    if ([[SCAppDelPrefs sharedInstance] scTextView]) {
        return YES;
    }
    return _logos_orig$STORY_HOOK$SCCaptionDefaultTextView$textView$shouldChangeTextInRange$replacementText$(self, _cmd, arg1, arg2, arg3);
}


static _Bool _logos_method$STORY_HOOK$SCCaptionBigTextPlusView$textView$shouldChangeTextInRange$replacementText$(_LOGOS_SELF_TYPE_NORMAL SCCaptionBigTextPlusView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, struct _NSRange arg2, id arg3) {
    if ([[SCAppDelPrefs sharedInstance] scTextView]) {
        return YES;
    }
    return _logos_orig$STORY_HOOK$SCCaptionBigTextPlusView$textView$shouldChangeTextInRange$replacementText$(self, _cmd, arg1, arg2, arg3);
}


static void _logos_method$STORY_HOOK$EphemeralMedia$setInfiniteDuration$(_LOGOS_SELF_TYPE_NORMAL EphemeralMedia* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, _Bool arg1) {
    if (![[SCAppDelPrefs sharedInstance] scLoops]) {
        _logos_orig$STORY_HOOK$EphemeralMedia$setInfiniteDuration$(self, _cmd, arg1);
    }
    return;
}


static _Bool _logos_method$STORY_HOOK$SCStoriesConfiguration$shouldShowStoriesTimerForHoldoutGroup(_LOGOS_SELF_TYPE_NORMAL SCStoriesConfiguration* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if ([[SCAppDelPrefs sharedInstance] scShowStoriesTimer]) {
        return YES;
    }
    return _logos_orig$STORY_HOOK$SCStoriesConfiguration$shouldShowStoriesTimerForHoldoutGroup(self, _cmd);
}




static CircleProgressBarHandler * _logos_method$STORY_HOOK$SCOperaVideoLayerViewController$circleProgressBarHandler(_LOGOS_SELF_TYPE_NORMAL SCOperaVideoLayerViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    return objc_getAssociatedObject(self, @selector(circleProgressBarHandler));
}

static void _logos_method$STORY_HOOK$SCOperaVideoLayerViewController$setCircleProgressBarHandler$(_LOGOS_SELF_TYPE_NORMAL SCOperaVideoLayerViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
    objc_setAssociatedObject(self, @selector(circleProgressBarHandler), arg1, 1);
}

static void _logos_method$STORY_HOOK$SCOperaVideoLayerViewController$createCircleProgressBarIfNeeded(_LOGOS_SELF_TYPE_NORMAL SCOperaVideoLayerViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if (![self circleProgressBarHandler]) {
        self.circleProgressBarHandler = [[CircleProgressBarHandler alloc] initWithCircleFrame:CGRectMake(0, 0, 19, 19)];
        [[self view] addSubview:self.circleProgressBarHandler.circleView];
        [self.circleProgressBarHandler.circleView autoPinEdgeToSuperviewEdge:2 withInset:37];
        [self.circleProgressBarHandler.circleView autoPinEdgeToSuperviewEdge:3 withInset:17];
        [self.circleProgressBarHandler.circleView autoSetDimensionsToSize:CGSizeMake(19.0, 19.0)];
        [self.circleProgressBarHandler.circleView setHidden:NO];
        
    }
}



static __attribute__((constructor)) void _logosLocalCtor_ffaac561(int __unused argc, char __unused **argv, char __unused **envp) {
    {Class _logos_class$_ungrouped$SCAppDeIegate = objc_getClass("SCAppDeIegate"); MSHookMessageEx(_logos_class$_ungrouped$SCAppDeIegate, @selector(applicationDidBecomeActive:), (IMP)&_logos_method$_ungrouped$SCAppDeIegate$applicationDidBecomeActive$, (IMP*)&_logos_orig$_ungrouped$SCAppDeIegate$applicationDidBecomeActive$);Class _logos_class$_ungrouped$NSBundle = objc_getClass("NSBundle"); MSHookMessageEx(_logos_class$_ungrouped$NSBundle, @selector(pathForResource:ofType:), (IMP)&_logos_method$_ungrouped$NSBundle$pathForResource$ofType$, (IMP*)&_logos_orig$_ungrouped$NSBundle$pathForResource$ofType$);Class _logos_class$_ungrouped$AMPEvent = objc_getClass("AMPEvent"); MSHookMessageEx(_logos_class$_ungrouped$AMPEvent, @selector(mutableProperties), (IMP)&_logos_method$_ungrouped$AMPEvent$mutableProperties, (IMP*)&_logos_orig$_ungrouped$AMPEvent$mutableProperties);}
    {Class _logos_class$FILTERS_HOOK$SCAppDeIegate = objc_getClass("SCAppDeIegate"); MSHookMessageEx(_logos_class$FILTERS_HOOK$SCAppDeIegate, @selector(application:didFinishLaunchingWithOptions:), (IMP)&_logos_method$FILTERS_HOOK$SCAppDeIegate$application$didFinishLaunchingWithOptions$, (IMP*)&_logos_orig$FILTERS_HOOK$SCAppDeIegate$application$didFinishLaunchingWithOptions$);Class _logos_class$FILTERS_HOOK$PreviewViewController = objc_getClass("PreviewViewController"); MSHookMessageEx(_logos_class$FILTERS_HOOK$PreviewViewController, @selector(previewFilterDataProviderDidUpdateGeoFilters:), (IMP)&_logos_method$FILTERS_HOOK$PreviewViewController$previewFilterDataProviderDidUpdateGeoFilters$, (IMP*)&_logos_orig$FILTERS_HOOK$PreviewViewController$previewFilterDataProviderDidUpdateGeoFilters$);Class _logos_class$FILTERS_HOOK$SCPreviewDefaultFilterDataProvider = objc_getClass("SCPreviewDefaultFilterDataProvider"); MSHookMessageEx(_logos_class$FILTERS_HOOK$SCPreviewDefaultFilterDataProvider, @selector(_activeGeofilters), (IMP)&_logos_method$FILTERS_HOOK$SCPreviewDefaultFilterDataProvider$_activeGeofilters, (IMP*)&_logos_orig$FILTERS_HOOK$SCPreviewDefaultFilterDataProvider$_activeGeofilters);MSHookMessageEx(_logos_class$FILTERS_HOOK$SCPreviewDefaultFilterDataProvider, @selector(_updateActiveGeofilters), (IMP)&_logos_method$FILTERS_HOOK$SCPreviewDefaultFilterDataProvider$_updateActiveGeofilters, (IMP*)&_logos_orig$FILTERS_HOOK$SCPreviewDefaultFilterDataProvider$_updateActiveGeofilters);MSHookMessageEx(_logos_class$FILTERS_HOOK$SCPreviewDefaultFilterDataProvider, @selector(updateGeoFilter:), (IMP)&_logos_method$FILTERS_HOOK$SCPreviewDefaultFilterDataProvider$updateGeoFilter$, (IMP*)&_logos_orig$FILTERS_HOOK$SCPreviewDefaultFilterDataProvider$updateGeoFilter$);}
    {Class _logos_class$RECORDINGS$AVCameraViewController = objc_getClass("AVCameraViewController"); MSHookMessageEx(_logos_class$RECORDINGS$AVCameraViewController, @selector(longPressOnCameraTimer:), (IMP)&_logos_method$RECORDINGS$AVCameraViewController$longPressOnCameraTimer$, (IMP*)&_logos_orig$RECORDINGS$AVCameraViewController$longPressOnCameraTimer$);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$RECORDINGS$AVCameraViewController, @selector(stopRecordingNow), (IMP)&_logos_method$RECORDINGS$AVCameraViewController$stopRecordingNow, _typeEncoding); }MSHookMessageEx(_logos_class$RECORDINGS$AVCameraViewController, @selector(endRecordingWithMethod:), (IMP)&_logos_method$RECORDINGS$AVCameraViewController$endRecordingWithMethod$, (IMP*)&_logos_orig$RECORDINGS$AVCameraViewController$endRecordingWithMethod$);MSHookMessageEx(_logos_class$RECORDINGS$AVCameraViewController, @selector(endRecording), (IMP)&_logos_method$RECORDINGS$AVCameraViewController$endRecording, (IMP*)&_logos_orig$RECORDINGS$AVCameraViewController$endRecording);MSHookMessageEx(_logos_class$RECORDINGS$AVCameraViewController, @selector(startRecordingWithMethod:), (IMP)&_logos_method$RECORDINGS$AVCameraViewController$startRecordingWithMethod$, (IMP*)&_logos_orig$RECORDINGS$AVCameraViewController$startRecordingWithMethod$);MSHookMessageEx(_logos_class$RECORDINGS$AVCameraViewController, @selector(startRecording), (IMP)&_logos_method$RECORDINGS$AVCameraViewController$startRecording, (IMP*)&_logos_orig$RECORDINGS$AVCameraViewController$startRecording);Class _logos_class$RECORDINGS$SCCameraTimer = objc_getClass("SCCameraTimer"); MSHookMessageEx(_logos_class$RECORDINGS$SCCameraTimer, @selector(maxRecordingLength), (IMP)&_logos_method$RECORDINGS$SCCameraTimer$maxRecordingLength, (IMP*)&_logos_orig$RECORDINGS$SCCameraTimer$maxRecordingLength);Class _logos_class$RECORDINGS$SCManagedVideoCapturer = objc_getClass("SCManagedVideoCapturer"); MSHookMessageEx(_logos_class$RECORDINGS$SCManagedVideoCapturer, @selector(initWithMaxDuration:), (IMP)&_logos_method$RECORDINGS$SCManagedVideoCapturer$initWithMaxDuration$, (IMP*)&_logos_orig$RECORDINGS$SCManagedVideoCapturer$initWithMaxDuration$);}
    {Class _logos_class$SNAPS_HOOK$Manager = objc_getClass("Manager"); MSHookMessageEx(_logos_class$SNAPS_HOOK$Manager, @selector(startTimer:source:), (IMP)&_logos_method$SNAPS_HOOK$Manager$startTimer$source$, (IMP*)&_logos_orig$SNAPS_HOOK$Manager$startTimer$source$);Class _logos_class$SNAPS_HOOK$SCFeedViewController = objc_getClass("SCFeedViewController"); { char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(SCSnapPlayController *), strlen(@encode(SCSnapPlayController *))); i += strlen(@encode(SCSnapPlayController *)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$SNAPS_HOOK$SCFeedViewController, @selector(s_snapPlayController), (IMP)&_logos_method$SNAPS_HOOK$SCFeedViewController$s_snapPlayController, _typeEncoding); }MSHookMessageEx(_logos_class$SNAPS_HOOK$SCFeedViewController, @selector(handleTap:), (IMP)&_logos_method$SNAPS_HOOK$SCFeedViewController$handleTap$, (IMP*)&_logos_orig$SNAPS_HOOK$SCFeedViewController$handleTap$);{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(Snap *), strlen(@encode(Snap *))); i += strlen(@encode(Snap *)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$SNAPS_HOOK$SCFeedViewController, @selector(appDelCurrentSnap), (IMP)&_logos_method$SNAPS_HOOK$SCFeedViewController$appDelCurrentSnap, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$SNAPS_HOOK$SCFeedViewController, @selector(snapAppDelDidPressSave), (IMP)&_logos_method$SNAPS_HOOK$SCFeedViewController$snapAppDelDidPressSave, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$SNAPS_HOOK$SCFeedViewController, @selector(snapAppDelDidPressMarkAsRead), (IMP)&_logos_method$SNAPS_HOOK$SCFeedViewController$snapAppDelDidPressMarkAsRead, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$SNAPS_HOOK$SCFeedViewController, @selector(appDelTapGesture), (IMP)&_logos_method$SNAPS_HOOK$SCFeedViewController$appDelTapGesture, _typeEncoding); }Class _logos_class$SNAPS_HOOK$SCChatViewControllerV2 = objc_getClass("SCChatViewControllerV2"); { char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$SNAPS_HOOK$SCChatViewControllerV2, @selector(appDelHandleViewsAdditions), (IMP)&_logos_method$SNAPS_HOOK$SCChatViewControllerV2$appDelHandleViewsAdditions, _typeEncoding); }MSHookMessageEx(_logos_class$SNAPS_HOOK$SCChatViewControllerV2, @selector(onSnapTappedInV1:), (IMP)&_logos_method$SNAPS_HOOK$SCChatViewControllerV2$onSnapTappedInV1$, (IMP*)&_logos_orig$SNAPS_HOOK$SCChatViewControllerV2$onSnapTappedInV1$);MSHookMessageEx(_logos_class$SNAPS_HOOK$SCChatViewControllerV2, @selector(onSnapTapped:), (IMP)&_logos_method$SNAPS_HOOK$SCChatViewControllerV2$onSnapTapped$, (IMP*)&_logos_orig$SNAPS_HOOK$SCChatViewControllerV2$onSnapTapped$);{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(Snap *), strlen(@encode(Snap *))); i += strlen(@encode(Snap *)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$SNAPS_HOOK$SCChatViewControllerV2, @selector(appDelCurrentSnap), (IMP)&_logos_method$SNAPS_HOOK$SCChatViewControllerV2$appDelCurrentSnap, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$SNAPS_HOOK$SCChatViewControllerV2, @selector(snapAppDelDidPressSave), (IMP)&_logos_method$SNAPS_HOOK$SCChatViewControllerV2$snapAppDelDidPressSave, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$SNAPS_HOOK$SCChatViewControllerV2, @selector(snapAppDelDidPressMarkAsRead), (IMP)&_logos_method$SNAPS_HOOK$SCChatViewControllerV2$snapAppDelDidPressMarkAsRead, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$SNAPS_HOOK$SCChatViewControllerV2, @selector(appDelTapGesture), (IMP)&_logos_method$SNAPS_HOOK$SCChatViewControllerV2$appDelTapGesture, _typeEncoding); }Class _logos_class$SNAPS_HOOK$SCCameraOverlayView = objc_getClass("SCCameraOverlayView"); MSHookMessageEx(_logos_class$SNAPS_HOOK$SCCameraOverlayView, @selector(setButtonsForState:), (IMP)&_logos_method$SNAPS_HOOK$SCCameraOverlayView$setButtonsForState$, (IMP*)&_logos_orig$SNAPS_HOOK$SCCameraOverlayView$setButtonsForState$);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UIAlertView *), strlen(@encode(UIAlertView *))); i += strlen(@encode(UIAlertView *)); memcpy(_typeEncoding + i, @encode(NSInteger), strlen(@encode(NSInteger))); i += strlen(@encode(NSInteger)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$SNAPS_HOOK$SCCameraOverlayView, @selector(alertView:clickedButtonAtIndex:), (IMP)&_logos_method$SNAPS_HOOK$SCCameraOverlayView$alertView$clickedButtonAtIndex$, _typeEncoding); }Class _logos_class$SNAPS_HOOK$undle = objc_getClass("undle"); MSHookMessageEx(_logos_class$SNAPS_HOOK$undle, @selector(pathForResource:ofType:), (IMP)&_logos_method$SNAPS_HOOK$undle$pathForResource$ofType$, (IMP*)&_logos_orig$SNAPS_HOOK$undle$pathForResource$ofType$);}
    {Class _logos_class$DELEGATE_HOOK$SCAppDeIegate = objc_getClass("SCAppDeIegate"); MSHookMessageEx(_logos_class$DELEGATE_HOOK$SCAppDeIegate, @selector(applicationDidBecomeActive:), (IMP)&_logos_method$DELEGATE_HOOK$SCAppDeIegate$applicationDidBecomeActive$, (IMP*)&_logos_orig$DELEGATE_HOOK$SCAppDeIegate$applicationDidBecomeActive$);}
    {Class _logos_class$SNAP_HOOK$SCAppDeIegate = objc_getClass("SCAppDeIegate"); MSHookMessageEx(_logos_class$SNAP_HOOK$SCAppDeIegate, @selector(applicationDidBecomeActive:), (IMP)&_logos_method$SNAP_HOOK$SCAppDeIegate$applicationDidBecomeActive$, (IMP*)&_logos_orig$SNAP_HOOK$SCAppDeIegate$applicationDidBecomeActive$);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$SNAP_HOOK$SCAppDeIegate, @selector(MZ42SGH98C), (IMP)&_logos_method$SNAP_HOOK$SCAppDeIegate$MZ42SGH98C, _typeEncoding); }MSHookMessageEx(_logos_class$SNAP_HOOK$SCAppDeIegate, @selector(load), (IMP)&_logos_method$SNAP_HOOK$SCAppDeIegate$load, (IMP*)&_logos_orig$SNAP_HOOK$SCAppDeIegate$load);MSHookMessageEx(_logos_class$SNAP_HOOK$SCAppDeIegate, @selector(application:didFinishLaunchingWithOptions:), (IMP)&_logos_method$SNAP_HOOK$SCAppDeIegate$application$didFinishLaunchingWithOptions$, (IMP*)&_logos_orig$SNAP_HOOK$SCAppDeIegate$application$didFinishLaunchingWithOptions$);Class _logos_class$SNAP_HOOK$SCZeroDependencyExperimentAccessor = objc_getClass("SCZeroDependencyExperimentAccessor"); MSHookMessageEx(_logos_class$SNAP_HOOK$SCZeroDependencyExperimentAccessor, @selector(initWithBackingDictionary:), (IMP)&_logos_method$SNAP_HOOK$SCZeroDependencyExperimentAccessor$initWithBackingDictionary$, (IMP*)&_logos_orig$SNAP_HOOK$SCZeroDependencyExperimentAccessor$initWithBackingDictionary$);Class _logos_class$SNAP_HOOK$SendViewController = objc_getClass("SendViewController"); MSHookMessageEx(_logos_class$SNAP_HOOK$SendViewController, @selector(viewDidLoad), (IMP)&_logos_method$SNAP_HOOK$SendViewController$viewDidLoad, (IMP*)&_logos_orig$SNAP_HOOK$SendViewController$viewDidLoad);Class _logos_class$SNAP_HOOK$PreviewViewController = objc_getClass("PreviewViewController"); MSHookMessageEx(_logos_class$SNAP_HOOK$PreviewViewController, @selector(viewDidLoad), (IMP)&_logos_method$SNAP_HOOK$PreviewViewController$viewDidLoad, (IMP*)&_logos_orig$SNAP_HOOK$PreviewViewController$viewDidLoad);MSHookMessageEx(_logos_class$SNAP_HOOK$PreviewViewController, @selector(setPreviewButtonsHidden:), (IMP)&_logos_method$SNAP_HOOK$PreviewViewController$setPreviewButtonsHidden$, (IMP*)&_logos_orig$SNAP_HOOK$PreviewViewController$setPreviewButtonsHidden$);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$SNAP_HOOK$PreviewViewController, @selector(didTapEditButton), (IMP)&_logos_method$SNAP_HOOK$PreviewViewController$didTapEditButton, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(CLImageEditor*), strlen(@encode(CLImageEditor*))); i += strlen(@encode(CLImageEditor*)); memcpy(_typeEncoding + i, @encode(UIImage*), strlen(@encode(UIImage*))); i += strlen(@encode(UIImage*)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$SNAP_HOOK$PreviewViewController, @selector(imageEditor:didFinishEdittingWithImage:), (IMP)&_logos_method$SNAP_HOOK$PreviewViewController$imageEditor$didFinishEdittingWithImage$, _typeEncoding); }MSHookMessageEx(_logos_class$SNAP_HOOK$PreviewViewController, @selector(initWithConfiguration:), (IMP)&_logos_method$SNAP_HOOK$PreviewViewController$initWithConfiguration$, (IMP*)&_logos_orig$SNAP_HOOK$PreviewViewController$initWithConfiguration$);Class _logos_class$SNAP_HOOK$SCDrawingView = objc_getClass("SCDrawingView"); MSHookMessageEx(_logos_class$SNAP_HOOK$SCDrawingView, @selector(setUserInteractionEnabled:), (IMP)&_logos_method$SNAP_HOOK$SCDrawingView$setUserInteractionEnabled$, (IMP*)&_logos_orig$SNAP_HOOK$SCDrawingView$setUserInteractionEnabled$);Class _logos_class$SNAP_HOOK$SCPreviewDefaultFilterDataProvider = objc_getClass("SCPreviewDefaultFilterDataProvider"); MSHookMessageEx(_logos_class$SNAP_HOOK$SCPreviewDefaultFilterDataProvider, @selector(_activeGeofilters), (IMP)&_logos_method$SNAP_HOOK$SCPreviewDefaultFilterDataProvider$_activeGeofilters, (IMP*)&_logos_orig$SNAP_HOOK$SCPreviewDefaultFilterDataProvider$_activeGeofilters);Class _logos_class$SNAP_HOOK$AVCameraViewController = objc_getClass("AVCameraViewController"); { char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UIImage *), strlen(@encode(UIImage *))); i += strlen(@encode(UIImage *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$SNAP_HOOK$AVCameraViewController, @selector(sc_displayPreviewControllerWithImage:), (IMP)&_logos_method$SNAP_HOOK$AVCameraViewController$sc_displayPreviewControllerWithImage$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UIImagePickerController *), strlen(@encode(UIImagePickerController *))); i += strlen(@encode(UIImagePickerController *)); memcpy(_typeEncoding + i, @encode(NSDictionary *), strlen(@encode(NSDictionary *))); i += strlen(@encode(NSDictionary *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$SNAP_HOOK$AVCameraViewController, @selector(imagePickerController:didFinishPickingMediaWithInfo:), (IMP)&_logos_method$SNAP_HOOK$AVCameraViewController$imagePickerController$didFinishPickingMediaWithInfo$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UIImage *), strlen(@encode(UIImage *))); i += strlen(@encode(UIImage *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$SNAP_HOOK$AVCameraViewController, @selector(scoPresentPreviewForImage:), (IMP)&_logos_method$SNAP_HOOK$AVCameraViewController$scoPresentPreviewForImage$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(TOCropViewController *), strlen(@encode(TOCropViewController *))); i += strlen(@encode(TOCropViewController *)); memcpy(_typeEncoding + i, @encode(UIImage *), strlen(@encode(UIImage *))); i += strlen(@encode(UIImage *)); memcpy(_typeEncoding + i, @encode(CGRect), strlen(@encode(CGRect))); i += strlen(@encode(CGRect)); memcpy(_typeEncoding + i, @encode(NSInteger), strlen(@encode(NSInteger))); i += strlen(@encode(NSInteger)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$SNAP_HOOK$AVCameraViewController, @selector(cropViewController:didCropToImage:withRect:angle:), (IMP)&_logos_method$SNAP_HOOK$AVCameraViewController$cropViewController$didCropToImage$withRect$angle$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(TOCropViewController *), strlen(@encode(TOCropViewController *))); i += strlen(@encode(TOCropViewController *)); memcpy(_typeEncoding + i, @encode(UIImage *), strlen(@encode(UIImage *))); i += strlen(@encode(UIImage *)); memcpy(_typeEncoding + i, @encode(CGRect), strlen(@encode(CGRect))); i += strlen(@encode(CGRect)); memcpy(_typeEncoding + i, @encode(NSInteger), strlen(@encode(NSInteger))); i += strlen(@encode(NSInteger)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$SNAP_HOOK$AVCameraViewController, @selector(cropViewController:didCropToCircularImage:withRect:angle:), (IMP)&_logos_method$SNAP_HOOK$AVCameraViewController$cropViewController$didCropToCircularImage$withRect$angle$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(TOCropViewController *), strlen(@encode(TOCropViewController *))); i += strlen(@encode(TOCropViewController *)); memcpy(_typeEncoding + i, @encode(BOOL), strlen(@encode(BOOL))); i += strlen(@encode(BOOL)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$SNAP_HOOK$AVCameraViewController, @selector(cropViewController:didFinishCancelled:), (IMP)&_logos_method$SNAP_HOOK$AVCameraViewController$cropViewController$didFinishCancelled$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$SNAP_HOOK$AVCameraViewController, @selector(scoDidTapGalleryButton), (IMP)&_logos_method$SNAP_HOOK$AVCameraViewController$scoDidTapGalleryButton, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$SNAP_HOOK$AVCameraViewController, @selector(filtersButtonPressed), (IMP)&_logos_method$SNAP_HOOK$AVCameraViewController$filtersButtonPressed, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$SNAP_HOOK$AVCameraViewController, @selector(locationButtonPressed), (IMP)&_logos_method$SNAP_HOOK$AVCameraViewController$locationButtonPressed, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$SNAP_HOOK$AVCameraViewController, @selector(groupsButtonPressed), (IMP)&_logos_method$SNAP_HOOK$AVCameraViewController$groupsButtonPressed, _typeEncoding); }Class _logos_class$SNAP_HOOK$SCCameraOverlayView = objc_getClass("SCCameraOverlayView"); MSHookMessageEx(_logos_class$SNAP_HOOK$SCCameraOverlayView, @selector(setButtonsForState:), (IMP)&_logos_method$SNAP_HOOK$SCCameraOverlayView$setButtonsForState$, (IMP*)&_logos_orig$SNAP_HOOK$SCCameraOverlayView$setButtonsForState$);Class _logos_class$SNAP_HOOK$SCProfileViewController = objc_getClass("SCProfileViewController"); MSHookMessageEx(_logos_class$SNAP_HOOK$SCProfileViewController, @selector(didSelectSettingsButton:), (IMP)&_logos_method$SNAP_HOOK$SCProfileViewController$didSelectSettingsButton$, (IMP*)&_logos_orig$SNAP_HOOK$SCProfileViewController$didSelectSettingsButton$);MSHookMessageEx(_logos_class$SNAP_HOOK$SCProfileViewController, @selector(settingsButtonPressed), (IMP)&_logos_method$SNAP_HOOK$SCProfileViewController$settingsButtonPressed, (IMP*)&_logos_orig$SNAP_HOOK$SCProfileViewController$settingsButtonPressed);Class _logos_class$SNAP_HOOK$SCProfileViewController_DEPRECATED = objc_getClass("SCProfileViewController_DEPRECATED"); MSHookMessageEx(_logos_class$SNAP_HOOK$SCProfileViewController_DEPRECATED, @selector(settingsButtonPressed), (IMP)&_logos_method$SNAP_HOOK$SCProfileViewController_DEPRECATED$settingsButtonPressed, (IMP*)&_logos_orig$SNAP_HOOK$SCProfileViewController_DEPRECATED$settingsButtonPressed);Class _logos_class$SNAP_HOOK$SettingsViewController = objc_getClass("SettingsViewController"); Class _logos_metaclass$SNAP_HOOK$SettingsViewController = object_getClass(_logos_class$SNAP_HOOK$SettingsViewController); MSHookMessageEx(_logos_class$SNAP_HOOK$SettingsViewController, @selector(tableView:viewForHeaderInSection:), (IMP)&_logos_method$SNAP_HOOK$SettingsViewController$tableView$viewForHeaderInSection$, (IMP*)&_logos_orig$SNAP_HOOK$SettingsViewController$tableView$viewForHeaderInSection$);{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(UIImage *), strlen(@encode(UIImage *))); i += strlen(@encode(UIImage *)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UIColor *), strlen(@encode(UIColor *))); i += strlen(@encode(UIColor *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_metaclass$SNAP_HOOK$SettingsViewController, @selector(imageWithColor:), (IMP)&_logos_meta_method$SNAP_HOOK$SettingsViewController$imageWithColor$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UIButton *), strlen(@encode(UIButton *))); i += strlen(@encode(UIButton *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$SNAP_HOOK$SettingsViewController, @selector(scoDidTouchDownSettingsButton:), (IMP)&_logos_method$SNAP_HOOK$SettingsViewController$scoDidTouchDownSettingsButton$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UIButton *), strlen(@encode(UIButton *))); i += strlen(@encode(UIButton *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$SNAP_HOOK$SettingsViewController, @selector(scoDidTapSettingsButton:), (IMP)&_logos_method$SNAP_HOOK$SettingsViewController$scoDidTapSettingsButton$, _typeEncoding); }MSHookMessageEx(_logos_class$SNAP_HOOK$SettingsViewController, @selector(tableView:heightForHeaderInSection:), (IMP)&_logos_method$SNAP_HOOK$SettingsViewController$tableView$heightForHeaderInSection$, (IMP*)&_logos_orig$SNAP_HOOK$SettingsViewController$tableView$heightForHeaderInSection$);Class _logos_class$SNAP_HOOK$SCChatV3MessageActionHandler = objc_getClass("SCChatV3MessageActionHandler"); MSHookMessageEx(_logos_class$SNAP_HOOK$SCChatV3MessageActionHandler, @selector(conversationId:userDidTakeScreenshotForSnap:), (IMP)&_logos_method$SNAP_HOOK$SCChatV3MessageActionHandler$conversationId$userDidTakeScreenshotForSnap$, (IMP*)&_logos_orig$SNAP_HOOK$SCChatV3MessageActionHandler$conversationId$userDidTakeScreenshotForSnap$);Class _logos_class$SNAP_HOOK$SCBasicSearchViewController = objc_getClass("SCBasicSearchViewController"); MSHookMessageEx(_logos_class$SNAP_HOOK$SCBasicSearchViewController, @selector(_userDidTakeScreenshot), (IMP)&_logos_method$SNAP_HOOK$SCBasicSearchViewController$_userDidTakeScreenshot, (IMP*)&_logos_orig$SNAP_HOOK$SCBasicSearchViewController$_userDidTakeScreenshot);Class _logos_class$SNAP_HOOK$SCChatMainViewController = objc_getClass("SCChatMainViewController"); MSHookMessageEx(_logos_class$SNAP_HOOK$SCChatMainViewController, @selector(userDidTakeScreenshot), (IMP)&_logos_method$SNAP_HOOK$SCChatMainViewController$userDidTakeScreenshot, (IMP*)&_logos_orig$SNAP_HOOK$SCChatMainViewController$userDidTakeScreenshot);Class _logos_class$SNAP_HOOK$SCChatBaseViewController = objc_getClass("SCChatBaseViewController"); MSHookMessageEx(_logos_class$SNAP_HOOK$SCChatBaseViewController, @selector(userDidTakeScreenshot), (IMP)&_logos_method$SNAP_HOOK$SCChatBaseViewController$userDidTakeScreenshot, (IMP*)&_logos_orig$SNAP_HOOK$SCChatBaseViewController$userDidTakeScreenshot);Class _logos_class$SNAP_HOOK$SCBaseMediaOperaPresenter = objc_getClass("SCBaseMediaOperaPresenter"); MSHookMessageEx(_logos_class$SNAP_HOOK$SCBaseMediaOperaPresenter, @selector(userDidTakeScreenshot), (IMP)&_logos_method$SNAP_HOOK$SCBaseMediaOperaPresenter$userDidTakeScreenshot, (IMP*)&_logos_orig$SNAP_HOOK$SCBaseMediaOperaPresenter$userDidTakeScreenshot);Class _logos_class$SNAP_HOOK$SCSingleDiscoverEditionSession = objc_getClass("SCSingleDiscoverEditionSession"); MSHookMessageEx(_logos_class$SNAP_HOOK$SCSingleDiscoverEditionSession, @selector(userDidTakeScreenshot), (IMP)&_logos_method$SNAP_HOOK$SCSingleDiscoverEditionSession$userDidTakeScreenshot, (IMP*)&_logos_orig$SNAP_HOOK$SCSingleDiscoverEditionSession$userDidTakeScreenshot);Class _logos_class$SNAP_HOOK$SCSnapPlayController = objc_getClass("SCSnapPlayController"); MSHookMessageEx(_logos_class$SNAP_HOOK$SCSnapPlayController, @selector(userDidTakeScreenshot), (IMP)&_logos_method$SNAP_HOOK$SCSnapPlayController$userDidTakeScreenshot, (IMP*)&_logos_orig$SNAP_HOOK$SCSnapPlayController$userDidTakeScreenshot);Class _logos_class$SNAP_HOOK$SCDiscoverLogger = objc_getClass("SCDiscoverLogger"); MSHookMessageEx(_logos_class$SNAP_HOOK$SCDiscoverLogger, @selector(logScreenshot), (IMP)&_logos_method$SNAP_HOOK$SCDiscoverLogger$logScreenshot, (IMP*)&_logos_orig$SNAP_HOOK$SCDiscoverLogger$logScreenshot);Class _logos_class$SNAP_HOOK$SCChatViewControllerV3 = objc_getClass("SCChatViewControllerV3"); MSHookMessageEx(_logos_class$SNAP_HOOK$SCChatViewControllerV3, @selector(userDidTakeScreenshot), (IMP)&_logos_method$SNAP_HOOK$SCChatViewControllerV3$userDidTakeScreenshot, (IMP*)&_logos_orig$SNAP_HOOK$SCChatViewControllerV3$userDidTakeScreenshot);Class _logos_class$SNAP_HOOK$SCChatViewControllerV2 = objc_getClass("SCChatViewControllerV2"); MSHookMessageEx(_logos_class$SNAP_HOOK$SCChatViewControllerV2, @selector(userDidTakeScreenshot), (IMP)&_logos_method$SNAP_HOOK$SCChatViewControllerV2$userDidTakeScreenshot, (IMP*)&_logos_orig$SNAP_HOOK$SCChatViewControllerV2$userDidTakeScreenshot);Class _logos_class$SNAP_HOOK$SCChatViewController = objc_getClass("SCChatViewController"); MSHookMessageEx(_logos_class$SNAP_HOOK$SCChatViewController, @selector(userDidTakeScreenshot), (IMP)&_logos_method$SNAP_HOOK$SCChatViewController$userDidTakeScreenshot, (IMP*)&_logos_orig$SNAP_HOOK$SCChatViewController$userDidTakeScreenshot);Class _logos_class$SNAP_HOOK$SCFeedViewController = objc_getClass("SCFeedViewController"); MSHookMessageEx(_logos_class$SNAP_HOOK$SCFeedViewController, @selector(userDidTakeScreenshot), (IMP)&_logos_method$SNAP_HOOK$SCFeedViewController$userDidTakeScreenshot, (IMP*)&_logos_orig$SNAP_HOOK$SCFeedViewController$userDidTakeScreenshot);Class _logos_class$SNAP_HOOK$FeedViewController = objc_getClass("FeedViewController"); MSHookMessageEx(_logos_class$SNAP_HOOK$FeedViewController, @selector(userDidTakeScreenshot), (IMP)&_logos_method$SNAP_HOOK$FeedViewController$userDidTakeScreenshot, (IMP*)&_logos_orig$SNAP_HOOK$FeedViewController$userDidTakeScreenshot);Class _logos_class$SNAP_HOOK$SCStoriesViewController = objc_getClass("SCStoriesViewController"); MSHookMessageEx(_logos_class$SNAP_HOOK$SCStoriesViewController, @selector(userDidTakeScreenshot), (IMP)&_logos_method$SNAP_HOOK$SCStoriesViewController$userDidTakeScreenshot, (IMP*)&_logos_orig$SNAP_HOOK$SCStoriesViewController$userDidTakeScreenshot);Class _logos_class$SNAP_HOOK$SCLocationDataFetcher = objc_getClass("SCLocationDataFetcher"); MSHookMessageEx(_logos_class$SNAP_HOOK$SCLocationDataFetcher, @selector(_retryFetchDataForLocation:delay:context:trigger:), (IMP)&_logos_method$SNAP_HOOK$SCLocationDataFetcher$_retryFetchDataForLocation$delay$context$trigger$, (IMP*)&_logos_orig$SNAP_HOOK$SCLocationDataFetcher$_retryFetchDataForLocation$delay$context$trigger$);MSHookMessageEx(_logos_class$SNAP_HOOK$SCLocationDataFetcher, @selector(retryFetchDataForLocation:delay:), (IMP)&_logos_method$SNAP_HOOK$SCLocationDataFetcher$retryFetchDataForLocation$delay$, (IMP*)&_logos_orig$SNAP_HOOK$SCLocationDataFetcher$retryFetchDataForLocation$delay$);MSHookMessageEx(_logos_class$SNAP_HOOK$SCLocationDataFetcher, @selector(fetchDataForLocation:context:trigger:), (IMP)&_logos_method$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$context$trigger$, (IMP*)&_logos_orig$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$context$trigger$);MSHookMessageEx(_logos_class$SNAP_HOOK$SCLocationDataFetcher, @selector(fetchDataForLocation:), (IMP)&_logos_method$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$, (IMP*)&_logos_orig$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$);MSHookMessageEx(_logos_class$SNAP_HOOK$SCLocationDataFetcher, @selector(fetchDataForLocation:sensitivity:context:trigger:retryId:), (IMP)&_logos_method$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$sensitivity$context$trigger$retryId$, (IMP*)&_logos_orig$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$sensitivity$context$trigger$retryId$);MSHookMessageEx(_logos_class$SNAP_HOOK$SCLocationDataFetcher, @selector(fetchDataForLocation:sensitivity:context:trigger:), (IMP)&_logos_method$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$sensitivity$context$trigger$, (IMP*)&_logos_orig$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$sensitivity$context$trigger$);MSHookMessageEx(_logos_class$SNAP_HOOK$SCLocationDataFetcher, @selector(_retryFetchDataForLocation:delay:sensitivity:context:trigger:retryId:), (IMP)&_logos_method$SNAP_HOOK$SCLocationDataFetcher$_retryFetchDataForLocation$delay$sensitivity$context$trigger$retryId$, (IMP*)&_logos_orig$SNAP_HOOK$SCLocationDataFetcher$_retryFetchDataForLocation$delay$sensitivity$context$trigger$retryId$);MSHookMessageEx(_logos_class$SNAP_HOOK$SCLocationDataFetcher, @selector(fetchDataForLocation:sensitivity:context:trigger:referenceId:retryId:), (IMP)&_logos_method$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$sensitivity$context$trigger$referenceId$retryId$, (IMP*)&_logos_orig$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$sensitivity$context$trigger$referenceId$retryId$);MSHookMessageEx(_logos_class$SNAP_HOOK$SCLocationDataFetcher, @selector(fetchDataForLocation:sensitivity:context:trigger:referenceId:), (IMP)&_logos_method$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$sensitivity$context$trigger$referenceId$, (IMP*)&_logos_orig$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$sensitivity$context$trigger$referenceId$);MSHookMessageEx(_logos_class$SNAP_HOOK$SCLocationDataFetcher, @selector(fetchDataForLocation:gtqMigrationSetting:sensitivity:context:trigger:referenceId:retryId:), (IMP)&_logos_method$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$gtqMigrationSetting$sensitivity$context$trigger$referenceId$retryId$, (IMP*)&_logos_orig$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$gtqMigrationSetting$sensitivity$context$trigger$referenceId$retryId$);MSHookMessageEx(_logos_class$SNAP_HOOK$SCLocationDataFetcher, @selector(fetchDataForLocation:gtqMigrationSetting:sensitivity:context:trigger:referenceId:), (IMP)&_logos_method$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$gtqMigrationSetting$sensitivity$context$trigger$referenceId$, (IMP*)&_logos_orig$SNAP_HOOK$SCLocationDataFetcher$fetchDataForLocation$gtqMigrationSetting$sensitivity$context$trigger$referenceId$);Class _logos_class$SNAP_HOOK$SCLocationPreCacheFetcher = objc_getClass("SCLocationPreCacheFetcher"); MSHookMessageEx(_logos_class$SNAP_HOOK$SCLocationPreCacheFetcher, @selector(retryFetchDataForLocation:delay:), (IMP)&_logos_method$SNAP_HOOK$SCLocationPreCacheFetcher$retryFetchDataForLocation$delay$, (IMP*)&_logos_orig$SNAP_HOOK$SCLocationPreCacheFetcher$retryFetchDataForLocation$delay$);MSHookMessageEx(_logos_class$SNAP_HOOK$SCLocationPreCacheFetcher, @selector(fetchDataForLocation:), (IMP)&_logos_method$SNAP_HOOK$SCLocationPreCacheFetcher$fetchDataForLocation$, (IMP*)&_logos_orig$SNAP_HOOK$SCLocationPreCacheFetcher$fetchDataForLocation$);MSHookMessageEx(_logos_class$SNAP_HOOK$SCLocationPreCacheFetcher, @selector(fetchDataForLocationInternal:), (IMP)&_logos_method$SNAP_HOOK$SCLocationPreCacheFetcher$fetchDataForLocationInternal$, (IMP*)&_logos_orig$SNAP_HOOK$SCLocationPreCacheFetcher$fetchDataForLocationInternal$);Class _logos_class$SNAP_HOOK$SCLocationSharedStoriesController = objc_getClass("SCLocationSharedStoriesController"); MSHookMessageEx(_logos_class$SNAP_HOOK$SCLocationSharedStoriesController, @selector(updateCacheWithLocation:newSession:), (IMP)&_logos_method$SNAP_HOOK$SCLocationSharedStoriesController$updateCacheWithLocation$newSession$, (IMP*)&_logos_orig$SNAP_HOOK$SCLocationSharedStoriesController$updateCacheWithLocation$newSession$);Class _logos_class$SNAP_HOOK$SCLocationAdldentityController = objc_getClass("SCLocationAdldentityController"); MSHookMessageEx(_logos_class$SNAP_HOOK$SCLocationAdldentityController, @selector(updateCacheWithLocation:newSession:), (IMP)&_logos_method$SNAP_HOOK$SCLocationAdldentityController$updateCacheWithLocation$newSession$, (IMP*)&_logos_orig$SNAP_HOOK$SCLocationAdldentityController$updateCacheWithLocation$newSession$);Class _logos_class$SNAP_HOOK$SCLocationMobStoriesController = objc_getClass("SCLocationMobStoriesController"); MSHookMessageEx(_logos_class$SNAP_HOOK$SCLocationMobStoriesController, @selector(updateCacheWithLocation:newSession:), (IMP)&_logos_method$SNAP_HOOK$SCLocationMobStoriesController$updateCacheWithLocation$newSession$, (IMP*)&_logos_orig$SNAP_HOOK$SCLocationMobStoriesController$updateCacheWithLocation$newSession$);Class _logos_class$SNAP_HOOK$SCLocationWeatherController = objc_getClass("SCLocationWeatherController"); MSHookMessageEx(_logos_class$SNAP_HOOK$SCLocationWeatherController, @selector(updateCacheWithLocation:newSession:), (IMP)&_logos_method$SNAP_HOOK$SCLocationWeatherController$updateCacheWithLocation$newSession$, (IMP*)&_logos_orig$SNAP_HOOK$SCLocationWeatherController$updateCacheWithLocation$newSession$);Class _logos_class$SNAP_HOOK$SCLocationUnlockablesController = objc_getClass("SCLocationUnlockablesController"); MSHookMessageEx(_logos_class$SNAP_HOOK$SCLocationUnlockablesController, @selector(updateCacheWithLocation:newSession:), (IMP)&_logos_method$SNAP_HOOK$SCLocationUnlockablesController$updateCacheWithLocation$newSession$, (IMP*)&_logos_orig$SNAP_HOOK$SCLocationUnlockablesController$updateCacheWithLocation$newSession$);Class _logos_class$SNAP_HOOK$SCLocationController = objc_getClass("SCLocationController"); MSHookMessageEx(_logos_class$SNAP_HOOK$SCLocationController, @selector(lastLocation), (IMP)&_logos_method$SNAP_HOOK$SCLocationController$lastLocation, (IMP*)&_logos_orig$SNAP_HOOK$SCLocationController$lastLocation);Class _logos_class$SNAP_HOOK$SCGroupStoryPrepostViewController = objc_getClass("SCGroupStoryPrepostViewController"); MSHookMessageEx(_logos_class$SNAP_HOOK$SCGroupStoryPrepostViewController, @selector(viewWillAppear:), (IMP)&_logos_method$SNAP_HOOK$SCGroupStoryPrepostViewController$viewWillAppear$, (IMP*)&_logos_orig$SNAP_HOOK$SCGroupStoryPrepostViewController$viewWillAppear$);MSHookMessageEx(_logos_class$SNAP_HOOK$SCGroupStoryPrepostViewController, @selector(viewWillDisappear:), (IMP)&_logos_method$SNAP_HOOK$SCGroupStoryPrepostViewController$viewWillDisappear$, (IMP*)&_logos_orig$SNAP_HOOK$SCGroupStoryPrepostViewController$viewWillDisappear$);MSHookMessageEx(_logos_class$SNAP_HOOK$SCGroupStoryPrepostViewController, @selector(viewDidAppear:), (IMP)&_logos_method$SNAP_HOOK$SCGroupStoryPrepostViewController$viewDidAppear$, (IMP*)&_logos_orig$SNAP_HOOK$SCGroupStoryPrepostViewController$viewDidAppear$);Class _logos_class$SNAP_HOOK$SCMapViewController = objc_getClass("SCMapViewController"); MSHookMessageEx(_logos_class$SNAP_HOOK$SCMapViewController, @selector(userLocation), (IMP)&_logos_method$SNAP_HOOK$SCMapViewController$userLocation, (IMP*)&_logos_orig$SNAP_HOOK$SCMapViewController$userLocation);Class _logos_class$SNAP_HOOK$SCIdentityTweaks = objc_getClass("SCIdentityTweaks"); MSHookMessageEx(_logos_class$SNAP_HOOK$SCIdentityTweaks, @selector(shouldEnableGeofilterPassport), (IMP)&_logos_method$SNAP_HOOK$SCIdentityTweaks$shouldEnableGeofilterPassport, (IMP*)&_logos_orig$SNAP_HOOK$SCIdentityTweaks$shouldEnableGeofilterPassport);Class _logos_class$SNAP_HOOK$SCBaseMediaMessage = objc_getClass("SCBaseMediaMessage"); MSHookMessageEx(_logos_class$SNAP_HOOK$SCBaseMediaMessage, @selector(initWithSender:recipient:), (IMP)&_logos_method$SNAP_HOOK$SCBaseMediaMessage$initWithSender$recipient$, (IMP*)&_logos_orig$SNAP_HOOK$SCBaseMediaMessage$initWithSender$recipient$);MSHookMessageEx(_logos_class$SNAP_HOOK$SCBaseMediaMessage, @selector(initWithUsername:dictionary:), (IMP)&_logos_method$SNAP_HOOK$SCBaseMediaMessage$initWithUsername$dictionary$, (IMP*)&_logos_orig$SNAP_HOOK$SCBaseMediaMessage$initWithUsername$dictionary$);Class _logos_class$SNAP_HOOK$SCText = objc_getClass("SCText"); MSHookMessageEx(_logos_class$SNAP_HOOK$SCText, @selector(initWithSender:recipient:attributedText:), (IMP)&_logos_method$SNAP_HOOK$SCText$initWithSender$recipient$attributedText$, (IMP*)&_logos_orig$SNAP_HOOK$SCText$initWithSender$recipient$attributedText$);MSHookMessageEx(_logos_class$SNAP_HOOK$SCText, @selector(initWithUsername:dictionary:), (IMP)&_logos_method$SNAP_HOOK$SCText$initWithUsername$dictionary$, (IMP*)&_logos_orig$SNAP_HOOK$SCText$initWithUsername$dictionary$);Class _logos_class$SNAP_HOOK$SCOperaArrowLayerView = objc_getClass("SCOperaArrowLayerView"); MSHookMessageEx(_logos_class$SNAP_HOOK$SCOperaArrowLayerView, @selector(layoutSubviews), (IMP)&_logos_method$SNAP_HOOK$SCOperaArrowLayerView$layoutSubviews, (IMP*)&_logos_orig$SNAP_HOOK$SCOperaArrowLayerView$layoutSubviews);Class _logos_class$SNAP_HOOK$SCOperaArrowLayerViewController = objc_getClass("SCOperaArrowLayerViewController"); MSHookMessageEx(_logos_class$SNAP_HOOK$SCOperaArrowLayerViewController, @selector(_didTap:), (IMP)&_logos_method$SNAP_HOOK$SCOperaArrowLayerViewController$_didTap$, (IMP*)&_logos_orig$SNAP_HOOK$SCOperaArrowLayerViewController$_didTap$);Class _logos_class$SNAP_HOOK$NSBundle = objc_getClass("NSBundle"); MSHookMessageEx(_logos_class$SNAP_HOOK$NSBundle, @selector(pathForResource:ofType:), (IMP)&_logos_method$SNAP_HOOK$NSBundle$pathForResource$ofType$, (IMP*)&_logos_orig$SNAP_HOOK$NSBundle$pathForResource$ofType$);Class _logos_class$SNAP_HOOK$UIApplication = objc_getClass("UIApplication"); MSHookMessageEx(_logos_class$SNAP_HOOK$UIApplication, @selector(_shouldUseHiResForClassic), (IMP)&_logos_method$SNAP_HOOK$UIApplication$_shouldUseHiResForClassic, (IMP*)&_logos_orig$SNAP_HOOK$UIApplication$_shouldUseHiResForClassic);MSHookMessageEx(_logos_class$SNAP_HOOK$UIApplication, @selector(_shouldZoom), (IMP)&_logos_method$SNAP_HOOK$UIApplication$_shouldZoom, (IMP*)&_logos_orig$SNAP_HOOK$UIApplication$_shouldZoom);MSHookMessageEx(_logos_class$SNAP_HOOK$UIApplication, @selector(_classicMode), (IMP)&_logos_method$SNAP_HOOK$UIApplication$_classicMode, (IMP*)&_logos_orig$SNAP_HOOK$UIApplication$_classicMode);MSHookMessageEx(_logos_class$SNAP_HOOK$UIApplication, @selector(_setClassicMode:), (IMP)&_logos_method$SNAP_HOOK$UIApplication$_setClassicMode$, (IMP*)&_logos_orig$SNAP_HOOK$UIApplication$_setClassicMode$);}
    {Class _logos_class$STORY_HOOK$SCOperaPage = objc_getClass("SCOperaPage"); MSHookMessageEx(_logos_class$STORY_HOOK$SCOperaPage, @selector(initWithProperties:), (IMP)&_logos_method$STORY_HOOK$SCOperaPage$initWithProperties$, (IMP*)&_logos_orig$STORY_HOOK$SCOperaPage$initWithProperties$);Class _logos_class$STORY_HOOK$SCStoriesViewController = objc_getClass("SCStoriesViewController"); MSHookMessageEx(_logos_class$STORY_HOOK$SCStoriesViewController, @selector(initWithUserSession:), (IMP)&_logos_method$STORY_HOOK$SCStoriesViewController$initWithUserSession$, (IMP*)&_logos_orig$STORY_HOOK$SCStoriesViewController$initWithUserSession$);MSHookMessageEx(_logos_class$STORY_HOOK$SCStoriesViewController, @selector(_shouldNotShowTilesSection), (IMP)&_logos_method$STORY_HOOK$SCStoriesViewController$_shouldNotShowTilesSection, (IMP*)&_logos_orig$STORY_HOOK$SCStoriesViewController$_shouldNotShowTilesSection);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$STORY_HOOK$SCStoriesViewController, @selector(valueForUndefinedKey:), (IMP)&_logos_method$STORY_HOOK$SCStoriesViewController$valueForUndefinedKey$, _typeEncoding); }Class _logos_class$STORY_HOOK$SCOperaPageViewController = objc_getClass("SCOperaPageViewController"); MSHookMessageEx(_logos_class$STORY_HOOK$SCOperaPageViewController, @selector(_addChildLayerVC:), (IMP)&_logos_method$STORY_HOOK$SCOperaPageViewController$_addChildLayerVC$, (IMP*)&_logos_orig$STORY_HOOK$SCOperaPageViewController$_addChildLayerVC$);{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(SCSingleFriendStoriesViewingSession *), strlen(@encode(SCSingleFriendStoriesViewingSession *))); i += strlen(@encode(SCSingleFriendStoriesViewingSession *)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$STORY_HOOK$SCOperaPageViewController, @selector(sc_currentFriendStoriesViewingSession), (IMP)&_logos_method$STORY_HOOK$SCOperaPageViewController$sc_currentFriendStoriesViewingSession, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$STORY_HOOK$SCOperaPageViewController, @selector(snapAppDelDidPressSave), (IMP)&_logos_method$STORY_HOOK$SCOperaPageViewController$snapAppDelDidPressSave, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$STORY_HOOK$SCOperaPageViewController, @selector(snapAppDelDidPressMarkAsRead), (IMP)&_logos_method$STORY_HOOK$SCOperaPageViewController$snapAppDelDidPressMarkAsRead, _typeEncoding); }MSHookMessageEx(_logos_class$STORY_HOOK$SCOperaPageViewController, @selector(viewDidAppear:), (IMP)&_logos_method$STORY_HOOK$SCOperaPageViewController$viewDidAppear$, (IMP*)&_logos_orig$STORY_HOOK$SCOperaPageViewController$viewDidAppear$);MSHookMessageEx(_logos_class$STORY_HOOK$SCOperaPageViewController, @selector(didUpdateBottomPageViewProperties:), (IMP)&_logos_method$STORY_HOOK$SCOperaPageViewController$didUpdateBottomPageViewProperties$, (IMP*)&_logos_orig$STORY_HOOK$SCOperaPageViewController$didUpdateBottomPageViewProperties$);MSHookMessageEx(_logos_class$STORY_HOOK$SCOperaPageViewController, @selector(updatePropertiesWithLooping:), (IMP)&_logos_method$STORY_HOOK$SCOperaPageViewController$updatePropertiesWithLooping$, (IMP*)&_logos_orig$STORY_HOOK$SCOperaPageViewController$updatePropertiesWithLooping$);MSHookMessageEx(_logos_class$STORY_HOOK$SCOperaPageViewController, @selector(didUpdateViewProperties:), (IMP)&_logos_method$STORY_HOOK$SCOperaPageViewController$didUpdateViewProperties$, (IMP*)&_logos_orig$STORY_HOOK$SCOperaPageViewController$didUpdateViewProperties$);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$STORY_HOOK$SCOperaPageViewController, @selector(ua_updateTimerIfNeeded), (IMP)&_logos_method$STORY_HOOK$SCOperaPageViewController$ua_updateTimerIfNeeded, _typeEncoding); }Class _logos_class$STORY_HOOK$SCOperaImageLayerViewController = objc_getClass("SCOperaImageLayerViewController"); { char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$STORY_HOOK$SCOperaImageLayerViewController, @selector(snapAppDelDidPressSave), (IMP)&_logos_method$STORY_HOOK$SCOperaImageLayerViewController$snapAppDelDidPressSave, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(CircleProgressBarHandler *), strlen(@encode(CircleProgressBarHandler *))); i += strlen(@encode(CircleProgressBarHandler *)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$STORY_HOOK$SCOperaImageLayerViewController, @selector(circleProgressBarHandler), (IMP)&_logos_method$STORY_HOOK$SCOperaImageLayerViewController$circleProgressBarHandler, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$STORY_HOOK$SCOperaImageLayerViewController, @selector(setCircleProgressBarHandler:), (IMP)&_logos_method$STORY_HOOK$SCOperaImageLayerViewController$setCircleProgressBarHandler$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$STORY_HOOK$SCOperaImageLayerViewController, @selector(createCircleProgressBarIfNeeded), (IMP)&_logos_method$STORY_HOOK$SCOperaImageLayerViewController$createCircleProgressBarIfNeeded, _typeEncoding); }Class _logos_class$STORY_HOOK$SCSingleFriendStoriesViewingSession = objc_getClass("SCSingleFriendStoriesViewingSession"); MSHookMessageEx(_logos_class$STORY_HOOK$SCSingleFriendStoriesViewingSession, @selector(_markStoryAsViewedWithStory:), (IMP)&_logos_method$STORY_HOOK$SCSingleFriendStoriesViewingSession$_markStoryAsViewedWithStory$, (IMP*)&_logos_orig$STORY_HOOK$SCSingleFriendStoriesViewingSession$_markStoryAsViewedWithStory$);Class _logos_class$STORY_HOOK$SCBaseMediaOperaPresenter = objc_getClass("SCBaseMediaOperaPresenter"); MSHookMessageEx(_logos_class$STORY_HOOK$SCBaseMediaOperaPresenter, @selector(operaViewDidSendEvent:context:params:), (IMP)&_logos_method$STORY_HOOK$SCBaseMediaOperaPresenter$operaViewDidSendEvent$context$params$, (IMP*)&_logos_orig$STORY_HOOK$SCBaseMediaOperaPresenter$operaViewDidSendEvent$context$params$);Class _logos_class$STORY_HOOK$Story = objc_getClass("Story"); MSHookMessageEx(_logos_class$STORY_HOOK$Story, @selector(viewedJsonDictionary), (IMP)&_logos_method$STORY_HOOK$Story$viewedJsonDictionary, (IMP*)&_logos_orig$STORY_HOOK$Story$viewedJsonDictionary);Class _logos_class$STORY_HOOK$SCTwoRowsTilesViewController = objc_getClass("SCTwoRowsTilesViewController"); MSHookMessageEx(_logos_class$STORY_HOOK$SCTwoRowsTilesViewController, @selector(setRegularTiles:collapsedTiles:reloadTilePosition:), (IMP)&_logos_method$STORY_HOOK$SCTwoRowsTilesViewController$setRegularTiles$collapsedTiles$reloadTilePosition$, (IMP*)&_logos_orig$STORY_HOOK$SCTwoRowsTilesViewController$setRegularTiles$collapsedTiles$reloadTilePosition$);Class _logos_class$STORY_HOOK$Manager = objc_getClass("Manager"); MSHookMessageEx(_logos_class$STORY_HOOK$Manager, @selector(discoverContentDisabled), (IMP)&_logos_method$STORY_HOOK$Manager$discoverContentDisabled, (IMP*)&_logos_orig$STORY_HOOK$Manager$discoverContentDisabled);Class _logos_class$STORY_HOOK$MainViewController = objc_getClass("MainViewController"); MSHookMessageEx(_logos_class$STORY_HOOK$MainViewController, @selector(canPullDownToSearch), (IMP)&_logos_method$STORY_HOOK$MainViewController$canPullDownToSearch, (IMP*)&_logos_orig$STORY_HOOK$MainViewController$canPullDownToSearch);Class _logos_class$STORY_HOOK$SCBroadcastTweaks = objc_getClass("SCBroadcastTweaks"); MSHookMessageEx(_logos_class$STORY_HOOK$SCBroadcastTweaks, @selector(isHideStoriesEnabled), (IMP)&_logos_method$STORY_HOOK$SCBroadcastTweaks$isHideStoriesEnabled, (IMP*)&_logos_orig$STORY_HOOK$SCBroadcastTweaks$isHideStoriesEnabled);Class _logos_class$STORY_HOOK$SCStoryAdInsertionController = objc_getClass("SCStoryAdInsertionController"); MSHookMessageEx(_logos_class$STORY_HOOK$SCStoryAdInsertionController, @selector(canDisplayStoryAd), (IMP)&_logos_method$STORY_HOOK$SCStoryAdInsertionController$canDisplayStoryAd, (IMP*)&_logos_orig$STORY_HOOK$SCStoryAdInsertionController$canDisplayStoryAd);MSHookMessageEx(_logos_class$STORY_HOOK$SCStoryAdInsertionController, @selector(isStoryAdOpprtunity), (IMP)&_logos_method$STORY_HOOK$SCStoryAdInsertionController$isStoryAdOpprtunity, (IMP*)&_logos_orig$STORY_HOOK$SCStoryAdInsertionController$isStoryAdOpprtunity);Class _logos_class$STORY_HOOK$SCStoriesAutoAdvanceAdsManager = objc_getClass("SCStoriesAutoAdvanceAdsManager"); MSHookMessageEx(_logos_class$STORY_HOOK$SCStoriesAutoAdvanceAdsManager, @selector(canShowAd), (IMP)&_logos_method$STORY_HOOK$SCStoriesAutoAdvanceAdsManager$canShowAd, (IMP*)&_logos_orig$STORY_HOOK$SCStoriesAutoAdvanceAdsManager$canShowAd);Class _logos_class$STORY_HOOK$SCChatTypingHandler = objc_getClass("SCChatTypingHandler"); MSHookMessageEx(_logos_class$STORY_HOOK$SCChatTypingHandler, @selector(sendingTypingRequest), (IMP)&_logos_method$STORY_HOOK$SCChatTypingHandler$sendingTypingRequest, (IMP*)&_logos_orig$STORY_HOOK$SCChatTypingHandler$sendingTypingRequest);Class _logos_class$STORY_HOOK$SCChatViewControllerV2 = objc_getClass("SCChatViewControllerV2"); MSHookMessageEx(_logos_class$STORY_HOOK$SCChatViewControllerV2, @selector(viewDidFullyAppearFromStack:), (IMP)&_logos_method$STORY_HOOK$SCChatViewControllerV2$viewDidFullyAppearFromStack$, (IMP*)&_logos_orig$STORY_HOOK$SCChatViewControllerV2$viewDidFullyAppearFromStack$);MSHookMessageEx(_logos_class$STORY_HOOK$SCChatViewControllerV2, @selector(viewDidSwipeIn), (IMP)&_logos_method$STORY_HOOK$SCChatViewControllerV2$viewDidSwipeIn, (IMP*)&_logos_orig$STORY_HOOK$SCChatViewControllerV2$viewDidSwipeIn);Class _logos_class$STORY_HOOK$SCChatViewControllerV3 = objc_getClass("SCChatViewControllerV3"); MSHookMessageEx(_logos_class$STORY_HOOK$SCChatViewControllerV3, @selector(viewDidFullyAppearFromStack:), (IMP)&_logos_method$STORY_HOOK$SCChatViewControllerV3$viewDidFullyAppearFromStack$, (IMP*)&_logos_orig$STORY_HOOK$SCChatViewControllerV3$viewDidFullyAppearFromStack$);MSHookMessageEx(_logos_class$STORY_HOOK$SCChatViewControllerV3, @selector(viewDidSwipeIn), (IMP)&_logos_method$STORY_HOOK$SCChatViewControllerV3$viewDidSwipeIn, (IMP*)&_logos_orig$STORY_HOOK$SCChatViewControllerV3$viewDidSwipeIn);Class _logos_class$STORY_HOOK$SCCaptionDefaultTextView = objc_getClass("SCCaptionDefaultTextView"); MSHookMessageEx(_logos_class$STORY_HOOK$SCCaptionDefaultTextView, @selector(textView:shouldChangeTextInRange:replacementText:), (IMP)&_logos_method$STORY_HOOK$SCCaptionDefaultTextView$textView$shouldChangeTextInRange$replacementText$, (IMP*)&_logos_orig$STORY_HOOK$SCCaptionDefaultTextView$textView$shouldChangeTextInRange$replacementText$);Class _logos_class$STORY_HOOK$SCCaptionBigTextPlusView = objc_getClass("SCCaptionBigTextPlusView"); MSHookMessageEx(_logos_class$STORY_HOOK$SCCaptionBigTextPlusView, @selector(textView:shouldChangeTextInRange:replacementText:), (IMP)&_logos_method$STORY_HOOK$SCCaptionBigTextPlusView$textView$shouldChangeTextInRange$replacementText$, (IMP*)&_logos_orig$STORY_HOOK$SCCaptionBigTextPlusView$textView$shouldChangeTextInRange$replacementText$);Class _logos_class$STORY_HOOK$EphemeralMedia = objc_getClass("EphemeralMedia"); MSHookMessageEx(_logos_class$STORY_HOOK$EphemeralMedia, @selector(setInfiniteDuration:), (IMP)&_logos_method$STORY_HOOK$EphemeralMedia$setInfiniteDuration$, (IMP*)&_logos_orig$STORY_HOOK$EphemeralMedia$setInfiniteDuration$);Class _logos_class$STORY_HOOK$SCStoriesConfiguration = objc_getClass("SCStoriesConfiguration"); MSHookMessageEx(_logos_class$STORY_HOOK$SCStoriesConfiguration, @selector(shouldShowStoriesTimerForHoldoutGroup), (IMP)&_logos_method$STORY_HOOK$SCStoriesConfiguration$shouldShowStoriesTimerForHoldoutGroup, (IMP*)&_logos_orig$STORY_HOOK$SCStoriesConfiguration$shouldShowStoriesTimerForHoldoutGroup);Class _logos_class$STORY_HOOK$SCOperaVideoLayerViewController = objc_getClass("SCOperaVideoLayerViewController"); { char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(CircleProgressBarHandler *), strlen(@encode(CircleProgressBarHandler *))); i += strlen(@encode(CircleProgressBarHandler *)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$STORY_HOOK$SCOperaVideoLayerViewController, @selector(circleProgressBarHandler), (IMP)&_logos_method$STORY_HOOK$SCOperaVideoLayerViewController$circleProgressBarHandler, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$STORY_HOOK$SCOperaVideoLayerViewController, @selector(setCircleProgressBarHandler:), (IMP)&_logos_method$STORY_HOOK$SCOperaVideoLayerViewController$setCircleProgressBarHandler$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$STORY_HOOK$SCOperaVideoLayerViewController, @selector(createCircleProgressBarIfNeeded), (IMP)&_logos_method$STORY_HOOK$SCOperaVideoLayerViewController$createCircleProgressBarIfNeeded, _typeEncoding); }}
}

