//
//  ToDoVC.h
//  To Do List
//
//  Created by Muna Abdelwahab on 2/25/21.
//

#import <UIKit/UIKit.h>
#import "ShowVC.h"
#import "CheckButton.h"
#import "MyTableViewCell.h"
#import "AddVC.h"
#import "addMethod.h"
#import "showMethod.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToDoVC : UITableViewController<UITableViewDelegate, UITableViewDataSource, CheckButton, UISearchBarDelegate, addMethod, showMethod>
@property (weak, nonatomic) IBOutlet UISearchBar *searchbar;
@end

NS_ASSUME_NONNULL_END
