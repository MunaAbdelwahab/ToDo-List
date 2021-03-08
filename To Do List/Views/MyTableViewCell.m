//
//  MyTableViewCell.m
//  To Do List
//
//  Created by Muna Abdelwahab on 2/27/21.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(IBAction)checkButton:(id)sender {
    [_myProtocol checkedButton:sender];
}


@end
