#import "substrate.h"
#import <spawn.h>

#import "LSStatusBarItem.h"


#define path @"/tmp/isFirstLaunch.txt"

//static int alertValue = 1;
BOOL autoRefresh = YES;



/*static void loadPrefs() {
NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
if (prefs) {
alertValue = ([prefs objectForKey:@"alertValue"] ? [[prefs objectForKey:@"alertValue"] integerValue] : alertValue);
}
else {
NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
	alertValue = ([prefs objectForKey:@"alertValue"] ? [[prefs objectForKey:@"alertValue"] integerValue] : alertValue);
}
}

*/
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
	NSFileManager *manager = [NSFileManager defaultManager];
	if (![manager fileExistsAtPath:path]) {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notice" 
		                                                  message:@"Are you sure want to enabled cmemory?"
		                                                  delegate:self
		                                                  cancelButtonTitle:@"No"
		                                                  otherButtonTitles:@"Yes",nil];
	[alert show];
	[NSTimer scheduledTimerWithTimeInterval:5.0f 
	 target:self
    selector:@selector(CheckTime)
	 userInfo:nil
	 repeats:YES];
	[alert release];
	}
	else {}

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
			   selector:@selector(refreshCM)
			   userInfo:nil
			   repeats:YES];
      NSString *data = @"YES";
      [data writeToFile:path atomically:YES];
 
	} 
	else if (buttonIndex == 1){
		system("rm -rf /var/vm/*");
		pid_t pid;
  int status;
  const char* args[] = {"dynamic_pager","-F","/private/var/vm/VM","-S","15728640","-H","15360","-L","15750000","-P","17",NULL};
  posix_spawn(&pid,"/sbin/dynamic_pager",NULL,NULL,(char*const*)args,NULL);
  waitpid(pid,&status,WEXITED);
  NSString *data = @"YES";
      [data writeToFile:path atomically:YES];
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
	
	-(void) checkTime {
	NSString 
	%end

/*%ctor {


//loadPrefs();
} */