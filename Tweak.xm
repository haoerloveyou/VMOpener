#import "substrate.h"
#import <spawn.h>

//#import "LSStatusBarItem.h"


#define path @"/tmp/isFirstLaunch.txt"
#define filePath @"/var/mobile/Libraray/Preferences/com.jc.cmemory.plist"

//static int alertValue = 1;
static BOOL autoRefresh = NO;
static int refreshValue = 1800;
NSFileManager *manager = [NSFileManager defaultManager];


static void loadPrefs() {
NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
if (prefs) {
refreshValue = ([prefs objectForKey:@"refreshValue"] ? [[prefs objectForKey:@"refreshValue"] integerValue] : refreshValue);
autoRefresh = ([prefs objectForKey:@"autoRefresh"]?[[prefs objectForKey:@"autoRefresh"] boolValue] : autoRefresh);
}
}
%hook SpringBoard

-(void) applicationDidFinishLaunching:(id)arg1 {
	%orig;
	if (![manager fileExistsAtPath:path]) {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notice" 
		                                                  message:@"Are you sure want to enabled cmemory?"
		                                                  delegate:self
		                                                  cancelButtonTitle:@"I don't need it yet."
		                                                  otherButtonTitles:@"I want to update 15MB.",@"I want to update 64MB.",@"I want to enable 128MB.",nil];
	[alert show];
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
		[NSTimer scheduledTimerWithTimeInterval:60.0f
			   target:self
			   selector:@selector(refreshCM)
			   userInfo:nil
			   repeats:YES];
            NSString *data = @"YES\n15MB";
            [data writeToFile:path atomically:YES];
 
	} 
	else if (buttonIndex == 1){
		system("rm -rf /var/vm/*");
		pid_t pid;
                          int status;
                          const char* args[] = {"dynamic_pager","-F","/private/var/vm/VM","-S","15728640","-H","15360","-L","15750000","-P","17",NULL};
                          posix_spawn(&pid,"/sbin/dynamic_pager",NULL,NULL,(char*const*)args,NULL);
                          waitpid(pid,&status,WEXITED);
                          NSString *data = @"YES\n15MB";
                         [data writeToFile:path atomically:YES];
	}
	else if (buttonIndex == 2 && autoRefresh) {
		system("rm -rf /var/vm/*");
		pid_t pid;
                          int status;
                         const char* args[] = {"dynamic_pager","-F","/private/var/vm/VM","-S","67108864","-H","47104","-L","67156000","-P","17",NULL};
                         posix_spawn(&pid,"/sbin/dynamic_pager",NULL,NULL,(char*const*)args,NULL);
                         waitpid(pid,&status,WEXITED);
		[NSTimer scheduledTimerWithTimeInterval:60.0f
			   target:self
			   selector:@selector(refreshCM)
			   userInfo:nil
			   repeats:YES];
                        NSString *data = @"YES\n64MB";
                       [data writeToFile:path atomically:YES];
	}
	else if (buttonIndex == 2) {
		system("rm -rf /var/vm/*");
		pid_t pid;
                          int status;
                          const char* args[] = {"dynamic_pager","-F","/private/var/vm/VM","-S","67108864","-H","47104","-L","67156000","-P","17",NULL};
                          posix_spawn(&pid,"/sbin/dynamic_pager",NULL,NULL,(char*const*)args,NULL);
                          waitpid(pid,&status,WEXITED);
                          NSString *data = @"YES\n64MB";
                          [data writeToFile:path atomically:YES];
	}
	else if (buttonIndex == 3 && autoRefresh) {
		system("rm -rf /var/vm/*");
		pid_t pid;
                          int status;
                          const char* args[] = {"dynamic_pager","-F","/private/var/vm/VM","-S","134217728","-H","131072","-L","134348800","-P","17",NULL};
                          posix_spawn(&pid,"/sbin/dynamic_pager",NULL,NULL,(char*const*)args,NULL);
                          waitpid(pid,&status,WEXITED);
		[NSTimer scheduledTimerWithTimeInterval:600.0f
			   target:self
			   selector:@selector(refreshCM)
			   userInfo:nil
			   repeats:YES];
                          NSString *data = @"YES\n128MB";
                         [data writeToFile:path atomically:YES];
	}
	else if (buttonIndex == 3) {
		system("rm -rf /var/vm/*");
		pid_t pid;
                          int status;
                          const char* args[] = {"dynamic_pager","-F","/private/var/vm/VM","-S","134217728","-H","131072","-L","134348800","-P","17",NULL};
                          posix_spawn(&pid,"/sbin/dynamic_pager",NULL,NULL,(char*const*)args,NULL);
                          waitpid(pid,&status,WEXITED);
                          NSString *data = @"YES\n128MB";
                         [data writeToFile:path atomically:YES];
	}
            else 
             { 
	            NSString*data = @"YES";
	            [data writeToFile:path atomically:YES];
             }
}

%new -(void)refreshCM {
if ([manager fileExistsAtPath:path])
      {
	NSString *sizeStrings = [[NSString alloc] initWithContentsOfFile:path];
	if ([sizeStrings isEqualToString:@"YES\n15MB"] && autoRefresh)
	{
	             system("rm -rf /var/vm/*");
		pid_t pid;
                          int status;
                          const char* args[] = {"dynamic_pager","-F","/private/var/vm/VM","-S","15728640","-H","15360","-L","15750000","-P","17",NULL};
                          posix_spawn(&pid,"/sbin/dynamic_pager",NULL,NULL,(char*const*)args,NULL);
                          waitpid(pid,&status,WEXITED);
	}
	else if ([sizeStrings isEqualToString:@"YES\n64MB"] && autoRefresh)
	{
		system("rm -rf /var/vm/*");
		pid_t pid;
                          int status;
                          const char* args[] = {"dynamic_pager","-F","/private/var/vm/VM","-S","67108864","-H","47104","-L","67156000","-P","17",NULL};
                          posix_spawn(&pid,"/sbin/dynamic_pager",NULL,NULL,(char*const*)args,NULL);
                          waitpid(pid,&status,WEXITED);
	}
	else if ([sizeStrings isEqualToString:@"YES\n128MB"] && autoRefresh)
	{
		system("rm -rf /var/vm/*");
		pid_t pid;
                          int status;
                          const char* args[] = {"dynamic_pager","-F","/private/var/vm/VM","-S","67108864","-H","47104","-L","67156000","-P","17",NULL};
                          posix_spawn(&pid,"/sbin/dynamic_pager",NULL,NULL,(char*const*)args,NULL);
                          waitpid(pid,&status,WEXITED);
	}
	else{}
		[sizeStrings release];
      }	
  else 
  {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
		                                                     message:@"Can't found plugin file, please reboot and retry this work."
		                                                       delegate:self
		                                         cancelButtonTitle:@"I see."
		                                          otherButtonTitles:nil];
	[alert show];
	[alert release];
}
}
%end

/*%ctor {


//loadPrefs();
} */