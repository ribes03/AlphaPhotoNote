//
//  AlphaPhotoNoteViewController.m
//  AlphaPhotoNote
//
//  Created by Juan Ribes on 20/04/13.
//  Copyright (c) 2013 Juan Ribes. All rights reserved.
//

#import "PhotoViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <QuartzCore/QuartzCore.h>


#define kActionSheetColor       100


@interface PhotoViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIPopoverControllerDelegate,UIActionSheetDelegate>


@property (strong, nonatomic) UIPopoverController *imagePickerPopover;
@property (strong, nonatomic) UIPopoverController *colorPopover;
@property BOOL newMedia;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *colorButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet SmoothedBIView *selectedImage;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *trashButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *clearButton;

@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;
@property (nonatomic,assign) BOOL alertShowing,infoShowing;
@end

@implementation PhotoViewController

@synthesize colorButton,saveButton,trashButton,clearButton;
@synthesize infoView = _infoView;
@synthesize selectedImage = _selectedImage;


- (void)awakeFromNib
{
    [super awakeFromNib];
    self.title = @"Photo Note";
    _newMedia = YES;
    _infoShowing = NO;
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (actionSheet.cancelButtonIndex != buttonIndex) {
        if (actionSheet.tag == kActionSheetColor) {
            switch (buttonIndex) {
                case 0:
                    self.colorButton.title = [actionSheet buttonTitleAtIndex:buttonIndex];
                    [self.selectedImage setColorPen:[UIColor blackColor]];
                    break;
                    
                case 1:
                    self.colorButton.title = [actionSheet buttonTitleAtIndex:buttonIndex];
                    [self.selectedImage setColorPen:[UIColor redColor]];
                    break;
                    
                case 2:
                    self.colorButton.title = [actionSheet buttonTitleAtIndex:buttonIndex];
                    [self.selectedImage setColorPen:[UIColor greenColor]];
                    break;
                    
                case 3:
                    self.colorButton.title = [actionSheet buttonTitleAtIndex:buttonIndex];
                    [self.selectedImage setColorPen:[UIColor blueColor]];
                    break;
            }
            
        }

    }
}


- (IBAction)setColorPen:(UIBarButtonItem *)sender
{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select a color"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Black", @"Red", @"Green", @"Blue", nil];
    
    [actionSheet setTag:kActionSheetColor];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (!_alertShowing){
        [actionSheet showFromBarButtonItem:sender animated:YES];
        actionSheet.delegate = self;
        _alertShowing = YES;
        }

    }else [actionSheet showInView:self.selectedImage];
    
}

- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    _alertShowing = NO;
}

- (IBAction)trashNote:(UIBarButtonItem *)sender
{
    [UIView transitionWithView:self.selectedImage
                      duration:1.5
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:^ { self.selectedImage.alpha = 1.0;
                        [self.selectedImage trash];
                                           }
                    completion:NULL
     ];
    _newMedia = NO;
    self.selectedImage.beginTouch = NO;
}

-(void) flipInfo:(UITapGestureRecognizer *)t
{
    [self showInfo:self.infoButton];
}

- (IBAction)showInfo:(UIButton *)sender
{
    
    if (!_infoShowing){
        
    [UIView transitionWithView:self.selectedImage
                      duration:1.0
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^ { self.selectedImage.alpha = 1.0;
                        //234-230-202 BlancoPerla
                        //[self.infoView setBackgroundColor:[UIColor colorWithRed:254.0f/255.0f green:250.0f/255.0f blue:242.0f/255.0f alpha:1]];
                        [self.infoView setBackgroundColor:[UIColor lightGrayColor]];
                        [self.infoView setHidden:NO];                   
                        [self.selectedImage setHidden:YES];
                      
                    }
                    completion:NULL
     ];
        _infoShowing = YES;
    }else{
    
        [UIView transitionWithView:self.selectedImage
                          duration:1.0
                           options:UIViewAnimationOptionTransitionFlipFromRight
                        animations:^ { self.selectedImage.alpha = 1.0;
                            [self.selectedImage setHidden:NO];
                        }
                        completion:NULL
         ];
        _infoShowing = NO;
    }


}
    
- (IBAction)clearNote:(UIBarButtonItem *)sender
{
    [UIView transitionWithView:self.selectedImage
                      duration:0.7
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:^ { self.selectedImage.alpha = 1.0;
                        [self.selectedImage replaceImage];
                    }
                    completion:NULL
     ];
    _newMedia = NO;
    self.selectedImage.beginTouch = NO;
}

- (IBAction)addPhoto:(UIBarButtonItem *)sender

{
    [self presentImagePicker:UIImagePickerControllerSourceTypeSavedPhotosAlbum sender:sender];
     
}

// target/action of a bar button item to add Photo from Camera
- (IBAction)takePhoto:(UIBarButtonItem *)sender
{
      [self presentImagePicker:UIImagePickerControllerSourceTypeCamera sender:sender];
    
}

#pragma mark - UIImagePickerController
        
// presents a UIImagePickerController which gets an image from the specified sourceType
// on iPad, if sourceType is not Camera, presents in a popover from the given UIBarButtonItem
//   (else modally)

- (void)presentImagePicker:(UIImagePickerControllerSourceType)sourceType sender:(UIBarButtonItem *)sender
{
    if (!self.imagePickerPopover && [UIImagePickerController isSourceTypeAvailable:sourceType]) {
        NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
        if ([availableMediaTypes containsObject:(NSString *)kUTTypeImage]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.sourceType = sourceType;
            picker.mediaTypes = @[(NSString *)kUTTypeImage];
            picker.allowsEditing = YES;
            picker.delegate = self;
            if ((sourceType != UIImagePickerControllerSourceTypeCamera) && (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)) {
                self.imagePickerPopover = [[UIPopoverController alloc] initWithContentViewController:picker];
                [self.imagePickerPopover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                self.imagePickerPopover.delegate = self;
            } else {
                [self presentViewController:picker animated:YES completion:nil];
                
            }
        }
    }
}

// popover was canceled so clear out our property that points to the popover

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.imagePickerPopover = nil;
}

// UIImagePickerController was canceled, so dismiss it

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// called when the user chooses an image in the UIImagePickerController
// dismisses the UIImagePickerController



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    
    self.saveButton.enabled = YES;
    UIImage *selectedImage =info[UIImagePickerControllerEditedImage];
    if (!selectedImage) selectedImage = info[UIImagePickerControllerOriginalImage];
    if (selectedImage) {
        [self.selectedImage setIncrementalImage:selectedImage];
        [self.selectedImage setBufferedImage:selectedImage];
        _newMedia = YES;
    }
    if (self.imagePickerPopover) {
        [self.imagePickerPopover dismissPopoverAnimated:YES];
        self.imagePickerPopover = nil;
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(UIImage*) makeImage {
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    
    [self.selectedImage.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return viewImage;
}

- (IBAction)saveAlphaPhoto:(UIBarButtonItem *)sender
{
    if ((_newMedia) || (self.selectedImage.beginTouch))
    {
        UIImageWriteToSavedPhotosAlbum([self makeImage],
                                       self,
                                       @selector(image:didFinishSavingWithError:contextInfo:),
                                       nil);
        _newMedia = NO;
        self.selectedImage.beginTouch = NO;
    }
    
}


-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo
{
    NSString *alertTitle;
    NSString *alertMessage;
    
    if (!error)
    {
        alertTitle = @"Image Saved";
        alertMessage = @"Image saved to photo album successfully.";
    }
    else
    {
        alertTitle = @"Error";
        alertMessage = @"Unable to save to photo album.";
    }
    UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: alertTitle
                              message: alertMessage
                              delegate: nil
                              cancelButtonTitle:@"Okay"
                              otherButtonTitles:nil];
    [alert show];
}


- (void) deleteSubviews:(UIView *) view
{
    [[view subviews]
     makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.view setNeedsDisplay];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showInfo:self.infoButton];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flipInfo:)];
    tap.numberOfTapsRequired = 2; // Tap twice to flip Info
    [self.infoView addGestureRecognizer:tap];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
