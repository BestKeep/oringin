//
//  HarpyConstants.h
//  
//
//  Created by Arthur Ariel Sabintsev on 1/30/13.
//
//

#warning Please customize Harpy's static variables

/*
 Option 1 (DEFAULT): NO gives user option to update during next session launch
 Option 2: YES forces user to update app on launch
 */
static BOOL harpyForceUpdate = YES;

// 2. Your AppID (found in iTunes Connect)
#define kHarpyAppID                 @"1035553463"

// 3. Customize the alert title and action buttons
#define kHarpyAlertViewTitle        @"更新提示"
#define kHarpyCancelButtonTitle     @"取消"
#define kHarpyUpdateButtonTitle     @"更新"
