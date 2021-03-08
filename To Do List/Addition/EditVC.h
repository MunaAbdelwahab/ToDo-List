//
//  SubmitViewController.h
//  To Do List
//
//  Created by Muna Abdelwahab on 2/28/21.
//

#import <UIKit/UIKit.h>
#import "editMethod.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *taskEdited;
@property (weak, nonatomic) IBOutlet UITextField *descEdited;
@property (weak, nonatomic) IBOutlet UITextField *stateEdited;
@property (weak, nonatomic) IBOutlet UIDatePicker *dateEdited;
@property (weak, nonatomic) IBOutlet UITextField *priorityEdited;

@property NSInteger num;

@property id <editMethod> myProtocol2;
@end

NS_ASSUME_NONNULL_END
