//
//  PopToLastLevelVC.m
//  滑动返回上一级
//
//  Created by apple on 15/11/9.
//  Copyright © 2015年 cheniue. All rights reserved.
//

#import "PopToLastLevelVC.h"

@interface PopToLastLevelVC ()
{
    UIPanGestureRecognizer *rightGesture;
}
@end

@implementation PopToLastLevelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.navigationController!=nil&&self.navigationController.viewControllers.firstObject!=self)
    {
        [self addPanGesture];
    }
}
-(void)addPanGesture
{
    rightGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panToRight:)];
    [self.view addGestureRecognizer:rightGesture];
}
+(UIImage*)imageFromView:(UIView*)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
-(void)panToRight:(UIPanGestureRecognizer*)gesture
{
    if (gesture==rightGesture)
    {
        if (self.navigationController!=nil&&self.navigationController.viewControllers.firstObject!=self)
        {
            if (gesture.state==UIGestureRecognizerStateBegan)
            {
                if (self.navigationController.viewControllers.count>1)
                {
                    [self.navigationController.view setBackgroundColor:[UIColor colorWithPatternImage:[PopToLastLevelVC imageFromView:[[self.navigationController.viewControllers objectAtIndex:(self.navigationController.viewControllers.count-2)] view]]]];
                }
            }
            CGPoint point = [gesture translationInView:self.view];
            if (point.x>=0)
            {
                [self.view setFrame:CGRectMake(point.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
            }
            if (gesture.state==UIGestureRecognizerStateFailed||gesture.state==UIGestureRecognizerStateCancelled)
            {
                [self.view setFrame:CGRectMake(0, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
                [self.navigationController.view setBackgroundColor:[UIColor whiteColor]];
            }
            if (gesture.state==UIGestureRecognizerStateEnded)
            {
                if (point.x>(self.view.frame.size.width/2.0f))
                {
                    [UIView animateWithDuration:0.5f animations:^{
                        [self.view setFrame:CGRectMake(self.view.frame.size.width, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
                    } completion:^(BOOL finished) {
                        
                        [self.navigationController popViewControllerAnimated:NO];
                        [self.navigationController.view setBackgroundColor:[UIColor whiteColor]];
                    }];
                }
                else
                {
                    [UIView animateWithDuration:0.5f animations:^{
                        [self.view setFrame:CGRectMake(0, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
                    } completion:^(BOOL finished) {
                        [self.navigationController.view setBackgroundColor:[UIColor whiteColor]];
                    }];
                }
            }
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
