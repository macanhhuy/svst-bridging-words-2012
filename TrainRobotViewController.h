//
//  MDDemoViewController.h
//  Messages Demo
//
//  Created by Sam Soffes on 11/7/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

#import "SSMessagesViewController.h"
#import "ResultRobotTrainingViewController.h"

@interface TrainRobotViewController : SSMessagesViewController<UITextFieldDelegate> {
   NSMutableArray *myArray;
	NSMutableArray *arrListDictObj;
	NSMutableArray *arrListWord;
    ResultRobotTrainingViewController *rsView;

 

}
@property(strong,nonatomic) NSMutableArray *myArray;
@property (nonatomic, retain) NSMutableArray *arrListDictObj;
@property (nonatomic, retain) NSMutableArray *arrListWord;
@property (strong,nonatomic) ResultRobotTrainingViewController *rsView;

@property char currentChar;

- (void) copyDatabaseIfNeeded;
- (NSString *) getDBPath;


@end
