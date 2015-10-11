#import <Preferences/Preferences.h>
#import <SettingsKit/SKListControllerProtocol.h>
#import <SettingsKit/SKTintedListController.h>

@interface cmemoryListController: SKTintedListController<SKListControllerProtocol>
@end

@implementation cmemoryListController


 -(UIColor*) tintColor { return [UIColor darkGrayColor]; }
 -(BOOL) tintNavigationTitleText { return NO; }



-(NSString*) headerText { return @"Cmemory"; }
-(NSString*) headerSubText { return @""; }


-(NSString*) customTitle { return @"cmemory"; }
-(NSArray*) customSpecifiers
{
    return @[
             @{
                 @"cell": @"PSGroupCell",
                 @"label": @"Cmemory Settings"
                 },
             @{
                 @"cell": @"PSSwitchCell",
                 @"default": @YES,
                 @"defaults": @"com.jc.cmemory",
                 @"key": @"enabled",
                 @"label": @"Enabled",
                 @"PostNotification": @"cmemory/reloadSettings",
                 },
             @{
                 @"cell": @"PSGroupCell",
                 @"label": @"",
                 @"footerText": @"When you opened intelligent Mode , you must be clever , because It's an imagine function that can auto clear tempMemory and refresh it to let your device keep a fast speed."
                 },                
             @{
                 @"cell": @"PSSwitchCell",
                 @"default": @NO,
                 @"defaults": @"com.jc.cmemory",
                 @"key":@"autoRefresh",
                 @"label": @"Enabled Intelligent Mode",
                 @"PostNotification": @"cmemory/reloadSettings"
                 },
             @{
                 @"cell": @"PSGroupCell",
                 @"label": @"Referesh Time"
                 },

             @{
                 @"cell":@"PSSliderCell",
                 @"min":@1800,
                 @"max":@3600,
                 @"key":@"refreshValue",
                 @"defaults":@"com.jc.cmemory",
                 @"PostNotification": @"cmemory/reloadSettings",
                 @"showValue": @YES
                },
             ];
}
@end
