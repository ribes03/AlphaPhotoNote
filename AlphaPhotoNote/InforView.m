//
//  InforView.m
//  AlphaPhotoNote
//
//  Created by Juan Ribes on 30/05/13.
//  Copyright (c) 2013 Juan Ribes. All rights reserved.
//

#import "InforView.h"

@interface InforView ()

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation InforView


@synthesize infoLabel = _infoLabel;

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
    
    NSString *infoString=@"This is an example of Attributed String";
    
    NSMutableAttributedString *attString=[[NSMutableAttributedString alloc] initWithString:infoString];
    NSInteger _stringLength=[infoString length];
    
    UIColor *_red=[UIColor redColor];
    UIFont *font=[UIFont fontWithName:@"Helvetica-Bold" size:72.0f];
    [attString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, _stringLength)];
    [attString addAttribute:NSStrokeColorAttributeName value:_red range:NSMakeRange(0, _stringLength)];
    [attString addAttribute:NSStrokeWidthAttributeName value:[NSNumber numberWithFloat:3.0] range:NSMakeRange(0, _stringLength)];
    
    [self.infoLabel setAttributedText:attString];
    [self addSubview:self.infoLabel];
}










/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
