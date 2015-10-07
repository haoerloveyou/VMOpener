#import "substrate.h"
#import <spawn.h>

//#import "LSStatusBarItem.h"
//#import "cmDelegate.h"
static int autoRefreshTime = 0;
static int alertValue = 1;
BOOL autoRefresh = YES;


/*%hook SpringBoard
%new -(void) _vmstart {

UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"你确定要开启虚拟内存(64MB)么？" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是",nil];
[alert show];
[alert release];
}

%new -(void) alertView:(UIAlertView*)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
if (buttonIndex == 1) {
system("dynamic_pager -P 20");
}
}
%end*/
%hook SpringBoard

-(void) applicationDidFinishLaunching:(id)arg1 {
	%orig;
	if (alertValue == 1) {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notice" 
		                                                  message:@"Are you sure want to enabled cmemory?"
		                                                  delegate:self
		                                                  cancelButtonTitle:@"No"
		                                                  otherButtonTitles:@"Yes",nil];
	[alert show];
	[alert release];
	}

}

%new -(void) alertView:(UIAlertView*)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 1 && autoRefresh)
	{
		system("rm -rf /var/vm/*");
		pid_t pid;
  int status;
  const char* args[] = {"dynamic_pager","-F","/private/var/vm/VM","-S","15728640","-H","15360","-L","15750000","-P","17",NULL};
  posix_spawn(&pid,"/sbin/dynamic_pager",NULL,NULL,(char*const*)args,NULL);
  waitpid(pid,&status,WEXITED);
		[NSTimer scheduledTimerWithTimeInterval:600.0f
			   target:self
			   selector:@selector(applicationDidFinishLaunching:)
			   userInfo:nil
			   repeats:YES];
		alertValue = 0;
	} else if (buttonIndex == 1){
		system("rm -rf /var/vm/*");
		pid_t pid;
  int status;
  const char* args[] = {"dynamic_pager","-F","/private/var/vm/VM","-S","15728640","-H","15360","-L","15750000","-P","17",NULL};
  posix_spawn(&pid,"/sbin/dynamic_pager",NULL,NULL,(char*const*)args,NULL);
  waitpid(pid,&status,WEXITED);
		alertValue = 0;
	}
}

%new -(void)refreshCM {
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notice" 
		                                                  message:@"Are you sure want to refresh cmemory?"
		                                                  delegate:self
		                                                  cancelButtonTitle:@"No"
		                                                  otherButtonTitles:@"Yes",nil];
	[alert show];
	[alert release];}
	%end

/*%ctor {

LSStatusBarItem *cmemory = [[NSClassFromString(@"LSStatusBarItem") alloc] initWithIdentifier:@"jc.cmemory" alignment:StatusBarAlignmentRight];
cmemory.imageName = @"cmemory";
[cmemory setVisible:YES];
//cmDelegate *delegate = [[cmDelegate alloc] init];
//[mute addTouchDelegate:delegate];
//[mute release];
}*/