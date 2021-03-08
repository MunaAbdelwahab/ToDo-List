//
//  DoneVC.m
//  To Do List
//
//  Created by Muna Abdelwahab on 2/25/21.
//

#import "DoneVC.h"

@interface DoneVC ()
{
    NSMutableArray *task;
    NSMutableArray *date;
    NSMutableArray *priority;
    NSMutableArray *state;
    NSMutableArray *desc;
    NSMutableArray *creation;
    NSString *s;
    
    NSMutableArray *doneStates;
    NSMutableArray *doneTasks;
    NSMutableArray *doneDates;
    NSMutableArray *donePri;
    NSMutableArray *doneDesc;
    NSMutableArray *doneCreation;
    
    NSMutableDictionary *dict;
}

@end

@implementation DoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    doneStates = [NSMutableArray new];
    doneDesc = [NSMutableArray new];
    doneDates = [NSMutableArray new];
    donePri = [NSMutableArray new];
    doneTasks = [NSMutableArray new];
    doneCreation = [NSMutableArray new];
    
    NSString *plistPath = @"/Users/munaabdelwahab/Documents/To do project/list.plist";
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:plistPath])
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
    
    for (int i = 0; i < state.count ; i++) {
        if ([[state objectAtIndex:i] isEqual:@"done"]) {
            [doneStates addObject:[state objectAtIndex:i]];
            [doneTasks addObject:[task objectAtIndex:i]];
            [doneDesc addObject:[desc objectAtIndex:i]];
            [donePri addObject:[priority objectAtIndex:i]];
            [doneDates addObject:[date objectAtIndex:i]];
            [doneCreation addObject:[creation objectAtIndex:i]];
        }
    }
    
    dict = [NSMutableDictionary new];
    [dict setObject:doneTasks forKey:@"tasks"];
    [dict setObject:doneDates forKey:@"deadline"];
    [dict setObject:doneDesc forKey:@"descriptions"];
    [dict setObject:donePri forKey:@"priorities"];
    [dict setObject:doneStates forKey:@"states"];
    [dict setObject:doneCreation forKey:@"creation"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [doneTasks count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyTableViewCell *cell = (MyTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    UILabel *taskLable = [cell viewWithTag:1];
    UILabel *dateLable = [cell viewWithTag:2];
    UIImageView *imageView = [cell viewWithTag:3];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"dd-MMM-yyyy hh:min a"];
    NSString *dateString = [formatter stringForObjectValue:[doneCreation objectAtIndex:indexPath.row]];
    
    taskLable.text = [doneTasks objectAtIndex:indexPath.row];
    dateLable.text = dateString;
    s = [[donePri objectAtIndex:indexPath.row] stringByAppendingString:@".jpg"];
    imageView.image = [UIImage imageNamed:s];
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

        [doneTasks removeObjectAtIndex:indexPath.row];
        [doneDesc removeObjectAtIndex:indexPath.row];
        [doneDates removeObjectAtIndex:indexPath.row];
        [donePri removeObjectAtIndex:indexPath.row];
        [doneStates removeObjectAtIndex:indexPath.row];
        [doneCreation removeObjectAtIndex:indexPath.row];

        [dictionary writeToFile:plistPath atomically:YES];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ShowVC *edit = [self.storyboard instantiateViewControllerWithIdentifier:@"editVC"];
    
    [edit setNum:indexPath.row];
    [edit setDic:dict];
    
    [edit setMyProtocol4:self];
    [self.navigationController pushViewController:edit animated:YES];
}

-(void)myShow:(NSMutableDictionary *)myDic {
    task = [myDic objectForKey:@"tasks"];
    date = [myDic objectForKey:@"deadline"];
    priority = [myDic objectForKey:@"priorities"];
    desc = [myDic objectForKey:@"descriptions"];
    state = [myDic objectForKey:@"states"];
    
    [self.tableView reloadData];
}

@end
