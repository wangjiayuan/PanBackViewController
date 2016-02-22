//
//  ViewController.m
//  滑动返回上一级
//
//  Created by apple on 15/11/9.
//  Copyright © 2015年 cheniue. All rights reserved.
//

#import "ViewController.h"
#import "PopToLastLevelVC.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)testBegin:(id)sender
{
    [self test1];
}
///右滑导航回退
-(void)test1
{
    NSMutableArray *array = [NSMutableArray array];
    NSArray *titles = @[@"页面一",@"页面二",@"页面三",@"页面四",@"页面五",@"页面六",@"页面七",@"页面八",@"页面九",@"页面十"];
    for (NSInteger i=0; i<10; i++)
    {
        PopToLastLevelVC *vc = [[PopToLastLevelVC alloc]init];
        [vc setTitle:titles[i]];
        [array addObject:vc];
    }
    UINavigationController *navVC = [[UINavigationController alloc]init];
    [navVC setViewControllers:array];
    [self presentViewController:navVC animated:YES completion:^(){
        for (NSInteger i=0; i<10; i++)
        {
            PopToLastLevelVC *vc = [array objectAtIndex:i];
            [vc.view setBackgroundColor:[UIColor colorWithRed:(arc4random()%255)/255.0f green:(arc4random()%255)/255.0f blue:(arc4random()%255)/255.0f alpha:1.0f]];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
