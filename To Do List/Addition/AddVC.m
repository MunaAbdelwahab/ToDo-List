//
//  AddVC.m
//  To Do List
//
//  Created by Muna Abdelwahab on 2/25/21.
//

#import "AddVC.h"

@interface AddVC () {
    NSMutableArray *task;
    NSMutableArray *date;
    NSMutableArray *priority;
    NSMutableArray *state;
    NSMutableArray *desc;
    NSMutableArray *creation;
}

@end

@implementation AddVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)saveButton:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Confirmation" message:@"Are You Sure" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSString *plistPath = @"/Users/munaabdelwahab/Documents/To do project/list.plist";
        NSError *error;

        NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        
        if (self->task == nil) {
            self->task = [[NSMutableArray alloc] init];
            self->date = [[NSMutableArray alloc] init];
            self->state = [[NSMutableArray alloc] init];
            self->desc = [[NSMutableArray alloc] init];
            self->priority = [[NSMutableArray alloc] init];
            self->creation = [NSMutableArray new];
            
            self->task = [plistDict objectForKey:@"tasks"];
            self->date = [plistDict objectForKey:@"deadline"];
            self->priority = [plistDict objectForKey:@"priorities"];
            self->desc = [plistDict objectForKey:@"descriptions"];
            self->state = [plistDict objectForKey:@"states"];
            self->creation = [plistDict objectForKey:@"creation"];
        }
        else {
            self->task = [plistDict objectForKey:@"tasks"];
            self->date = [plistDict objectForKey:@"deadline"];
            self->priority = [plistDict objectForKey:@"priorities"];
            self->desc = [plistDict objectForKey:@"descriptions"];
            self->state = [plistDict objectForKey:@"states"];
            self->creation = [plistDict objectForKey:@"creation"];
        }
            
        [self->task addObject:self->_NewTask.text];
        [self->date addObject:self->_NewDate.date];
        [self->desc addObject:self->_NewDesc.text];
        [self->state addObject:self->_NewState.text];
        [self->priority addObject:self->_NewPriority.text];
        [self->creation addObject:[NSDate date]];
        
        [plistDict setObject:self->task forKey:@"tasks"];
        [plistDict setObject:self->date forKey:@"deadline"];
        [plistDict setObject:self->desc forKey:@"descriptions"];
        [plistDict setObject:self->state forKey:@"states"];
        [plistDict setObject:self->priority forKey:@"priorities"];
        [plistDict setObject:self->creation forKey:@"creation"];
        
        
        NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistDict
                format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
        if(plistData)
                {
                    [plistData writeToFile:plistPath atomically:YES];
                    printf("Data saved sucessfully\n");
                }
                else
                {
                    printf("Data not saved\n");
                }
        [self->_myProtocol3 myAdd:plistDict];
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
