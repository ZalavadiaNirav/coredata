//
//  AddProjectViewcontroller.m
//  bigdata
//
//  Created by C N Soft Net on 28/09/16.
//  Copyright © 2016 C N Soft Net. All rights reserved.
//

#import "AddProjectViewcontroller.h"

@implementation AddProjectViewcontroller

@synthesize selectedManagedObject,saveProject;

-(NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context=nil;
    id delegate=[[UIApplication sharedApplication]delegate];
    if([delegate performSelector:@selector(managedObjectContext)])
    {
        context=[delegate managedObjectContext];
    }
    return context;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
//    _pickImageBtn.hidden=false;

    if(selectedManagedObject)
    {
        self.devTxtfield.text=[NSString stringWithFormat:@"%@",[selectedManagedObject valueForKey:@"name"]];
        self.pronameTxtfield.text=[NSString stringWithFormat:@"%@",[selectedManagedObject valueForKey:@"project"]];
        UIImage *img=[[UIImage alloc] initWithData:[selectedManagedObject valueForKey:@"projectimage"]];
        if (img)
        {
            _PickedImageVW.image=img;
        }
        
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
#pragma mark TextField

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger nexttag=textField.tag+1;
    [self jumptoNextField:textField :nexttag];
    return NO;
}

-(void)jumptoNextField:(UITextField *)txtField :(NSInteger)tag;
{
    UIResponder *nextResponder = [self.view viewWithTag:tag];
    
    if ([nextResponder isKindOfClass:[UITextField class]]) {
        [nextResponder becomeFirstResponder];
    }
    else {
        [txtField resignFirstResponder];
    }

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_devTxtfield resignFirstResponder];
    [_pronameTxtfield resignFirstResponder];
}

-(IBAction)saveAction:(id)sender
{
    NSManagedObjectContext *context=[self managedObjectContext];

    if(self.selectedManagedObject)
    {
        //update existing project
        [self.selectedManagedObject setValue:self.devTxtfield.text forKey:@"name"];
        [self.selectedManagedObject setValue:self.pronameTxtfield.text forKey:@"project"];
        if(_PickedImageVW.image)
        {
            UIImage *img=_PickedImageVW.image;
            NSData *imageData=UIImagePNGRepresentation(img);
            [self.selectedManagedObject setValue:imageData forKey:@"projectimage"];
        }
    }
    else
    {
        //create new project
        
        NSManagedObject *assign=[NSEntityDescription insertNewObjectForEntityForName:@"Assign" inManagedObjectContext:context];
        [assign setValue:self.devTxtfield.text forKey:@"name"];
        [assign setValue:self.pronameTxtfield.text forKey:@"project"];
        if(_PickedImageVW.image)
        {
            UIImage *img=_PickedImageVW.image;
            NSData *imageData = UIImagePNGRepresentation(img);
            [assign setValue:imageData forKey:@"projectimage"];
        }

    }
    NSError *err=nil;
    if(![context save:&err])
    {
        NSLog(@"Failed to insert Data %@",[err description]);
    }

    [self dismissViewControllerAnimated:YES completion:nil];

}

-(IBAction)PickImageAction:(id)sender
{
    UIImagePickerController *imgPckr=[[UIImagePickerController alloc] init];
    imgPckr.delegate=self;
    imgPckr.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imgPckr animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{

//    _pickImageBtn.hidden=TRUE;
    [picker dismissViewControllerAnimated:YES completion:nil];
    _PickedImageVW.image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
}

@end
