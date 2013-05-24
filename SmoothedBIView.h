#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface SmoothedBIView : UIImageView
@property (nonatomic,weak) UIColor* colorPen;
@property (nonatomic,strong) UIImage *incrementalImage;
@property (nonatomic,strong) UIImage *bufferedImage;
@property BOOL shouldClean,beginTouch;

-(void) trash;
-(void) replaceImage;
@end
