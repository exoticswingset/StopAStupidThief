@interface SBCoverSheetPresentationManager
-(bool)hasBeenDismissedSinceKeybagLock;
+(id)sharedInstance;
@end

%hook SBPowerDownController
-(void)orderFront {
  SBCoverSheetPresentationManager *lockManager = (SBCoverSheetPresentationManager *)[%c(SBCoverSheetPresentationManager) sharedInstance];
  if(![lockManager hasBeenDismissedSinceKeybagLock]) {
  } else {
    %orig;
  }
}
%end