//
//  InforView.m
//  AlphaPhotoNote
//
//  Created by Juan Ribes on 30/05/13.
//  Copyright (c) 2013 Juan Ribes. All rights reserved.
//

#import "InforView.h"

@interface InforView ()



@end

@implementation InforView


@synthesize infoLabel = _infoLabel;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self configure];
    }
    return self;
    
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configure];
    }
    return self;
}
-(void)configure
{
    [self setMultipleTouchEnabled:NO];
    
  //  NSString *title = @"Photo Annotation";
  //  NSString *infoString = [[[NSString alloc] init ]stringByAppendingString:title];
    NSString *infoString = NSLocalizedString(@"labelInfo", @"");
 //   [infoString stringByAppendingString: localizedString];
//    NSLog(@"Localized %@", localizedString);
    NSLog(@"infoString %@", infoString);
    
    NSMutableAttributedString *attString=[[NSMutableAttributedString alloc] initWithString:infoString];
    NSInteger _stringLength=[infoString length];
    
    UIColor *_red=[UIColor redColor];
    UIFont *font=[UIFont fontWithName:@"Helvetica-Bold" size:32.0f];
    [attString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, _stringLength)];
    [attString addAttribute:NSStrokeColorAttributeName value:_red range:NSMakeRange(0, _stringLength)];
    [attString addAttribute:NSStrokeWidthAttributeName value:[NSNumber numberWithFloat:3.0] range:NSMakeRange(0, _stringLength)];
    
    self.infoLabel.attributedText = attString;
    
}


@end
