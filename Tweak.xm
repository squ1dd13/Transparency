@interface NCMaterialView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end

//This is the main part, but it messes a load of stuff up. The rest of the code fill fix that.

%hook NCMaterialView
-(void)layoutSubviews {
    %orig;
    self.hidden = YES;
}
%end

@interface SBFolderIconBackgroundView
@property (nonatomic, assign, readwrite) CGFloat alpha;
@end

%hook SBFolderIconBackgroundView

-(void)layoutSubviews {
    %orig;
    self.alpha = 0.5;
}

%end

@interface SBFolderBackgroundView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end

%hook SBFolderBackgroundView

-(void)layoutSubviews {
    %orig;
    UIImageView *_tintView = MSHookIvar<UIImageView *>(self, "_tintView");
    //Hide the folder background when open
    _tintView.hidden = YES;
}

%end

//Now for the fixing

@interface CCUIControlCenterPagePlatterView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@property (nonatomic, assign, readwrite, setter=_setCornerRadius:) CGFloat _cornerRadius;
@property (nonatomic, copy, readwrite) UIColor *backgroundColor;
@end

//Now we need to recreate the original control centre look

%hook CCUIControlCenterPagePlatterView

-(void)layoutSubviews {
    %orig;
    UIImageView *_whiteLayerView = MSHookIvar<UIImageView *>(self, "_whiteLayerView");
    //Hide the white stuff
    _whiteLayerView.hidden = YES;
    //Add our own background color similar to the default effect
    self.backgroundColor = [UIColor colorWithRed:255.0f/255.0f
                                           green:255.0f/255.0f
                                            blue:255.0f/255.0f
                                           alpha:0.5f];
    //We now have square corners, so fix that
    self._cornerRadius = 10;
    //CC done
}

%end

@interface SBNotificationSeparatorView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end

//Hide the ugly separator on widgets that ruins our sleek look

%hook SBNotificationSeparatorView

-(void)layoutSubviews {
    %orig;
    self.hidden = YES;
}
%end

%hook _UIVisualEffectFilterView
//Get a nice blur radius on navigation bars and alerts
-(void)applySettings:(id)arg1 type:(long long)arg2 {
    arg2 = -1;
    %orig;
}
%end

@interface _SBLockScreenSingleBatteryChargingView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end

%hook _SBLockScreenSingleBatteryChargingView

-(void)layoutSubviews {
    %orig;
    UIView *_batteryBlurView = MSHookIvar<UIView *>(self, "_batteryBlurView");
    //Hide the black background on lock screen charging view (1 device only)
    _batteryBlurView.hidden = YES;
}

%end

@interface _SBLockScreenDoubleBatteryChargingView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end

%hook _SBLockScreenDoubleBatteryChargingView

-(void)layoutSubviews {
    %orig;
    UIView *_externalBatteryBlurView = MSHookIvar<UIView *>(self, "_externalBatteryBlurView");
    UIView *_internalBatteryBlurView = MSHookIvar<UIView *>(self, "_internalBatteryBlurView");
    //Hide the black background on lock screen charging view (2 devices only)
    _externalBatteryBlurView.hidden = YES;
    _internalBatteryBlurView.hidden = YES;
}

%end


