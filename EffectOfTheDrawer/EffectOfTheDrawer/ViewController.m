//
//  ViewController.m
//  EffectOfTheDrawer
//
//  Created by  江苏 on 16/4/20.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "ViewController.h"
#import <CoreGraphics/CoreGraphics.h>
@interface ViewController ()
@property(nonatomic,strong)UIView* mainView;

@property(strong,nonatomic)UIView* blueView;

@property(strong,nonatomic)UIView* greenView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setView];
    
    UIPanGestureRecognizer* pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    
    [self.view addGestureRecognizer:pan];
    
    //KVO
    [self.mainView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew  context:nil];
    
}

//KVO方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if (self.mainView.frame.origin.x<0) {
        self.greenView.hidden=YES;
    }else{
        self.greenView.hidden=NO;
    }
    
}


- (void)pan:(UIPanGestureRecognizer *)pan{
    
    CGPoint transP = [pan translationInView:self.view];
    
    CGFloat offsetX=transP.x;
    
    self.mainView.frame=CGRectMake(self.mainView.frame.origin.x+offsetX, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [pan setTranslation:CGPointZero inView:self.view];
    
    
}


-(void)setView{
    
    
    UIView* blueView=[[UIView alloc]initWithFrame:self.view.bounds];
    blueView.backgroundColor=[UIColor blueColor];
    [self.view addSubview:blueView];
    self.blueView=blueView;
    
    UIView* greenView=[[UIView alloc]initWithFrame:self.view.bounds];
    greenView.backgroundColor=[UIColor greenColor];
    [self.view addSubview:greenView];
    self.greenView=greenView;
    
    UIView* redView=[[UIView alloc]initWithFrame:self.view.bounds];
    redView.backgroundColor=[UIColor redColor];
    [self.view addSubview:redView];
    self.mainView=redView;
    
}

@end
