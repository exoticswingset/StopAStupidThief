@interface SBCoverSheetPresentationManager
-(bool)hasBeenDismissedSinceKeybagLock; // Using this to check when the device is on the lock screen.
+(id)sharedInstance;
@end

// iOS 12 to prevent normal power menu from showing

%hook SBPowerDownController
-(void)orderFront {
  SBCoverSheetPresentationManager *lockManager = (SBCoverSheetPresentationManager *)[%c(SBCoverSheetPresentationManager) sharedInstance];
  if(![lockManager hasBeenDismissedSinceKeybagLock]) {
  } else {
    %orig;
  }
}
%end

// iOS 13 to prevent normal power menu from showing but causes a freeze for 10-15 seconds or less (not intentional, it's a issue with this method).

%hook SBPowerDownViewController
-(BOOL)_canShowWhileLocked {
  return NO;
}
%end

// Prevents the emergency SOS power down menu from showing on notched devices when holding volume + power

%hook SBSOSClawGestureObserver

-(void)_presentSOSInterface {
  SBCoverSheetPresentationManager *lockManager = (SBCoverSheetPresentationManager *)[%c(SBCoverSheetPresentationManager) sharedInstance];
  if(![lockManager hasBeenDismissedSinceKeybagLock]) {

  } else {
    %orig;
  }
}

%end

// Prevents the emergency SOS power down menu from showing on non-notched devices when pressing power 5 times

%hook SOSManager
+(BOOL)deviceSupportsSOS {
  SBCoverSheetPresentationManager *lockManager = (SBCoverSheetPresentationManager *)[%c(SBCoverSheetPresentationManager) sharedInstance];
  if(![lockManager hasBeenDismissedSinceKeybagLock]) {
    return NO;
  } else {
    return YES;
  }
}

%end
