//
//  AppDelegate.m
//  SQLTEST
//
//  Created by Mahmood1 on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "Stories.h"
#import "ViewController.h"
#import "Robot.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize stories;
@synthesize robotWords;
//- (void)dealloc
//{
////    [_window release];
////    [super dealloc];
//}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    databaseName = @"bw_stories.db";
    
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    
	// Execute the "checkAndCreateDatabase" function
	[self checkAndCreateDatabase];
    
	// Query the database for all animal records and construct the "animals" array
	[self readStoriesFromDatabase];
    
	// Configure and show the window
	//[window addSubview:[navigationController view]];
	[window makeKeyAndVisible];
    // Override point for customization after application launch.
    return YES;
}
-(void) checkAndCreateDatabase{
	// Check if the SQL database has already been saved to the users phone, if not then copy it over
	BOOL success;
    printf("Checking exist database ...\n");
    
	// Create a FileManager object, we will use this to check the status
	// of the database and to copy it over if required
	NSFileManager *fileManager = [NSFileManager defaultManager];
    
	// Check if the database has already been created in the users filesystem
	success = [fileManager fileExistsAtPath:databasePath];
    
	// If the database already exists then return without doing anything
	if(success) {
        return;
    }
    
	// If not then proceed to copy the database from the application to the users filesystem
    
	// Get the path to the database in the application package
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
    
	// Copy the database from the package to the users filesystem
	[fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
    
	//[fileManager release];
}

-(void) readStoriesFromDatabase {
	// Setup the database object
	sqlite3 *database;
    sqlite3 *databaseRobot=NULL;
    
    printf("Reading stories and robot from database ...\n");
	// Init the animals Array
	stories = [[NSMutableArray alloc] init];
    robotWords = [[NSMutableArray alloc] init];
    

    
    
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
        printf("Database opened\n");
		// Setup the SQL Statement and compile it for faster access from table stories
		const char *sqlStatementStories = "select * from bd_stories";
        const char *sqlStatementRobot="select * from bd_robot";  
		sqlite3_stmt *compiledStatement;
        sqlite3_stmt *compiledStatementRobot;
        printf("Query stories: ");
		if(sqlite3_prepare_v2(database, sqlStatementStories, -1, &compiledStatement, NULL) == SQLITE_OK) {
            printf("successful\n");
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                printf("add story");
				// Read the data from the result row
				NSString *aContent = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
				
                
				// Create a new story object with the data from the database
				Stories *story = [[Stories alloc] initWithContent:aContent];
                
				// Add the Stories object to the Stories Array
				[stories addObject:story];
                
				
			}
		} else {
            //printf("");
            printf("%s\n",sqlite3_errmsg(database));
        }
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
            
        //        
        // Setup the SQL Statement and compile it for faster access from table robot
    
//		if(sqlite3_prepare_v2(database, sqlStatementRobot, -1, &compiledStatementRobot, NULL) == SQLITE_OK) {
//			// Loop through the results and add them to the feeds array
//			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
//				// Read the data from the result row
//          //      NSUInteger aID = sqlite3_column_int(compiledStatementRobot, 0);
//                NSUInteger aWordID= sqlite3_column_int(compiledStatementRobot, 1);
//                NSString *aWordMean= [NSString stringWithUTF8String:(char*)sqlite3_column_text(compiledStatementRobot, 2)];
//				NSString *aWord = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatementRobot, 3)];
//                NSUInteger aPlayerYN=sqlite3_column_int(compiledStatementRobot, 4);
//				
//                
//				// Create a new animal object with the data from the database
//			//	 Robot *robotFull = [[Robot alloc] initWithRobot:aWord wordMean:aWordMean  wordID:aWordID isPlayerYN:aPlayerYN];
//                Robot *robot=[[Robot alloc]initWithWord:aWord];
//                
//				// Add the word object to the robotwords Array
//				[robotWords addObject:robot];
//                
//				
//			}
//		} else {
//            printf("%s\n",sqlite3_errmsg(database));
//        }
//		// Release the compiled statement from memory
//		sqlite3_finalize(compiledStatementRobot);
        
        sqlite3_close(database);
	} else {
        printf("Error in opening database\n");
    }
	
    
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
