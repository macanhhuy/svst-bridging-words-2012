//
//  MDDemoViewController.h
//  Messages Demo
//
//  Created by Sam Soffes on 11/7/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

#import "SSMessagesViewController.h"

@interface MDDemoViewController : SSMessagesViewController<UITextFieldDelegate> {
   NSMutableArray *myArray;

}
@property(strong,nonatomic) NSMutableArray *myArray;

@end
