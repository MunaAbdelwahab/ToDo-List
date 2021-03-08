//
//  EditVC.m
//  To Do List
//
//  Created by Muna Abdelwahab on 2/26/21.
//

#import "ShowVC.h"
#import <UserNotifications/UNNotificationContent.h>
#import <UserNotifications/UNNotificationSound.h>
#import <UserNotifications/UNNotificationRequest.h>
#import <UserNotifications/UNUserNotificationCenter.h>
#import <UserNotifications/UNNotificationTrigger.h>

@interface ShowVC ()
{
    NSMutableArray *task;
    NSMutableArray *date;
    NSMutableArray *priority;
    NSMutableArray *state;
    NSMutableArray *desc;
    
    bool isGrantuedNotificationAceess;
    UNAuthorizationOptions options;
    UNUserNotificationCenter *center;
}

@end

@implementation ShowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _editTask.enabled = false;
    _editDate.enabled = false;
    _editPriority.enabled = false;
    _editDesc.enabled = false;
    _editState.enabled = false;
    
    task = [_dic objectForKey:@"tasks"];
    date = [_dic objectForKey:@"deadline"];
    desc = [_dic objectForKey:@"descriptions"];
    state = [_dic objectForKey:@"states"];
    priority = [_dic objectForKey:@"priorities"];
    
    [_editTask setText:[task objectAtIndex:_num]];
    NSString *s = [[priority objectAtIndex:_num] stringByAppendingString:@".jpg"];
    UIImage *image = [UIImage imageNamed:s];
    [_editImage setImage:image];
    [_editDesc setText:[desc objectAtIndex:_num]];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"dd-MMM-yyyy hh:min a"];
    NSString *dateString = [formatter stringForObjectValue:[date objectAtIndex:_num]];
    
    [_editDate setText:dateString];
    [_editState setText:[state objectAtIndex:_num]];
    [_editPriority setText:[priority objectAtIndex:_num]];
    
    isGrantuedNotificationAceess = false;
        
        
    center = [UNUserNotificationCenter currentNotificationCenter];
    options = UNAuthorizationOptionAlert + UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
        self->isGrantuedNotificationAceess = granted;
    }];
}

- (IBAction)editButton:(id)sender {
    EditVC *edit = [self.storyboard instantiateViewControllerWithIdentifier:@"submitVC"];
    [edit setNum:_num];
    [edit setMyProtocol2:self];
    [self.navigationController pushViewController:edit animated:YES];
    
}

-(void) myEdit:(NSMutableDictionary *)mydic :(NSInteger)myNum{
    
    task = [mydic objectForKey:@"tasks"];
    date = [mydic objectForKey:@"deadline"];
    priority = [mydic objectForKey:@"priorities"];
    desc = [mydic objectForKey:@"descriptions"];
    state = [mydic objectForKey:@"states"];
    
    [_editTask setText:[task objectAtIndex:myNum]];
    NSString *s = [[priority objectAtIndex:myNum] stringByAppendingString:@".jpg"];
    UIImage *image = [UIImage imageNamed:s];
    [_editImage setImage:image];
    [_editDesc setText:[desc objectAtIndex:myNum]];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"dd-MMM-yyyy hh:min a"];
    NSString *dateString = [formatter stringForObjectValue:[date objectAtIndex:myNum]];
    
    [_editDate setText:dateString];
    [_editState setText:[state objectAtIndex:myNum]];
    [_editPriority setText:[priority objectAtIndex:myNum]];
}

-(IBAction)cancelButton:(id)sender {
    NSString *plistPath = @"/Users/munaabdelwahab/Documents/To do project/list.plist";
    NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    [_myProtocol4 myShow:plistDict];
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)notifictionButton:(id)sender {
    task = [_dic objectForKey:@"tasks"];
    date = [_dic objectForKey:@"deadline"];
    desc = [_dic objectForKey:@"descriptions"];
    state = [_dic objectForKey:@"states"];
    priority = [_dic objectForKey:@"priorities"];
    
    if (isGrantuedNotificationAceess) {
        center = [UNUserNotificationCenter currentNotificationCenter];
        UNMutableNotificationContent *content = [UNMutableNotificationContent new];
        content.title = [task objectAtIndex:_num];
        content.body  = [desc objectAtIndex:_num];
        content.sound = [UNNotificationSound defaultSound];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        [calendar setTimeZone:[NSTimeZone localTimeZone]];
        NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitTimeZone fromDate:[date objectAtIndex:_num]];
        
        UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:NO];


        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"UYLocalNotification" content:content trigger:trigger];
        [center addNotificationRequest:request withCompletionHandler:nil];
    }
}

@end
