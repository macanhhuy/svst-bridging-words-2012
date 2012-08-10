//
//  ResultViewController.h
//  Bridging Words
//
//  Created by Mahmood1 on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property NSString *resultString;
@property NSInteger wordScore;
@property NSInteger timeScore;

- (IBAction)replayButtonTouch:(id)sender;
- (IBAction)menuButtonTouch:(id)sender;

@end