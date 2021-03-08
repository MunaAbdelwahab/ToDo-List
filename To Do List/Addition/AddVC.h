//
//  AddVC.h
//  To Do List
//
//  Created by Muna Abdelwahab on 2/25/21.
//

#import <UIKit/UIKit.h>
#import "addMethod.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddVC : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *NewTask;
@property (weak, nonatomic) IBOutlet UITextField *NewDesc;
@property (weak, nonatomic) IBOutlet UITextField *NewState;
@property (weak, nonatomic) IBOutlet UITextField *NewPriority;
@property (weak, nonatomic) IBOutlet UIDatePicker *NewDate;

@property id <addMethod> myProtocol3;
@end

NS_ASSUME_NONNULL_END
