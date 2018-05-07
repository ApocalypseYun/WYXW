//
//  ViewController.m
//  WYXW
//
//  Created by 刘冠中 on 2018/4/21.
//  Copyright © 2018年 刘冠中. All rights reserved.
//

#import "ViewController.h"
#import "MyCellTableViewCell.h"
#import "LruQueue.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //载入数据
    [self loadData];
}


- (void) loadData{
    //初始化
    //转换json
    NSString *urlString=@"https://c.m.163.com/nc/article/list/T1414142214384/0-20.html";
    NSURL *url=[NSURL URLWithString:urlString];
    NSData *data=[[NSData alloc]initWithContentsOfURL:url];
    id ret=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSArray *arr1 = [ret allKeys];
    NSArray *dataGet=[ret objectForKey:arr1[0]];
    
    
    NSMutableArray *usersArr = [[NSMutableArray alloc] init];
    for(int i=0;i<[dataGet count];i++){
        NSMutableDictionary *dic=[NSMutableDictionary dictionary];
        [dic setValue:[dataGet[i] objectForKey:@"title"] forKey:@"lTitle"];
        if([dataGet[i] objectForKey:@"replyCount"]!=nil)
        {
            [dic setValue:[dataGet[i] objectForKey:@"replyCount"] forKey:@"reply"];
        }
        
        if([dataGet[i] objectForKey:@"imgsrc"]!=nil)
        {
            [dic setValue:[dataGet[i] objectForKey:@"imgsrc"] forKey:@"image"];
        }
        
        if([dataGet[i] objectForKey:@"source"]!=nil)
        {
            [dic setValue:[dataGet[i] objectForKey:@"source"] forKey:@"source"];
        }
        
        [usersArr addObject:dic];
        
    }
    self.tableDataArr=[usersArr copy];
    
}

/*
- (void) loadMore{
    NSMutableArray *more;
    //加载你的数据
    
    more = [NSMutableArray arrayWithObjects:@"最新数据", nil];
    [self performSelectorOnMainThread:@selector(appendTableWith:) withObject:more waitUntilDone:NO];
}

- (void) appendTableWith:(NSMutableArray *)data{
    for(int i=0;i<[data count];i++){
        [self.tableDataArr addObject:[data objectAtIndex:i]];
    }
    
    NSMutableArray *insertINdexPants =[NSMutableArray arrayWithCapacity:[data count]];
    for(int ind=0;ind < [data count];ind++){
        NSIndexPath *newPath = [NSIndexPath indexPathForRow:[self.tableDataArr indexOfObject:[data objectAtIndex:ind]] inSection:0];
        
        [insertINdexPants addObject:newPath];
    }
    
    [self.tableView insertRowsAtIndexPaths:insertINdexPants withRowAnimation:UITableViewRowAnimationFade];
}
*/


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.tableDataArr count];
}


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *MyCellIdentifier =@"MyCellIdentifier";

    static BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"MyCellTableViewCell" bundle:[NSBundle mainBundle]];
        [self.tableView registerNib:nib forCellReuseIdentifier:MyCellIdentifier];
        nibsRegistered = YES;
    }
    //获取单元格
    MyCellTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:MyCellIdentifier forIndexPath:indexPath];
    //加载更多
    if([indexPath row]==[self.tableDataArr count]){
        
        cell.lTitleLabel.text =@"LoadMore";
    }
    else{//为单元格设置数据
        if([[self.tableDataArr objectAtIndex:indexPath.row] objectForKey:@"lTitle"]!=nil){
           
            cell.lTitleLabel.text = [[self.tableDataArr objectAtIndex:indexPath.row] objectForKey:@"lTitle"];
            
        }
        
        if([[self.tableDataArr objectAtIndex:indexPath.row] objectForKey:@"source"]!=nil){
            
            cell.sourceLabel.text = [[self.tableDataArr objectAtIndex:indexPath.row] objectForKey:@"source"];
            
        }
        
        if([[self.tableDataArr objectAtIndex:indexPath.row] objectForKey:@"reply"]!=nil){
            
            cell.replyCount.text = ((void)(@"%@跟帖"),[[[self.tableDataArr objectAtIndex:indexPath.row] objectForKey:@"reply"] stringValue]);
            
        }
        
        if([[self.tableDataArr objectAtIndex:indexPath.row] objectForKey:@"image"]!=nil){
            
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSData *data;
                NSString *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
               NSString *filePath = [documents stringByAppendingPathComponent:@"Image.plist"];
                NSMutableDictionary *imageArr = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
                if([imageArr objectForKey:[[self.tableDataArr objectAtIndex:indexPath.row] objectForKey:@"image"]]==nil){
                    data=[NSData dataWithContentsOfURL:[NSURL URLWithString:[[self.tableDataArr objectAtIndex:indexPath.row] objectForKey:@"image"]]];
                    [imageArr setObject:data forKey:[[self.tableDataArr objectAtIndex:indexPath.row] objectForKey:@"image"]];
                    NSString* str= [LruQueue add:[[self.tableDataArr objectAtIndex:indexPath.row] objectForKey:@"image"]];
                    if(![str isEqualToString:[[self.tableDataArr objectAtIndex:indexPath.row] objectForKey:@"image"]]){
                        
                        [imageArr removeObjectForKey:str];
                        
                    }
                    [imageArr writeToFile:filePath atomically:YES];
                    
                }
                else{
                    data=[imageArr objectForKey:[[self.tableDataArr objectAtIndex:indexPath.row] objectForKey:@"image"]];
                    [LruQueue change:[[self.tableDataArr objectAtIndex:indexPath.row] objectForKey:@"image"]];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.image=[UIImage imageWithData:data];
                });
            });
            /*
            NSURL *url=[NSURL URLWithString:[[self.tableDataArr objectAtIndex:indexPath.row] objectForKey:@"image"]];
            NSData *data=[NSData dataWithContentsOfURL:url];
            NSLog(@"data = %@",data);
            cell.image=[UIImage imageWithData:data];
            */
        }
        
        
    }
    return cell;
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(nonnull MyCellTableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if(indexPath.row==self.tableDataArr.count){
        [self performSelectorInBackground:@selector(loadMore) withObject:nil];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
