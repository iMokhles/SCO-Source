static NSString *provisionPath = [[NSBundle mainBundle] pathForResource:@"embedded.mobileprovision" ofType:@""];
static NSString *dylib = [[NSBundle mainBundle] pathForResource:@"dylib.dylib" ofType:@""];

%hook SCAppDeIegate
- (void)applicationDidBecomeActive:(id)arg1 {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  if (![defaults boolForKey:@"notFirstRun"]) {
        
      SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
      [alert showSuccess:@"تحذير - Warning" subTitle:@"من الممكن يتعرض حسابك للحظر من قبل شركة سناب شات بسبب استخدامك التطبيق المعدل ولذلك لست مسؤول عند استخدام سناب تجم \n Your account may be blocked by Snapchat because of your use of third-party applications and therefore I am not responsible for using SCOthman \n By - Othman Al-Omiry \n عثمان العميري \n @OthmanAl3miry" closeButtonTitle:@"أتفهم I understand" duration:0.0f];
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
