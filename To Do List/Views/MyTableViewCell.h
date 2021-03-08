//
//  MyTableViewCell.h
//  To Do List
//
//  Created by Muna Abdelwahab on 2/27/21.
//

#import <UIKit/UIKit.h>
#import "CheckButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyTableViewCell : UITableViewCell
@property id <CheckButton> myProtocol;
@end

NS_ASSUME_NONNULL_END
