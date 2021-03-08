//
//  EditVC.m
//  To Do List
//
//  Created by Muna Abdelwahab on 3/2/21.
//

#import "EditVC.h"

@interface EditVC ()

@end

@implementation EditVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)submitButton:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Submission" message:@"Are You Sure" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSString *plistPath = @"/Users/munaabdelwahab/Documents/To do project/list.plist";
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
        
        [[dictionary objectForKey:@"tasks"] removeObjectAtIndex:self->_num];
        [[dictionary objectForKey:@"deadline"] removeObjectAtIndex:self->_num];
        [[dictionary objectForKey:@"descriptions"] removeObjectAtIndex:self->_num];
        [[dictionary objectForKey:@"states"] removeObjectAtIndex:self->_num];
        [[dictionary objectForKey:@"priorities"] removeObjectAtIndex:self->_num];

        [[dictionary objectForKey:@"tasks"] insertObject:self->_taskEdited.text atIndex:self->_num];
        [[dictionary objectForKey:@"deadline"] insertObject:self->_dateEdited.date atIndex:self->_num];
        [[dictionary objectForKey:@"descriptions"] insertObject:self->_descEdited.text atIndex:self->_num];
        [[dictionary objectForKey:@"states"] insertObject:self->_stateEdited.text atIndex:self->_num];
        [[dictionary objectForKey:@"priorities"] insertObject:self->_priorityEdited.text atIndex:self->_num];
        
        NSError *error;
        NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:dictionary
                format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
        if(plistData)
                {
                    [plistData writeToFile:plistPath atomically:YES];
                    printf("Data edited sucessfully\n");
                }
                else
                {
                    printf("Data not edited\n");
                }
        [self->_myProtocol2 myEdit:dictionary:self->_num];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *no = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:yes];
    [alert addAction:no];
    [self presentViewController:alert animated:YES completion:NULL];
}

- (IBAction)cancelButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
