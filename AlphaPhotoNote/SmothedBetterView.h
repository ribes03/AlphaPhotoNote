//
//  SmothedBetterView.h
//  AlphaPhotoNote
//
//  Created by Juan Ribes on 22/05/13.
//  Copyright (c) 2013 Juan Ribes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SmothedBetterView : UIImageView

@property (nonatomic,weak) UIColor* colorPen;
@property (nonatomic,strong) UIImage *incrementalImage;
@property (nonatomic,strong) UIImage *bufferedImage;
@property BOOL shouldClean,beginTouch;

-(void) trash;
-(void) replaceImage;


@end
