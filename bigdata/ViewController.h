//
//  ViewController.h
//  bigdata
//
//  Created by C N Soft Net on 28/09/16.
//  Copyright © 2016 C N Soft Net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "customCell.h"

@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tbl;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addBtn;

@end

