//
//  InProcessVC.m
//  To Do List
//
//  Created by Muna Abdelwahab on 2/25/21.
//

#import "InProcessVC.h"

@interface InProcessVC ()
{
    NSMutableArray *task;
    NSMutableArray *date;
    NSMutableArray *priority;
    NSMutableArray *state;
    NSMutableArray *desc;
    NSMutableArray *creation;
    NSString *s;
    
    NSMutableArray *inProcessStates;
    NSMutableArray *inProcessTasks;
    NSMutableArray *inProcessDates;
    NSMutableArray *inProcessPri;
    NSMutableArray *inProcessDesc;
    NSMutableArray *inprocessCreation;
    
    NSMutableDictionary *dict;
}
@end

@implementation InProcessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    inProcessStates = [NSMutableArray new];
    inProcessDesc = [NSMutableArray new];
    inProcessDates = [NSMutableArray new];
    inProcessPri = [NSMutableArray new];
    inProcessTasks = [NSMutableArray new];
    inprocessCreation = [NSMutableArray new];
    
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
        if ([[state objectAtIndex:i] isEqual:@"in process"]) {
            [inProcessStates addObject:[state objectAtIndex:i]];
            [inProcessTasks addObject:[task objectAtIndex:i]];
            [inProcessDesc addObject:[desc objectAtIndex:i]];
            [inProcessPri addObject:[priority objectAtIndex:i]];
            [inProcessDates addObject:[date objectAtIndex:i]];
            [inprocessCreation addObject:[creation objectAtIndex:i]];
        }
    }
    
    dict = [NSMutableDictionary new];
    [dict setObject:inProcessTasks forKey:@"tasks"];
    [dict setObject:inProcessDates forKey:@"deadline"];
    [dict setObject:inProcessDesc forKey:@"descriptions"];
    [dict setObject:inProcessPri forKey:@"priorities"];
    [dict setObject:inProcessStates forKey:@"states"];
    [dict setObject:inprocessCreation forKey:@"creation"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [inProcessTasks count];
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
    NSString *dateString = [formatter stringForObjectValue:[inprocessCreation objectAtIndex:indexPath.row]];
    
    taskLable.text = [inProcessTasks objectAtIndex:indexPath.row];
    dateLable.text = dateString;
    s = [[inProcessPri objectAtIndex:indexPath.row] stringByAppendingString:@".jpg"];
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

        [inProcessTasks removeObjectAtIndex:indexPath.row];
        [inProcessDesc removeObjectAtIndex:indexPath.row];
        [inProcessDates removeObjectAtIndex:indexPath.row];
        [inProcessPri removeObjectAtIndex:indexPath.row];
        [inProcessStates removeObjectAtIndex:indexPath.row];
        [inprocessCreation removeObjectAtIndex:indexPath.row];

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
