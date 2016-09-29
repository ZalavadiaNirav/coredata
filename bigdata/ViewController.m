//
//  ViewController.m
//  bigdata
//
//  Created by C N Soft Net on 28/09/16.
//  Copyright © 2016 C N Soft Net. All rights reserved.
//

#import "ViewController.h"
#import "AddProjectViewcontroller.h"
#import <CoreData/CoreData.h>
@interface ViewController () 
{
    NSMutableArray *data;
    
}

@property (strong) NSMutableArray *data;

@end

@implementation ViewController

@synthesize data;

-(NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context=nil;
    id delegate=[[UIApplication sharedApplication] delegate];
    if([delegate performSelector:@selector(managedObjectContext)])
    {
        context=[delegate managedObjectContext];
    }
    return context;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.backgroundColor=[UIColor darkGrayColor];
    _tbl.delegate=self;
    _tbl.dataSource=self;
    _tbl.frame=CGRectMake(0, 0, 320,500);

}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.data=[[NSMutableArray alloc] init];    
    
    
    NSManagedObjectContext *context=[self managedObjectContext];
    NSFetchRequest *fetchreq=[[NSFetchRequest alloc] initWithEntityName:@"Assign"];
    self.data=[[context executeFetchRequest:fetchreq error:nil] mutableCopy];
    
    [_tbl reloadData];
}

#pragma mark - TableView Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    customCell *cell;
    cell=[tableView dequeueReusableCellWithIdentifier:@"customCell"];
    if(cell==nil)
    {
        cell=[[customCell alloc] init];

    }
    NSManagedObject *managedObject=[self.data objectAtIndex:indexPath.row];
    
    cell.DeveloperLbl.text=[NSString stringWithFormat:@"Developed By: %@",[managedObject valueForKey:@"project"]];
    cell.ProjectNameLbl.text=[NSString stringWithFormat:@"Project Name: %@",[managedObject valueForKey:@"name"]];
    
    UIImage *img=[[UIImage alloc] initWithData:[managedObject valueForKey:@"projectimage"]];
    if(img)
    {
        cell.projectImgVW.image=img;
    }
    return cell;
   
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return true;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context=[self managedObjectContext];
    if(editingStyle==UITableViewCellEditingStyleDelete)
    {
        [context deleteObject:[self.data objectAtIndex:indexPath.row]];
        NSError *err=nil;
        if(![context save:&err])
        {
            NSLog(@"Failed to Delete %@ %@",err,[err localizedDescription]);
            return;
        }
        [self.data removeObjectAtIndex:indexPath.row];
        [_tbl deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
    }
        
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"editStoryID" sender:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"editStoryID"])
    {
        NSManagedObject *selectedproject=[self.data objectAtIndex:[_tbl indexPathForSelectedRow].row];
        AddProjectViewcontroller *obj=segue.destinationViewController;
        obj.selectedManagedObject=selectedproject;
        
    }
   

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
