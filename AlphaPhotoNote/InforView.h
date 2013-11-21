//
//  InforView.h
//  AlphaPhotoNote
//
//  Created by Juan Ribes on 30/05/13.
//  Copyright (c) 2013 Juan Ribes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InforView : UIView
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
- (void) configure;
@end
