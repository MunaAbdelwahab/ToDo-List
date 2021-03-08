//
//  ToDoVC.m
//  To Do List
//
//  Created by Muna Abdelwahab on 2/25/21.
//

#import "ToDoVC.h"

@interface ToDoVC ()
{
    NSString *s;
    
    NSMutableArray *filter;
    NSMutableArray *task2;
    BOOL isFlitered;
    
    BOOL isSorted;
    NSMutableArray *sorted;
    NSMutableArray *sortedTask;
    NSMutableArray *sortedDate;
    NSMutableArray *highTask;
    NSMutableArray *medTask;
    NSMutableArray *lowTask;
    NSMutableArray *high;
    NSMutableArray *med;
    NSMutableArray *low;
    NSMutableArray *highDate;
    NSMutableArray *medDate;
    NSMutableArray *lowDate;
    
    NSMutableArray *task;
    NSMutableArray *date;
    NSMutableArray *priority;
    NSMutableArray *state;
    NSMutableArray *desc;
    NSMutableArray *creation;
}

@end

@implementation ToDoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isFlitered = false;
    self.searchbar.delegate = self;
    
    NSString *plistPath = @"/Users/munaabdelwahab/Documents/To do project/list.plist";
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
        {
            plistPath = [[NSBundle mainBundle] pathForResource:@"list" ofType:@"plist"];
        }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    task = [dic objectForKey:@"tasks"];
    date = [dic objectForKey:@"deadline"];
    priority = [dic objectForKey:@"priorities"];
    desc = [dic objectForKey:@"descriptions"];
    state = [dic objectForKey:@"states"];
    creation = [dic objectForKey:@"creation"];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSString *plistPath = @"/Users/munaabdelwahab/Documents/To do project/list.plist";
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    task = [dic objectForKey:@"tasks"];
    task2 = [NSMutableArray new];
    
    if (searchText.length == 0) {
        isFlitered = false;
    }
    else {
        isFlitered = true;
        for (NSString *filtered in task) {
            NSRange range = [filtered rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (range.location != NSNotFound) {
                [task2 addObject:filtered];
            }
        }
    }
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isSorted == YES) {
        return [sorted count];
    }
    else {
        if (isFlitered) {
            return task2.count;
        }
        return [task count];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyTableViewCell *cell = (MyTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    UILabel *taskLable = [cell viewWithTag:1];
    UILabel *dateLable = [cell viewWithTag:2];
    UIImageView *imageView = [cell viewWithTag:3];
    if (isSorted == YES) {
        taskLable.text = [sortedTask objectAtIndex:indexPath.row];
        
        NSDateFormatter *formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"dd-MMM-yyyy hh:min a"];
        NSString *dateString = [formatter stringForObjectValue:[sortedDate objectAtIndex:indexPath.row]];
        
        dateLable.text = dateString;
        s = [[sorted objectAtIndex:indexPath.row] stringByAppendingString:@".jpg"];
        imageView.image = [UIImage imageNamed:s];
    }
    else {
        if (isFlitered) {
            taskLable.text = [task2 objectAtIndex:indexPath.row];
        }
        else {
            NSDateFormatter *formatter = [NSDateFormatter new];
            [formatter setDateFormat:@"dd-MMM-yyyy hh:min a"];
            NSString *dateString = [formatter stringForObjectValue:[creation objectAtIndex:indexPath.row]];
            
            taskLable.text = [task objectAtIndex:indexPath.row];
            dateLable.text = dateString;
            s = [[priority objectAtIndex:indexPath.row] stringByAppendingString:@".jpg"];
            imageView.image = [UIImage imageNamed:s];
        }
    }
    cell.myProtocol = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString *plistPath = @"/Users/munaabdelwahab/Documents/To do project/list.plist";
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];

        task = [dictionary objectForKey:@"tasks"];
        desc = [dictionary objectForKey:@"descriptions"];
        state = [dictionary objectForKey:@"states"];
        priority = [dictionary objectForKey:@"priorities"];
        date = [dictionary objectForKey:@"deadline"];
        creation = [dictionary objectForKey:@"creation"];

        [task removeObjectAtIndex:indexPath.row];
        [desc removeObjectAtIndex:indexPath.row];
        [date removeObjectAtIndex:indexPath.row];
        [priority removeObjectAtIndex:indexPath.row];
        [state removeObjectAtIndex:indexPath.row];
        [creation removeObjectAtIndex:indexPath.row];

        [dictionary writeToFile:plistPath atomically:YES];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ShowVC *edit = [self.storyboard instantiateViewControllerWithIdentifier:@"editVC"];
    NSString *plistPath = @"/Users/munaabdelwahab/Documents/To do project/list.plist";
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    [edit setNum:indexPath.row];
    [edit setDic:dic];
    
    [edit setMyProtocol4:self];
    [self.navigationController pushViewController:edit animated:YES];
}

-(void) checkedButton:(UIButton*)sender{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Welcome" message:@"Task is Process OR Done" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *isProcess = [UIAlertAction actionWithTitle:@"Is Process" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (sender.isSelected) {
            sender.selected = false;
        }
        else {
            [sender setImage:[UIImage imageNamed:@"process.png"] forState:UIControlStateSelected];
            sender.selected = true;
        }
        [self.tableView reloadData];
    }];
    UIAlertAction *done = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (sender.isSelected) {
            sender.selected = false;
        }
        else {
            [sender setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
            sender.selected = true;
        }
        [self.tableView reloadData];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:isProcess];
    [alert addAction:done];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:NULL];
}

- (IBAction)AddButton:(id)sender {
    AddVC *add = [self.storyboard instantiateViewControllerWithIdentifier:@"addVC"];
    [add setMyProtocol3:self];
    [self.navigationController pushViewController:add animated:YES];
}

-(void)myAdd:(NSMutableDictionary *)mydic {
    task = [mydic objectForKey:@"tasks"];
    date = [mydic objectForKey:@"deadline"];
    priority = [mydic objectForKey:@"priorities"];
    desc = [mydic objectForKey:@"descriptions"];
    state = [mydic objectForKey:@"states"];
    creation = [mydic objectForKey:@"creation"];
    
    [self.tableView reloadData];
}

-(void)myShow:(NSMutableDictionary *)myDic {
    task = [myDic objectForKey:@"tasks"];
    date = [myDic objectForKey:@"deadline"];
    priority = [myDic objectForKey:@"priorities"];
    desc = [myDic objectForKey:@"descriptions"];
    state = [myDic objectForKey:@"states"];
    
    [self.tableView reloadData];
}

- (IBAction)sortButton:(id)sender {
    if (isSorted == YES) {
        isSorted = NO;
        [self.tableView reloadData];
        
        printf("Not Sorted\n");
    }
    else {
        isSorted = YES;
        high = [NSMutableArray new];
        med  = [NSMutableArray new];
        low  = [NSMutableArray new];
        highTask = [NSMutableArray new];
        medTask  = [NSMutableArray new];
        lowTask  = [NSMutableArray new];
        highDate = [NSMutableArray new];
        medDate  = [NSMutableArray new];
        lowDate  = [NSMutableArray new];
        
        sortedTask = [NSMutableArray new];
        sortedDate = [NSMutableArray new];
        sorted = [NSMutableArray new];
        
        for (int i = 0; i < priority.count; i++) {
            if ([[priority objectAtIndex:i] isEqualToString:@"high"]) {
                [high addObject: [priority objectAtIndex:i]];
                [highDate addObject:[creation objectAtIndex:i]];
                [highTask addObject:[task objectAtIndex:i]];
            }
            else if ([[priority objectAtIndex:i] isEqualToString:@"medium"]) {
                [med addObject: [priority objectAtIndex:i]];
                [medDate addObject:[creation objectAtIndex:i]];
                [medTask addObject:[task objectAtIndex:i]];
            }
            else if ([[priority objectAtIndex:i] isEqualToString:@"low"]) {
                [low addObject: [priority objectAtIndex:i]];
                [lowDate addObject:[creation objectAtIndex:i]];
                [lowTask addObject:[task objectAtIndex:i]];
            }
        }
        [sorted addObjectsFromArray:high];
        [sorted addObjectsFromArray:med];
        [sorted addObjectsFromArray:low];
        
        [sortedTask addObjectsFromArray:highTask];
        [sortedTask addObjectsFromArray:medTask];
        [sortedTask addObjectsFromArray:lowTask];
        
        [sortedDate addObjectsFromArray:highDate];
        [sortedDate addObjectsFromArray:medDate];
        [sortedDate addObjectsFromArray:lowDate];
        
        [self.tableView reloadData];
        
        printf("Finish Sorted\n");
    }
}

@end
