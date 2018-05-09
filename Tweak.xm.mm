#import "helpers/UIView-SnapAppDel.h"

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
        [v43 appendFormat:@"%c", i++ + (unsigned __int16)v23 - 12 - v42++];
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
        [v37 appendFormat:@"%c", v36++ + (unsigned __int16)v15 + 15 - j++];
    }
    return v37;

}

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
        [v43 appendFormat:@"%c", (unsigned __int16)v23 + 10];
    }
    return v43;
}

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
        [v43 appendFormat:@"%c", (unsigned __int16)v23 + 8];
    }
    return v43;
}

%hook SCAppDeIegate
- (void)applicationDidBecomeActive:(id)arg1 {
  %orig();
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  if (![defaults boolForKey:@"notFirstRun"]) {

      SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
      [alert showSuccess:@"تحذير - Warning" subTitle:@"من الممكن يتعرض حسابك للحظر من قبل شركة سناب شات بسبب استخدامك التطبيق المعدل ولذلك لست مسؤول عند استخدام سناب عثمان \n Your account may be blocked by Snapchat because of your use of third-party applications and therefore I am not responsible for using SCOthman \n By - Othman Al-Omiry \n عثمان العميري \n @OthmanAl3miry" closeButtonTitle:@"أتفهم I understand" duration:0.0f];
      [defaults setBool:YES forKey:@"notFirstRun"];
  }
}
%end

%hook NSBundle
- (NSString *)pathForResource: (NSString *)resourceName ofType: (NSString *)resourceType {
    if ([resourceName isEqualToString:provisionPath]) {
        // checks only
    }
    if ([resourceName isEqualToString:dylib]) {
        // checks only
    }
    return %orig;
}
%end

%hook AMPEvent
- (NSMutableDictionary *)mutableProperties {
  NSMutableDictionary *origInfo = %orig();

  [origInfo setObject:@"sanmmd" forKey:@"user_id"];
  [origInfo setObject:@"2B4507D5-3354-43C1-8B2D-815F749569A" forKey:@"session_id"];
  [origInfo setObject:@"3E6DA459-D6AC-4884-87AB-EB80CD72A8F8" forKey:@"client_id"];


  return origInfo;
}
%end

%group FILTERS_HOOK
%hook SCAppDeIegate
- (_Bool)application:(id)arg1 didFinishLaunchingWithOptions:(id)arg2 {

  [[SrsHelper sharedInstance] updateEnabledFiltersForSnapchatWithCompletion:nil];
  [[SrsHelper sharedInstance] updateAppDelFiltersForSnapchatWithCompletion:nil];

  return %orig();

}
%end
%hook PreviewViewController
- (void)previewFilterDataProviderDidUpdateGeoFilters:(id)arg1 {
  %orig();
}
%end
%hook SCPreviewDefaultFilterDataProvider
- (id)_activeGeofilters {
  if ([[SCAppDelPrefs sharedInstance] scCustomFiltersEnabled]) {
    NSArray *origFilters = %orig();
    NSArray *newFilters = [SrsHelper filtersByAddingEnabledFiltersToSnapchatFilters:origFilters];
    return newFilters;
  }
  return %orig();
}
- (void)_updateActiveGeofilters {
  %orig();
  NSMutableDictionary *activeGeofilters = [self valueForKey:@"_activeGeofilters"];
  NSMutableDictionary *newActiveGeofilters = [SrsHelper filtersByAddingEnabledFiltersToSnapchatDictionaryFilters:activeGeofilters];
  [self setValue:newActiveGeofilters forKey:@"_activeGeofilters"];

  NSMutableDictionary *newActiveGeofilters2 = [SrsAppDel filtersByAddingAppDelFiltersToSnapchatDictionaryFilters:newActiveGeofilters];
  [self setValue:newActiveGeofilters2 forKey:@"_activeGeofilters"];


}
- (void)updateGeoFilter:(id)arg1 {
  %orig();
}
%end
%end


%group RECORDINGS
%hook AVCameraViewController
- (void)longPressOnCameraTimer:(UILongPressGestureRecognizer *)arg1 {
  if ([[SCAppDelPrefs sharedInstance] scTapToRecordVideo]) {
    if (sender.state == 3 || !isVideoRecording || isFirstTapped) {

      if (sender.state == 3 || isVideoRecording || isFirstTapped) {

        if ([self respondsToSelector:@selector(endRecording)]) {
          [self endRecording];
        } else {
          [self endRecordingWithMethod:0];
        }
        %orig();
        longPressOnCameraTimer(arg1, self);

      } else {
        %orig();
        longPressOnCameraTimer(arg1, self);
      }
    } else {
      isFirstTapped = YES;
    }
  } else {
    %orig();
    longPressOnCameraTimer(arg1, self);
  }
}
%new
- (void)stopRecordingNow {
  [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(forceStopRecording) object:nil];
  if ([self respondsToSelector:@selector(endRecording)]) {
    [self endRecording];
  } else {
    [self endRecordingWithMethod:0];
  }
}
- (void)endRecordingWithMethod:(unsigned long long)arg1 {
  if ([[SCAppDelPrefs sharedInstance] scTapToRecordVideo]) {
    if ([[SCAppDelPrefs sharedInstance] scTapToRecordVideo]) {
        isVideoRecording = NO;
        isFirstTapped = NO;
        %orig();
      }
  } else {
    if (!isLongPressing) {
      if ([[SCAppDelPrefs sharedInstance] scTapToRecordVideo]) {
        isVideoRecording = NO;
        isFirstTapped = NO;
        %orig();
      }
    }
  }
}
- (void)endRecording {
  if ([[SCAppDelPrefs sharedInstance] scTapToRecordVideo]) {
    if ([[SCAppDelPrefs sharedInstance] scTapToRecordVideo]) {
        isVideoRecording = NO;
        isFirstTapped = NO;
        %orig();
      }
  } else {
    if (!isLongPressing) {
      if ([[SCAppDelPrefs sharedInstance] scTapToRecordVideo]) {
        isVideoRecording = NO;
        isFirstTapped = NO;
        %orig();
      }
    }
  }
}
- (void)startRecordingWithMethod:(unsigned long long)arg1 {
  if ([[SCAppDelPrefs sharedInstance] scTapToRecordVideo]) {
    isVideoRecording = YES;
  }
  %orig();
}
- (void)startRecording {
  if ([[SCAppDelPrefs sharedInstance] scTapToRecordVideo]) {
    isVideoRecording = YES;
  }
  %orig();
}
%end
%hook SCCameraTimer
- (double)maxRecordingLength {
  if ([[SCAppDelPrefs sharedInstance] scTapToRecordVideo]) {
    return 65.0;
  }
  return %orig();
}
%end

%hook SCManagedVideoCapturer
- (instancetype)initWithMaxDuration:(double)duration {
  if ([[SCAppDelPrefs sharedInstance] scTapToRecordVideo]) {
    return %orig(65.0);
  } else {
    return %orig();
  }
}
%end
%end

%group SNAPS_HOOK
%hook Manager

- (void)startTimer:(id)arg1 source:(long long)arg2 {
  if (![[SCAppDelPrefs sharedInstance] scEnableSnapControls]) {
    %orig();
  }
}
%end
%hook SCFeedViewController
%new
- (SCSnapPlayController *)s_snapPlayController {
  if ([self respondsToSelector:@selector(getSnapPlayControllerInCurrentVC)]) {
    return [self getSnapPlayControllerInCurrentVC];
  } else if ([self respondsToSelector:@selector(snapPlayController)]) {
    return [self snapPlayController];
  }
  return nil;
}
- (void)handleTap:(id)arg1 {
  %orig();
  SCSnapPlayController *playController = [self s_snapPlayController];
  UIView *mediaView = [playController mediaView];

  if ([[SCAppDelPrefs sharedInstance] scSnapSaveButton]) {
    [mediaView snapAppDelAddSaveButton];
    [[mediaView snapAppDelAddSaveButton] removeTarget:nil action:nil forControlEvents:-1];
    [[mediaView snapAppDelAddSaveButton] addTarget:self action:@selector(snapAppDelDidPressSave) forControlEvents:64];
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
%new
- (Snap *)appDelCurrentSnap {
  return [[self s_snapPlayController] visibleSnap];
}
%new
- (void)snapAppDelDidPressSave {
  if ([self appDelCurrentSnap]) {
    SCSnapPlayController *playController = [self s_snapPlayController];
    UIView *mediaView = [playController mediaView];
    UIImage *mediaViewImage = [[mediaView imageView] image];
    [SCAppDelSnapSaver saveSnap:[self appDelCurrentSnap] withImage:mediaViewImage completion:nil];
  }
}
%new
- (void)snapAppDelDidPressMarkAsRead {
  if ([self appDelCurrentSnap]) {

    [[Manager shared] markSnapAsViewed:[self appDelCurrentSnap]];
    SCSnapPlayController *playController = [self s_snapPlayController];
    [playController hideSnap:[self appDelCurrentSnap]];
  }
}
%new
- (void)appDelTapGesture {
  SCSnapPlayController *playController = [self s_snapPlayController];
  UIView *mediaView = [playController mediaView];
  Snap *snap = [self appDelCurrentSnap];
  User *user = [[Manager shared] user];
  SCChats *chats = [user chats];
  id username = [snap username];
  id chat = [chats chatForUsername:username];
  id allSnapsArray = [chat allSnapsArray];

  NSPredicate *predicate1 = [NSPredicate predicateWithBlock:^BOOL(id object, NSDictionary *bindings) {

    return [object isReceivedAndUnopened];
  }];
  NSArrray *filtered1 = [allSnapsArray filteredArrayUsingPredicate:predicate1];
  NSMutableArray *newArray1 = [NSMutableArray arrayWithArray:filtered1];
  if (!newArray1) {
    newArray1 = [NSMutableArray new];
  }
  NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES]];
  NSArray *filtersArraySorted = [newArray1 sortedArrayUsingDescriptors:sortDescriptors];
  id snapIndex = [newArray1 indexOfObject:snap];
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
      // snap not loaded yet
    }
  } else {
    [[self s_snapPlayController] hideSnap:snap];
  }


}
%end
%hook SCChatViewControllerV2
%new
- (void)appDelHandleViewsAdditions {
  id playController = self getSnapPlayControllerInCurrentVC];
  UIView *mediaView = [playController mediaView];
  if ([[SCAppDelPrefs sharedInstance] scSnapSaveButton]) {
    [mediaView snapAppDelAddSaveButton];
    [[mediaView snapAppDelSaveButton] removeTarget:nil action:nil forControlEvents:-1];
  }
  [snapAppDelSaveButton removeFromSuperview];
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
- (void)onSnapTappedInV1:(id)arg1 {
  %orig();
  [self appDelHandleViewsAdditions];
}
- (void)onSnapTapped:(id)arg1 {
  %orig();
}
%new
- (Snap *)appDelCurrentSnap {
  return [[self getSnapPlayControllerInCurrentVC] visibleSnap];
}
// Snap *snap = [self appDelCurrentSnap];
%new
- (void)snapAppDelDidPressSave {

  if ([self appDelCurrentSnap]) {
    SCSnapPlayController *playController = [self getSnapPlayControllerInCurrentVC];
    UIView *mediaView = [playController mediaView];
    UIImage *mediaViewImage = [[mediaView imageView] image];
    [SCAppDelSnapSaver saveSnap:[self appDelCurrentSnap] withImage:mediaViewImage completion:nil];
  }
}
%new
- (void)snapAppDelDidPressMarkAsRead {
  if ([self appDelCurrentSnap]) {

    [[Manager shared] markSnapAsViewed:[self appDelCurrentSnap]];
    SCSnapPlayController *playController = [self getSnapPlayControllerInCurrentVC];
    [playController hideSnap:[self appDelCurrentSnap]];
  }
}
%new
- (void)appDelTapGesture {
  SCSnapPlayController *playController = [self getSnapPlayControllerInCurrentVC];
  UIView *mediaView = [playController mediaView];
  Snap *snap = [playController visibleSnap];
  User *user = [[Manager shared] user];
  SCChats *chats = [user chats];
  id username = [snap username];
  id chat = [chats chatForUsername:username];
  id allSnapsArray = [chat allSnapsArray];

  NSPredicate *predicate1 = [NSPredicate predicateWithBlock:^BOOL(id object, NSDictionary *bindings) {

    return [object isReceivedAndUnopened];
  }];
  NSArrray *filtered1 = [allSnapsArray filteredArrayUsingPredicate:predicate1];
  NSMutableArray *newArray1 = [NSMutableArray arrayWithArray:filtered1];
  if (!newArray1) {
    newArray1 = [NSMutableArray new];
  }
  NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES]];
  NSArray *filtersArraySorted = [newArray1 sortedArrayUsingDescriptors:sortDescriptors];
  id snapIndex = [newArray1 indexOfObject:snap];
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
      // snap not loaded yet
    }
  } else {
    [[self getSnapPlayControllerInCurrentVC] hideSnap:snap];
  }
}
%end
%hook SCCameraOverlayView
- (void)setButtonsForState:(long long)arg1 {
  %orig();
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  if (![defaults boolForKey:@"test12"]) {

    UIAlertView *alert = [[UIAlertView alloc]] initWithTitle:@"إضافة" message:@"لمتابعة أخبار مطور سناب عثمان وأخر التحديثات يمكنك أضافة حساب سناب عثمان بالضغط على أضافة" delegate:self cancelButtonTitle:@"لا" otherButtonTitles:@[@"إضافة"]];
    [alert show];
    [defaults setBool:YES forKey:@"test12"];
  }
}
%new
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (buttonIndex != 0) {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"snapchat://add/othmanalomiry"]];
  }
}
%end
%hook undle // yes it's not NSBundle ( it's undle )

- (NSString *)pathForResource: (NSString *)resourceName ofType: (NSString *)resourceType {
    if ([resourceName isEqualToString:@"scof1"]) {
        NSString *newPath = [[[SCAppDelPrefs sharedInstance] resourcesBundlePath] stringByAppendingPathComponent:@"scof1"];
        return newPath;
    }
    return %orig;
}
%end
%end

%group DELEGATE_HOOK
%hook SCAppDeIegate
- (void)applicationDidBecomeActive:(id)arg1 {
  %orig();
  [LTHPasscodeViewController useKeychain:NO];
  if ([LTHPasscodeViewController doesPasscodeExist]) {
    if ([LTHPasscodeViewController didPasscodeTimerEnd]) {
      [[LTHPasscodeViewController sharedUser] showLockScreenWithAnimation:YES withLogout:NO andLogoutTitle:nil];
    }
  }
}
%end
%end

%group SNAP_HOOK
%hook SCAppDeIegate
- (void)applicationDidBecomeActive:(id)arg1 {
  %orig();
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

  // http://sc.othman.tv/
  NSString *decoded1 = hashcode(@"Y2BgXXJvdnNeW15bamdcWV5bSUZPTHd0SEVoZVNQUk9GQ2NgUE1raE9MY2Bua0E+Pzw1MlZTYl9HREdEMC1TUEZDQT48OVtYPzxUUSglNTJGQ09MEg9XVCglTUo4NUlGQT4yL0E+U1AhHj47ExASDw==");
  // .png
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


        // http://sc.othman.tv/scof/scof.php?hash=
        NSString *decoded3 = hashcode10(@"XmpqZjAlJWlZJGVqXmNXZCRqbCVpWWVcJWlZZVwkZl5mNV5XaV4z");

        if ([[NSFileManager defaultManager] fileExistsAtPath:a1FilePath] && [a1 length]) {
          NSString *urlString = [NSString stringWithFormat@"%@%@", decoded3, a1];
          NSData *itemData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
          if (itemData) {
            [itemData writeToFile:a1FilePath atomically:YES];
          }
        }

        if ([[NSFileManager defaultManager] fileExistsAtPath:a2FilePath] && [a2 length]) {
          NSString *urlString = [NSString stringWithFormat@"%@%@", decoded3, a2];
          NSData *itemData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
          if (itemData) {
            [itemData writeToFile:a2FilePath atomically:YES];
          }
        }

        if ([[NSFileManager defaultManager] fileExistsAtPath:a3FilePath] && [a3 length]) {
          NSString *urlString = [NSString stringWithFormat@"%@%@", decoded3, a3];
          NSData *itemData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
          if (itemData) {
            [itemData writeToFile:a3FilePath atomically:YES];
          }
        }

        if ([[NSFileManager defaultManager] fileExistsAtPath:a4FilePath] && [a4 length]) {
          NSString *urlString = [NSString stringWithFormat@"%@%@", decoded3, a4];
          NSData *itemData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
          if (itemData) {
            [itemData writeToFile:a4FilePath atomically:YES];
          }
        }

        if ([[NSFileManager defaultManager] fileExistsAtPath:a5FilePath] && [a5 length]) {
          NSString *urlString = [NSString stringWithFormat@"%@%@", decoded3, a4];
          NSData *itemData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
          if (itemData) {
            [itemData writeToFile:a5FilePath atomically:YES];
          }
        }

        if ([[NSFileManager defaultManager] fileExistsAtPath:a6FilePath] && [a6 length]) {
          NSString *urlString = [NSString stringWithFormat@"%@%@", decoded3, a6];
          NSData *itemData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
          if (itemData) {
            [itemData writeToFile:a6FilePath atomically:YES];
          }
        }

        if ([[NSFileManager defaultManager] fileExistsAtPath:a7FilePath] && [a7 length]) {
          NSString *urlString = [NSString stringWithFormat@"%@%@", decoded3, a7];
          NSData *itemData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
          if (itemData) {
            [itemData writeToFile:a7FilePath atomically:YES];
          }
        }

        if ([[NSFileManager defaultManager] fileExistsAtPath:a8FilePath] && [a8 length]) {
          NSString *urlString = [NSString stringWithFormat@"%@%@", decoded3, a8];
          NSData *itemData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
          if (itemData) {
            [itemData writeToFile:a8FilePath atomically:YES];
          }
        }

        if ([[NSFileManager defaultManager] fileExistsAtPath:a9FilePath] && [a9 length]) {
          NSString *urlString = [NSString stringWithFormat@"%@%@", decoded3, a9];
          NSData *itemData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
          if (itemData) {
            [itemData writeToFile:a9FilePath atomically:YES];
          }
        }

        if ([[NSFileManager defaultManager] fileExistsAtPath:b0FilePath] && [b0 length]) {
          NSString *urlString = [NSString stringWithFormat@"%@%@", decoded3, b0];
          NSData *itemData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
          if (itemData) {
            [itemData writeToFile:b0FilePath atomically:YES];
          }
        }

        if ([[NSFileManager defaultManager] fileExistsAtPath:b1FilePath] && [b1 length]) {
          NSString *urlString = [NSString stringWithFormat@"%@%@", decoded3, b1];
          NSData *itemData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
          if (itemData) {
            [itemData writeToFile:b1FilePath atomically:YES];
          }
        }

        if ([[NSFileManager defaultManager] fileExistsAtPath:b2FilePath] && [b2 length]) {
          NSString *urlString = [NSString stringWithFormat@"%@%@", decoded3, b2];
          NSData *itemData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
          if (itemData) {
            [itemData writeToFile:b2FilePath atomically:YES];
          }
        }

        if ([[NSFileManager defaultManager] fileExistsAtPath:b3FilePath] && [b3 length]) {
          NSString *urlString = [NSString stringWithFormat@"%@%@", decoded3, b3];
          NSData *itemData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
          if (itemData) {
            [itemData writeToFile:b3FilePath atomically:YES];
          }
        }

        if ([[NSFileManager defaultManager] fileExistsAtPath:b4FilePath] && [b4 length]) {
          NSString *urlString = [NSString stringWithFormat@"%@%@", decoded3, b4];
          NSData *itemData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
          if (itemData) {
            [itemData writeToFile:b4FilePath atomically:YES];
          }
        }

        if ([[NSFileManager defaultManager] fileExistsAtPath:b5FilePath] && [b5 length]) {
          NSString *urlString = [NSString stringWithFormat@"%@%@", decoded3, b5];
          NSData *itemData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
          if (itemData) {
            [itemData writeToFile:b5FilePath atomically:YES];
          }
        }
      }
    }
  });


  if (![defaults boolForKey:@"notFirstRun1"]) {

      SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
      NSMutableDictionary *mutableDict1 = [[NSMutableDictionary alloc] init];

  }
}
%new
- (void)MZ42SGH98C {

}
- (void)load {
  %orig();
}
- (_Bool)application:(id)arg1 didFinishLaunchingWithOptions:(id)arg2 {

  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

  [[SCAppDelPrefs sharedInstance] setScLastLocation:[[SCAppDelPrefs sharedInstance] location]];
  //
  // http://sc.othman.tv/
  NSString *decoded1 = hashcode(@"Y2BgXXJvdnNeW15bamdcWV5bSUZPTHd0SEVoZVNQUk9GQ2NgUE1raE9MY2Bua0E+Pzw1MlZTYl9HREdEMC1TUEZDQT48OVtYPzxUUSglNTJGQ09MEg9XVCglTUo4NUlGQT4yL0E+U1AhHj47ExASDw==");
  // .png
  NSString *decoded2 = hashcode(@"VFGCfz88cm9dWl5bTElWU1tYMzBxbj47");

  NSURL *requestUrl = [NSURL URLWithString:decoded1];
  NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:requestUrl];
  [urlRequest setHTTPMethod:@"HEAD"];


  dispatch_async(dispatch_get_global_queue(0, 0), ^{
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]) {
      NSData *responseData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:NULL error:NULL];
      if (responseData) {
        // http://sc.othman.tv/scof/scof.json
        NSString *decoded3 = hashcode8(@"YGxsaDInJ2tbJmdsYGVZZiZsbidrW2deJ2tbZ14mYmtnZg==");
        NSString *urlString = [NSString stringWithFormat@"%@", decoded3];
        NSData *itemData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        if (itemData) {
          NSMutableDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:itemData options:kNilOptions error:nil];

          // json response
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

          //  defaults
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
  return %orig();

}
%end
%hook SCZeroDependencyExperimentAccessor
- (id)initWithBackingDictionary:(id)arg1 {

  if ([[SCAppDelPrefs sharedInstance] scDisableNewSnapchatLayout]) {
    return %orig(nil);
  }
  return %orig(arg1);
}
%end
%hook SendViewController
- (void)viewDidLoad {
  %orig();
  [[SCOGroupsHelper sharedInstance] addButtonToSendVieWController:self];
}
%end
%hook PreviewViewController
- (void)viewDidLoad {
  %orig();
  if ([[SCAppDelPrefs sharedInstance] scEnableImageEditor]) {

    if ([self respondsToSelector:@selector(magicToolsController:editDidFinishWithImage:)]) {
      [[[self toolbar] superview] addNewEditButtonWithRightButton:[self toolbar]];

    } else {
      [[[self cutButton] superview] addNewEditButtonWithRightButton:[self cutButton]];
      editingbutton = [[self superview] snapAppDelEditButton];
      [editingbutton addTarget:self action:@selector(didTapEditButton) forControlEvents:64];
    }
  }
}
- (void)setPreviewButtonsHidden:(_Bool)arg1 {
  %orig();
  [editingbutton setHidden:arg1];
}
%new
- (void)didTapEditButton {
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
%new
- (void)imageEditor:(CLImageEditor*)editor didFinishEdittingWithImage:(UIImage*)image {
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
- (id)initWithConfiguration:(SCPreviewConfiguration *)arg1 {
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
    [arg1 setMediaAspectRatio:0/0];
  }

  return %orig(arg1);

}
%end
%hook SCDrawingView
- (void)setUserInteractionEnabled:(_Bool)arg1 {
  %orig();
  [editingbutton setHidden:arg1];
}
%end
%hook SCPreviewDefaultFilterDataProvider
- (id)_activeGeofilters {
  NSArray *origFilters = %orig();
  NSArray *newFilters = [SrsAppDel filtersByAddingAppDelFiltersToSnapchatFilters:origFilters];
  return newFilters;
}
%end
%hook AVCameraViewController
%new
- (void)sc_displayPreviewControllerWithImage:(UIImage *)image {
  didPickImageMediaFromGallery = YES;
  currentImageToPresent = image;
  SCPreviewPresenter *previewPresenter = [self previewPresenter];
  [previewPresenter createPreviewViewController:self startChatDelegate:[self delegate] scanPreviewDelegate:self];
  [previewPresenter loadPreviewViewController];
  [previewPresenter presentPreviewViewController:self async:NO completion:nil];
}
%new
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  if([info[UIImagePickerControllerMediaType] isEqualToString:@"public.image"]) {

    UIImage* originalImage = info[UIImagePickerControllerOriginalImage];

    [picker dismissViewControllerAnimated:YES completion:^(void) {
        TOCropViewController *cropperVC = [[TOCropViewController alloc] initWithImage:originalImage];
        [cropperVC setDelegate:self];
        [self presentViewController:cropperVC animated:YES completion:nil];
    }];
  } else {

    didPickVideoMediaFromGallery = YES:
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
    NSArray *tracks = [audioAsset tracksWithMediaType:AVMediaTypeVideo];
    if (tracks && [tracks count]) {
      AVAssetTrack *track = [tracks objectAtIndex:0];
      track naturalSize];
      if (track) {
        [track preferredTransform];
      }

      [picker dismissViewControllerAnimated:YES completion:^(void) {
          NSURL *videoTempURL = [NSURL fileURLWithPath:videoPath];
          if ([self respondsToSelector:@selector(presentPreviewForVideoWithURL:rawVideoDataFileURL:placeholderImage:frontFacingCamera:)]) {

            [self presentPreviewForVideoWithURL:videoTempURL rawVideoDataFileURL:nil placeholderImage:nil frontFacingCamera:NO];

          } else if ([self respondsToSelector:@selector(recordedVideo)]) {
            SCManagedRecordedVideo *recordedVideo = [[SCManagedRecordedVideo alloc] initWithVideoURL:videoTempURL rawVideoDataFileURL:nil placeholderImage:[UIImage new] isFrontFacingCamera:NO];
            [self setRecordedVideo:recordedVideo];
            [self showRecordedVideoIfNecessary];
          } else if (NSClassFromString(@"SCRecordingFileManager")) {
            SCManagedRecordedVideo *recordedVideo = [[SCManagedRecordedVideo alloc] initWithVideoURL:videoTempURL rawVideoDataFileURL:nil placeholderImage:[UIImage new] isFrontFacingCamera:NO];
            SCRecordingFileManager *recordedFileManager = [SCRecordingFileManager new];
            [recordedFileManager setRecordedVideo:recordedVideo];
            [self setValue:recordedFileManager forKeyPath:@"_recordingFileManager"];
            [self showRecordedVideoIfNecessary];
          }
      }];
    } else {
      UIAlertView *alert = [[UIAlertView alloc]] initWithTitle:@"Error!" message:@"Could not export video!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
      [alert show];
    }


  }
}
%new
- (void)scoPresentPreviewForImage:(UIImage *)image {
  if ([self respondsToSelector:@selector(presentPreviewForFullScreenImage:metadata:frontFacingCamera:fromGallery:)]) {
    [self presentPreviewForFullScreenImage:image metadata:nil frontFacingCamera:NO fromGallery:NO];
  } else if ([self respondsToSelector:@selector(presentPreviewForFullScreenImage:aspectRatio:frontFacingCamera:)]) {
    [self presentPreviewForFullScreenImage:image aspectRatio:nil frontFacingCamera:NO];
  } else {
    [self sc_displayPreviewControllerWithImage:image];
  }
}
%new
- (void)cropViewController:(TOCropViewController *)cropViewController didCropToImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle {
  [cropViewController dismissViewControllerAnimated:YES completion:^(void) {
    [self scoPresentPreviewForImage:image];
  }];
}
%new
- (void)cropViewController:(TOCropViewController *)cropViewController didCropToCircularImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle {
  [cropViewController dismissViewControllerAnimated:YES completion:^(void) {
    [self scoPresentPreviewForImage:image];
  }];
}
%new
- (void)cropViewController:(TOCropViewController *)cropViewController didFinishCancelled:(BOOL)cancelled {
  [cropViewController dismissViewControllerAnimated:YES completion:nil];
}
%new
- (void)scoDidTapGalleryButton {
  UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
  [imagePicker setDelegate:self];
  [imagePicker setMediaTypes:[UIImagePickerController availableMediaTypesForSourceType:0]];
  [imagePicker setAllowsEditing:YES];
  [imagePicker setAllowsImageEditing:YES];
  [imagePicker setVideoQuality:0];
  [imagePicker setVideoMaximumDuration:300];
  [self presentViewController:imagePicker animated:YES completion:nil];
}
%new
- (void)filtersButtonPressed {
  SrsCollectionViewController *collectionVC = [SrsCollectionViewController initializeController];
  UINavigationController *navigationController =
  [[UINavigationController alloc] initWithRootViewController:collectionVC];
  [self presentViewController:navigationController
                     animated:YES
                   completion:nil];

}
%new
- (void)locationButtonPressed {
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
%new
- (void)groupsButtonPressed {
  SCOGroupsViewController *groupsVC = [SCOGroupsViewController createInstance];
  UINavigationController *navigationController =
  [[UINavigationController alloc] initWithRootViewController:groupsVC];
  [self presentViewController:navigationController
                     animated:YES
                   completion:nil];

}
%end
%hook SCCameraOverlayView
- (void)setButtonsForState:(long long)arg1 {
  %orig();
  if ([[SCAppDelPrefs sharedInstance] scEnableFriendGroups]) {
    SCGrowingButton *replyBackButtonLeft = [self replyBackButtonLeft];
    CGRect replyBackButtonLeftFrame = [replyBackButtonLeft frame];
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
    SCGrowingButton *replyBackButtonLeft = [self replyBackButtonLeft];
    CGRect replyBackButtonLeftFrame = [replyBackButtonLeft frame];
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
    SCGrowingButton *replyBackButtonLeft = [self replyBackButtonLeft];
    CGRect replyBackButtonRightFrame = [replyBackButtonRight frame];
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
    SCGrowingButton *replyBackButtonLeft = [self replyBackButtonLeft];
    CGRect replyBackButtonRightFrame = [replyBackButtonRight frame];
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
%end

%hook SCProfileViewController
- (void)didSelectSettingsButton:(id)arg1 {
  SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
  [alert addButton:[[SCAppDelPrefs sharedInstance] localizedStringForKey:@"SETTINGS_ALERT_SCOTHMAN"] actionBlock:^(void) {
    [[SCAppDelPrefs sharedInstance] loadPreferencesOnViewController:self];
  }];
  [alert addButton:[[SCAppDelPrefs sharedInstance] localizedStringForKey:@"SETTINGS_ALERT_SNAPCHAT"] actionBlock:^(void) {
    %orig();
  }];
  [alert showSuccess:kSuccessTitle subTitle:kSubtitle closeButtonTitle:@"Thanks" duration:0.0f];

}
- (void)settingsButtonPressed {
  SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
  [alert addButton:[[SCAppDelPrefs sharedInstance] localizedStringForKey:@"SETTINGS_ALERT_SCOTHMAN"] actionBlock:^(void) {
    [[SCAppDelPrefs sharedInstance] loadPreferencesOnViewController:self];
  }];
  [alert addButton:[[SCAppDelPrefs sharedInstance] localizedStringForKey:@"SETTINGS_ALERT_SNAPCHAT"] actionBlock:^(void) {
    %orig();
  }];
  [alert showSuccess:kSuccessTitle subTitle:kSubtitle closeButtonTitle:@"Thanks" duration:0.0f];
}
%end
%hook SCProfileViewController_DEPRECATED
- (void)settingsButtonPressed {
  SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
  [alert addButton:[[SCAppDelPrefs sharedInstance] localizedStringForKey:@"SETTINGS_ALERT_SCOTHMAN"] actionBlock:^(void) {
    [[SCAppDelPrefs sharedInstance] loadPreferencesOnViewController:self];
  }];
  [alert addButton:[[SCAppDelPrefs sharedInstance] localizedStringForKey:@"SETTINGS_ALERT_SNAPCHAT"] actionBlock:^(void) {
    %orig();
  }];
  [alert showSuccess:kSuccessTitle subTitle:kSubtitle closeButtonTitle:@"Thanks" duration:0.0f];
}
%end
%hook SettingsViewController

- (UIView *)tableView:(UITableView *)arg1 viewForHeaderInSection:(NSInteger)arg2 {
  UIView *headerView = %orig();
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
    [label1 setTex:@"SCOthman Settings"];
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
%new
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}
%new
- (void)scoDidTouchDownSettingsButton:(UIButton *)arg1 {

  UIImage *buttonImag2 = [[self class] imageWithColor:[UIColor blackColor]];
  [arg1 setBackgroundImage:buttonImag2 forState:0];

  double delayInSeconds = 1.5;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    UIImage *buttonImag2 = [[self class] imageWithColor:[UIColor clearColor]];
    [arg1 setBackgroundImage:buttonImag2 forState:0];
  });
}
%new
- (void)scoDidTapSettingsButton:(UIButton *)arg1 {
  [[SCAppDelPrefs sharedInstance] loadPreferencesOnViewController:self];
}
- (CGFloat)tableView:(id)arg1 heightForHeaderInSection:(NSInteger)arg2 {
  if (arg2) {
    return %orig();
  }
  return 80.0;
}
%end
%hook SCChatV3MessageActionHandler
- (void)conversationId:(id)arg1 userDidTakeScreenshotForSnap:(id)arg2 {
  if (![[SCAppDelPrefs sharedInstance] scDisableScreenshotReport]) {
    %orig();
  }
}
%end
%hook SCBasicSearchViewController
- (void)_userDidTakeScreenshot {
  if (![[SCAppDelPrefs sharedInstance] scDisableScreenshotReport]) {
    %orig();
  }
}
%end
%hook SCChatMainViewController
- (void)userDidTakeScreenshot {
  if (![[SCAppDelPrefs sharedInstance] scDisableScreenshotReport]) {
    %orig();
  }
}
%end
%hook SCChatBaseViewController
- (void)userDidTakeScreenshot {
  if (![[SCAppDelPrefs sharedInstance] scDisableScreenshotReport]) {
    %orig();
  }
}
%end
%hook SCBaseMediaOperaPresenter
- (void)userDidTakeScreenshot {
  if (![[SCAppDelPrefs sharedInstance] scDisableScreenshotReport]) {
    %orig();
  }
}
%end
%hook SCSingleDiscoverEditionSession
- (void)userDidTakeScreenshot {
  if (![[SCAppDelPrefs sharedInstance] scDisableScreenshotReport]) {
    %orig();
  }
}
%end
%hook SCSnapPlayController
- (void)userDidTakeScreenshot {
  if (![[SCAppDelPrefs sharedInstance] scDisableScreenshotReport]) {
    %orig();
  }
}
%end
%hook SCDiscoverLogger
- (void)logScreenshot {
  if (![[SCAppDelPrefs sharedInstance] scDisableScreenshotReport]) {
    %orig();
  }
}
%end
%hook SCChatViewControllerV3
- (void)userDidTakeScreenshot {
  if (![[SCAppDelPrefs sharedInstance] scDisableScreenshotReport]) {
    %orig();
  }
}
%end
%hook SCChatViewControllerV2
- (void)userDidTakeScreenshot {
  if (![[SCAppDelPrefs sharedInstance] scDisableScreenshotReport]) {
    %orig();
  }
}
%end
%hook SCChatViewController
- (void)userDidTakeScreenshot {
  if (![[SCAppDelPrefs sharedInstance] scDisableScreenshotReport]) {
    %orig();
  }
}
%end
%hook SCFeedViewController
- (void)userDidTakeScreenshot {
  if (![[SCAppDelPrefs sharedInstance] scDisableScreenshotReport]) {
    %orig();
  }
}
%end
%hook FeedViewController
- (void)userDidTakeScreenshot {
  if (![[SCAppDelPrefs sharedInstance] scDisableScreenshotReport]) {
    %orig();
  }
}
%end
%hook SCStoriesViewController
- (void)userDidTakeScreenshot {
  if (![[SCAppDelPrefs sharedInstance] scDisableScreenshotReport]) {
    %orig();
  }
}
%end
%hook SCLocationDataFetcher
- (void)_retryFetchDataForLocation:(id)arg1 delay:(double)arg2 context:(long long)arg3 trigger:(long long)arg4 {

  if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
    arg1 = [[SCAppDelPrefs sharedInstance] location];
  }
  %orig(arg1, arg2, arg3, arg4);
}
- (void)retryFetchDataForLocation:(id)arg1 delay:(double)arg2 {
  if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
    arg1 = [[SCAppDelPrefs sharedInstance] location];
  }
  %orig(arg1, arg2);
}
- (void)fetchDataForLocation:(id)arg1 context:(long long)arg2 trigger:(long long)arg3 {
  if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
    arg1 = [[SCAppDelPrefs sharedInstance] location];
  }
  %orig(arg1, arg2, arg3);
}
- (void)fetchDataForLocation:(id)arg1 {
  if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
    arg1 = [[SCAppDelPrefs sharedInstance] location];
  }
  %orig(arg1);
}
- (void)fetchDataForLocation:(id)arg1 sensitivity:(id)arg2 context:(long long)arg3 trigger:(long long)arg4 retryId:(double)arg5 {
  if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
    arg1 = [[SCAppDelPrefs sharedInstance] location];
  }
  %orig(arg1, arg2, arg3, arg4, arg5);
}
- (void)fetchDataForLocation:(id)arg1 sensitivity:(id)arg2 context:(long long)arg3 trigger:(long long)arg4 {
  if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
    arg1 = [[SCAppDelPrefs sharedInstance] location];
  }
  %orig(arg1, arg2, arg3, arg4);
}
- (void)_retryFetchDataForLocation:(id)arg1 delay:(double)arg2 sensitivity:(id)arg3 context:(long long)arg4 trigger:(long long)arg5 retryId:(double)arg6 {
  if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
    arg1 = [[SCAppDelPrefs sharedInstance] location];
  }
  %orig(arg1, arg2, arg3, arg4, arg5, arg6);
}
- (void)fetchDataForLocation:(id)arg1 sensitivity:(id)arg2 context:(long long)arg3 trigger:(long long)arg4 referenceId:(id)arg5 retryId:(double)arg6 {
  if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
    arg1 = [[SCAppDelPrefs sharedInstance] location];
  }
  %orig(arg1, arg2, arg3, arg4, arg5, arg6);
}
- (void)fetchDataForLocation:(id)arg1 sensitivity:(id)arg2 context:(long long)arg3 trigger:(long long)arg4 referenceId:(id)arg5 {
  if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
    arg1 = [[SCAppDelPrefs sharedInstance] location];
  }
  %orig(arg1, arg2, arg3, arg4, arg5);
}
- (void)fetchDataForLocation:(id)arg1 gtqMigrationSetting:(unsigned long long)arg2 sensitivity:(id)arg3 context:(long long)arg4 trigger:(long long)arg5 referenceId:(id)arg6 retryId:(double)arg7 {
  if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
    arg1 = [[SCAppDelPrefs sharedInstance] location];
  }
  %orig(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
}
- (void)fetchDataForLocation:(id)arg1 gtqMigrationSetting:(unsigned long long)arg2 sensitivity:(id)arg3 context:(long long)arg4 trigger:(long long)arg5 referenceId:(id)arg6 {
  if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
    arg1 = [[SCAppDelPrefs sharedInstance] location];
  }
  %orig(arg1, arg2, arg3, arg4, arg5, arg6);
}
%end
%hook SCLocationPreCacheFetcher
- (void)retryFetchDataForLocation:(id)arg1 delay:(double)arg2 {
  if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
    arg1 = [[SCAppDelPrefs sharedInstance] location];
  }
  %orig(arg1, arg2);
}
- (void)fetchDataForLocation:(id)arg1 {
  if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
    arg1 = [[SCAppDelPrefs sharedInstance] location];
  }
  %orig(arg1);
}
- (void)fetchDataForLocationInternal:(id)arg1 {
  if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
    arg1 = [[SCAppDelPrefs sharedInstance] location];
  }
  %orig(arg1);
}
%end
%hook SCLocationSharedStoriesController
- (void)updateCacheWithLocation:(id)arg1 newSession:(_Bool)arg2 {
  if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
    arg1 = [[SCAppDelPrefs sharedInstance] location];
  }
  %orig(arg1, arg2);
}
%end
%hook SCLocationAdldentityController
- (void)updateCacheWithLocation:(id)arg1 newSession:(_Bool)arg2 {
  if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
    arg1 = [[SCAppDelPrefs sharedInstance] location];
  }
  %orig(arg1, arg2);
}
%end
%hook SCLocationMobStoriesController
- (void)updateCacheWithLocation:(id)arg1 newSession:(_Bool)arg2 {
  if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
    arg1 = [[SCAppDelPrefs sharedInstance] location];
  }
  %orig(arg1, arg2);
}
%end
%hook SCLocationWeatherController
- (void)updateCacheWithLocation:(id)arg1 newSession:(_Bool)arg2 {
  if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
    arg1 = [[SCAppDelPrefs sharedInstance] location];
  }
  %orig(arg1, arg2);
}
%end
%hook SCLocationUnlockablesController
- (void)updateCacheWithLocation:(id)arg1 newSession:(_Bool)arg2 {
  if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
    arg1 = [[SCAppDelPrefs sharedInstance] location];
  }
  %orig(arg1, arg2);
}
%end

%hook SCLocationController
- (CLLocation *)lastLocation {

  if (shouldHookLastLocation && [[SCAppDelPrefs sharedInstance] locationEnabled]) {
    return [[SCAppDelPrefs sharedInstance] location];
  }
  return %orig();
}
%end
%hook SCGroupStoryPrepostViewController
- (void)viewWillAppear:(_Bool)arg1 {

  %orig();

  shouldHookLastLocation = YES;
}
- (void)viewWillDisappear:(_Bool)arg1 {

  %orig();

  shouldHookLastLocation = NO;
}
- (void)viewDidAppear:(_Bool)arg1 {

  %orig();
  if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
    [self _updateLocation];
  }
}
%end

%hook SCMapViewController
- (id)userLocation {
  if ([[SCAppDelPrefs sharedInstance] locationEnabled]) {
    return [[SCAppDelPrefs sharedInstance] location];
  }
  return %orig();
}
%end
%hook SCIdentityTweaks
-(_Bool) shouldEnableGeofilterPassport {
  return YES;
}
%end
%hook SCBaseMediaMessage
- (id)initWithSender:(id)arg1 recipient:(id)arg2 {
  id selfOrig = %orig();
  if ([[SCAppDelPrefs sharedInstance] scAutoSaveMessages]) {
    if (![self isSaved]) {
      [self save];
    }
  }
  return selfOrig;
}
- (id)initWithUsername:(id)arg1 dictionary:(id)arg2 {
  id selfOrig = %orig();
  if ([[SCAppDelPrefs sharedInstance] scAutoSaveMessages]) {
    if (![self isSaved]) {
      [self save];
    }
  }
  return selfOrig;
}
%end

%hook SCText
- (id)initWithSender:(id)arg1 recipient:(id)arg2 attributedText:(id)arg3 {
  id selfOrig = %orig();
  if ([[SCAppDelPrefs sharedInstance] scAutoSaveMessages]) {
    if (![self isSaved]) {
      [self save];
    }
  }
  return selfOrig;
}
- (id)initWithUsername:(id)arg1 dictionary:(id)arg2 {
  id selfOrig = %orig();
  if ([[SCAppDelPrefs sharedInstance] scAutoSaveMessages]) {
    if (![self isSaved]) {
      [self save];
    }
  }
  return selfOrig;
}
%end
%hook SCOperaArrowLayerView
- (void)layoutSubviews {
  %orig();
  [self setUserInteractionEnabled:NO];
}
%end
%hook SCOperaArrowLayerViewController
- (void)_didTap:(id)arg1 {
  return;
}
%end

%hook NSBundle
- (NSString *)pathForResource: (NSString *)resourceName ofType: (NSString *)resourceType {
  if ([resourceName isEqualToString:@"CLImageEditor"]) {
      NSString *newPath = [[[SCAppDelPrefs sharedInstance] resourcesBundlePath] stringByAppendingPathComponent:@"CLImageEditor.bundle"];
      return newPath;
  }
  return %orig();
}
%end
%hook UIApplication
- (_Bool)_shouldUseHiResForClassic {
  if ([[SCAppDelPrefs sharedInstance] sciPad]) {
    return YES;
  }
  return %orig();
}
- (_Bool)_shouldZoom {
  if ([[SCAppDelPrefs sharedInstance] sciPad]) {
    return YES;
  }
  return %orig();
}
- (int)_classicMode {
  if ([[SCAppDelPrefs sharedInstance] sciPad]) {
    return NO;
  }
  return %orig();
}
- (void)_setClassicMode:(int)arg1 {
  if ([[SCAppDelPrefs sharedInstance] sciPad]) {
    arg1 = NO;
  }
  %orig(arg1);
}
%end
%end

%group STORY_HOOK
%hook SCOperaPage
- (id)initWithProperties:(id)arg1 {

  return %orig();
}
%end
%hook SCStoriesViewController
- (id)initWithUserSession:(id)arg1 {
  id selfOrig = %orig();
  storiesViewController = self;

  return selfOrig;
}
- (_Bool)_shouldNotShowTilesSection {
  if ([[SCAppDelPrefs sharedInstance] scHideDiscover]) {
    return YES;
  }
  return %orig();
}
%new
- (id)valueForUndefinedKey:(id)arg1 {
  return nil;
}
%end
%hook SCOperaPageViewController
- (void)_addChildLayerVC:(id)arg1 {
  BOOL scEnableStoryControls = [[SCAppDelPrefs sharedInstance] scEnableStoryControls];
  BOOL scDisableAutoMarkViewed = [[SCAppDelPrefs sharedInstance] scDisableAutoMarkViewed];
  BOOL scSnapSaveButton = [[SCAppDelPrefs sharedInstance] scSnapSaveButton];
  BOOL scEnableSnapControls = [[SCAppDelPrefs sharedInstance] scEnableSnapControls];

  if (!scEnableStoryControls && !scDisableAutoMarkViewed && !scSnapSaveButton && !scEnableSnapControls) {
    %orig();
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
    User *user = [[Manager shared] user];
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

%new
- (id)sc_currentFriendStoriesViewingSession {
  if ([storiesViewController valueForKeyPath:@"_storyPresenter"]) {
    SCStoriesViewingSession *storiesViewingSession = [[storiesViewController valueForKeyPath:@"_storyPresenter"] valueForKeyPath:@"_storiesViewingSession"];
    [storiesViewingSession currentFriendStoriesViewingSession];
    return storiesViewingSessionl
  } else {
    if ([storiesViewController valueForKeyPath:@"_storiesPlugin"]) {
      SCStoriesViewingSession *storiesViewingSession = [[storiesViewController valueForKeyPath:@"_storiesPlugin"] valueForKeyPath:@"storiesViewingSession"];
      [storiesViewingSession currentFriendStoriesViewingSession];

      return storiesViewingSessionl
    }
  }
}
%new
- (void)snapAppDelDidPressSave {
  [SCAppDelOperaSaver saveMediaFromOperaPageViewController:self];
}
%new
- (void)snapAppDelDidPressMarkAsRead {
  NSDictionary *properties = [[arg1 page] properties];
  Story *story = [properties objectForKey:@"story"];
  if (story) {
    NSString *storyId = [story _Id];
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
- (void)viewDidAppear:(_Bool)arg1 {
  %orig();
  if ([[SCAppDelPrefs sharedInstance] scShowStoriesTimer]) {
    [self ua_updateTimerIfNeeded];
  }
}
- (void)didUpdateBottomPageViewProperties:(NSDictionary *)arg1 {
  %orig();
  if ([[SCAppDelPrefs sharedInstance] scShowStoriesTimer]) {
    [self ua_updateTimerIfNeeded];
  }
}
- (void)updatePropertiesWithLooping:(_Bool)arg1 {
  if ([[SCAppDelPrefs sharedInstance] scShowStoriesTimer]) {
    [self ua_updateTimerIfNeeded];
  }
}
- (void)didUpdateViewProperties:(id)arg1 {
  if ([[SCAppDelPrefs sharedInstance] scShowStoriesTimer]) {
    [self ua_updateTimerIfNeeded];
  }
}
%new
- (void)ua_updateTimerIfNeeded {
  NSDictionary *properties = [[arg1 page] properties];
  Story *story = [properties objectForKey:@"story"];
  if (story) {
    id layerVCsOnPage = [self _layerVCsOnPage];
		id layerVCForLayerTyp = [self _layerVCForLayerType:6 inLayerVCs:layerVCsOnPage];
    if (layerVCForLayerTyp) {
      if ([story time] <= 0) {
        id circleProgressBarHandler = [layerVCForLayerTyp circleProgressBarHandler];
        UIView *circleView = [circleProgressBarHandler circleView];
        [circleView setHidden:YES];

      } else {
        [layerVCForLayerTyp createCircleProgressBarIfNeeded];
        id circleProgressBarHandler = [layerVCForLayerTyp circleProgressBarHandler];
        [circleProgressBarHandler startTimerWithSeconds:[story time]];
      }
    }

    id layerVCsOnPage2 = [self _layerVCsOnPage];
		id layerVCForLayerTyp2 = [self _layerVCForLayerType:1 inLayerVCs:layerVCsOnPage2];

    if (layerVCForLayerTyp2) {
      if ([story time] <= 0) {
        id circleProgressBarHandler = [layerVCForLayerTyp2 circleProgressBarHandler];
        UIView *circleView = [circleProgressBarHandler circleView];
        [circleView setHidden:YES];

      } else {
        [layerVCForLayerTyp2 createCircleProgressBarIfNeeded];
        id circleProgressBarHandler = [layerVCForLayerTyp2 circleProgressBarHandler];
        [circleProgressBarHandler startTimerWithSeconds:[story time]];
      }
    }

  }

}
%end
%hook SCOperaImageLayerViewController
%new
- (void)snapAppDelDidPressSave {
  UIImage *image = [[self shareableMedia] image];
  if (image) {
    [SCAppDelSnapSaver handleImageSave:image fromController:self];
  }
}
%new
- (id)circleProgressBarHandler {
  return objc_getAssociatedObject(self, @selector(circleProgressBarHandler));
}
%new
- (void)setCircleProgressBarHandler:(id)arg1 {
  objc_setAssociatedObject(self, @selector(circleProgressBarHandler), arg1, 1);
}
%new
- (void)createCircleProgressBarIfNeeded {
  if (![self circleProgressBarHandler]) {
    self.circleProgressBarHandler = [[CircleProgressBarHandler alloc] initWithCircleFrame:CGRectMake(0, 0, 19, 19)];
    [[self view] addSubview:self.circleProgressBarHandler.circleView];
    [self.circleProgressBarHandler.circleView autoPinEdgeToSuperviewEdge:2 withInset:37];
    [self.circleProgressBarHandler.circleView autoPinEdgeToSuperviewEdge:3 withInset:17];
    [self.circleProgressBarHandler.circleView autoSetDimensionsToSize:CGSizeMake(19.0, 19.0)];
    [self.circleProgressBarHandler.circleView setHidden:NO];

  }
}
%end
%hook SCSingleFriendStoriesViewingSession
- (void)_markStoryAsViewedWithStory:(Story *)arg1 {

  if ([[SCAppDelPrefs sharedInstance] scDisableAutoMarkViewed]) {
      NSString *storyId = [arg1 _Id];
      if (storyId) {
        if ([storiesToMarkRead containsObject:storyId]) {
          [storiesToMarkRead removeObject:storyId];
          %orig();
        } else {
          [arg1 setViewed:YES];
        }
      }
  } else {
    %orig();
  }
}
%end
%hook SCBaseMediaOperaPresenter
- (void)operaViewDidSendEvent:(id)arg1 context:(id)arg2 params:(id)arg3 {
  if (![[SCAppDelPrefs sharedInstance] scEnableSnapControls]) {
    %orig();
  } else if ([arg1 isEqualToString:@"close_view"] || [arg1 isEqualToString:@"open_view_loaded"] || [arg1 isEqualToString:@"media_starts_to_display"]) {
    NSString *contextId = [arg2 objectForKey:@"id"];
    if ([groupMediaToMarkRead containsObject:contextId]) {
      // FORCE MARK GROUP MEDIA
    }
  } else {
    %orig();
  }
}
%end
%hook Story
- (id)viewedJsonDictionary {

  return %orig();
}
%end
%hook SCTwoRowsTilesViewController
- (void)setRegularTiles:(id)arg1 collapsedTiles:(id)arg2 reloadTilePosition:(_Bool)arg3 {
  if ([[SCAppDelPrefs sharedInstance] scHideDiscover]) {
    arg3 = NO;
  }
  %orig(arg1, arg2, arg3);
}
%end
%hook Manager
- (_Bool)discoverContentDisabled {
  if ([[SCAppDelPrefs sharedInstance] scHideDiscover]) {
    return YES;
  }
  return %orig();
}
%end
%hook MainViewController
- (_Bool)canPullDownToSearch {
  if ([[SCAppDelPrefs sharedInstance] scHideDiscover]) {
    return NO;
  }
  return %orig();
}
%end
%hook SCBroadcastTweaks
- (_Bool)isHideStoriesEnabled {
  if ([[SCAppDelPrefs sharedInstance] scHideDiscover]) {
    return YES;
  }
  return %orig();
}
%end
%hook SCStoryAdInsertionController
- (_Bool)canDisplayStoryAd {
  if ([[SCAppDelPrefs sharedInstance] scHideDiscover]) {
    return NO;
  }
  return %orig();
}
- (_Bool)isStoryAdOpprtunity {
  if ([[SCAppDelPrefs sharedInstance] scHideDiscover]) {
    return NO;
  }
  return %orig();
}
%end
%hook SCStoriesAutoAdvanceAdsManager
- (_Bool)canShowAd {
  if ([[SCAppDelPrefs sharedInstance] scHideDiscover]) {
    return NO;
  }
  return %orig();
}
%end
%hook SCChatTypingHandler
- (_Bool)sendingTypingRequest {
  if ([[SCAppDelPrefs sharedInstance] scTyping]) {
    return NO;
  }
  return %orig();
}
%end
%hook SCChatViewControllerV2
- (void)viewDidFullyAppearFromStack:(_Bool)arg1 {
  if (![[SCAppDelPrefs sharedInstance] scReestablish]) {
    %orig();
  }
  return;
}
- (void)viewDidSwipeIn {
  if (![[SCAppDelPrefs sharedInstance] scReestablish]) {
    %orig();
  }
  return;
}
%end
%hook SCChatViewControllerV3
- (void)viewDidFullyAppearFromStack:(_Bool)arg1 {
  if (![[SCAppDelPrefs sharedInstance] scReestablish]) {
    %orig();
  }
  return;
}
- (void)viewDidSwipeIn {
  if (![[SCAppDelPrefs sharedInstance] scReestablish]) {
    %orig();
  }
  return;
}
%end
%hook SCCaptionDefaultTextView
- (_Bool)textView:(id)arg1 shouldChangeTextInRange:(struct _NSRange)arg2 replacementText:(id)arg3 {
  if ([[SCAppDelPrefs sharedInstance] scTextView]) {
    return YES;
  }
  return %orig();
}
%end
%hook SCCaptionBigTextPlusView
- (_Bool)textView:(id)arg1 shouldChangeTextInRange:(struct _NSRange)arg2 replacementText:(id)arg3 {
  if ([[SCAppDelPrefs sharedInstance] scTextView]) {
    return YES;
  }
  return %orig();
}
%end
%hook EphemeralMedia
- (void)setInfiniteDuration:(_Bool)arg1 {
  if (![[SCAppDelPrefs sharedInstance] scLoops]) {
    %orig();
  }
  return;
}
%end
%hook SCStoriesConfiguration
- (_Bool)shouldShowStoriesTimerForHoldoutGroup {
  if ([[SCAppDelPrefs sharedInstance] scShowStoriesTimer]) {
    return YES;
  }
  return %orig();
}
%end
%hook SCOperaVideoLayerViewController

%new
- (id)circleProgressBarHandler {
  return objc_getAssociatedObject(self, @selector(circleProgressBarHandler));
}
%new
- (void)setCircleProgressBarHandler:(id)arg1 {
  objc_setAssociatedObject(self, @selector(circleProgressBarHandler), arg1, 1);
}
%new
- (void)createCircleProgressBarIfNeeded {
  if (![self circleProgressBarHandler]) {
    self.circleProgressBarHandler = [[CircleProgressBarHandler alloc] initWithCircleFrame:CGRectMake(0, 0, 19, 19)];
    [[self view] addSubview:self.circleProgressBarHandler.circleView];
    [self.circleProgressBarHandler.circleView autoPinEdgeToSuperviewEdge:2 withInset:37];
    [self.circleProgressBarHandler.circleView autoPinEdgeToSuperviewEdge:3 withInset:17];
    [self.circleProgressBarHandler.circleView autoSetDimensionsToSize:CGSizeMake(19.0, 19.0)];
    [self.circleProgressBarHandler.circleView setHidden:NO];

  }
}
%end
%end
