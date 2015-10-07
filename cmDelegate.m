#import "cmDelegate.h"

@implementation cmDelegate

-(void) _vmstart {
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"warning" message:@"你确定开启么" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
[alert show];
[alert release];
}
@end