//
//  EditVC.h
//  To Do List
//
//  Created by Muna Abdelwahab on 2/26/21.
//

#import <UIKit/UIKit.h>
#import "EditVC.h"
#import "InProcessVC.h"
#import "editMethod.h"
#import "showMethod.h"
#import <UserNotifications/UserNotifications.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShowVC : UIViewController<editMethod>
@property (weak, nonatomic) IBOutlet UITextField *editState;
@property (weak, nonatomic) IBOutlet UITextField *editDate;
@property (weak, nonatomic) IBOutlet UITextField *editDesc;
@property (weak, nonatomic) IBOutlet UIImageView *editImage;
@property (weak, nonatomic) IBOutlet UITextField *editTask;
@property (weak, nonatomic) IBOutlet UITextField *editPriority;

@property NSMutableDictionary *dic;
@property NSInteger num;

@property id <showMethod> myProtocol4;
@end

NS_ASSUME_NONNULL_END
