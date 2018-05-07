//
//  ViewController.h
//  WYXW
//
//  Created by 刘冠中 on 2018/4/21.
//  Copyright © 2018年 刘冠中. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

//UITableView控件
@property (weak,nonatomic) IBOutlet UITableView *tableView;


@property (strong,nonatomic) NSMutableArray *tableDataArr;



-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

-(void) tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath;

@end

