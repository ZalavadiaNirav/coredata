//
//  AddProjectViewcontroller.h
//  bigdata
//
//  Created by C N Soft Net on 28/09/16.
//  Copyright © 2016 C N Soft Net. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>

@interface AddProjectViewcontroller : ViewController <UIImagePickerControllerDelegate,UITextFieldDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *devTxtfield;

@property (weak, nonatomic) IBOutlet UITextField *pronameTxtfield;

@property (strong, nonatomic) IBOutlet UIButton *saveProject;

@property (strong) NSManagedObject *selectedManagedObject;

@property (weak, nonatomic) IBOutlet UIButton *pickImageBtn;

@property (weak, nonatomic) IBOutlet UIImageView *PickedImageVW;


-(IBAction)saveAction:(id)sender;

-(IBAction)PickImageAction:(id)sender;

-(void)jumptoNextField:(UITextField *)txtField :(NSInteger)tag;

@end
