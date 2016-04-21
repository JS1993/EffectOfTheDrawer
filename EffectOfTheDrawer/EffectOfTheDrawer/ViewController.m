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
    
    UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
}

-(void)tap{
    [UIView animateWithDuration:0.25 animations:^{
        self.mainView.frame=self.view.bounds;
    }];
}

//KVO方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if (self.mainView.frame.origin.x<0) {
        self.greenView.hidden=YES;
    }else{
        self.greenView.hidden=NO;
    }
    
}
#define screenW [UIScreen mainScreen].bounds.size.width
#define TargetR 275
#define TargetL  -220
- (void)pan:(UIPanGestureRecognizer *)pan{
    
    CGPoint transP = [pan translationInView:self.view];
    //获取偏移量
    CGFloat offsetX=transP.x;
    
    self.mainView.frame=[self getFrameFromOffset:offsetX];
    
    //复位
    [pan setTranslation:CGPointZero inView:self.view];
    
    
    if (pan.state==UIGestureRecognizerStateEnded) {
        CGFloat target=0;
        if (CGRectGetMaxX(self.mainView.frame)<screenW*0.5) {
            target=TargetL;
        }else if (self.mainView.frame.origin.x>screenW*0.5){
            target=TargetR;
        }
        CGFloat offSetX=target-self.mainView.frame.origin.x;
        
        [UIView animateWithDuration:0.25 animations:^{
            self.mainView.frame=target==0?self.view.bounds:[self getFrameFromOffset:offSetX];
        }];
    }
}

-(CGRect)getFrameFromOffset:(CGFloat)offectX{
    //取得先前的frame
    CGRect frame=self.mainView.frame;
    CGFloat preHight=frame.size.height;
    CGFloat preWidth=frame.size.width;
    
    //计算Y的偏移量
    CGFloat offsetY=offectX*80/screenW;
    
    //算出现在的宽高
    CGFloat nowHight;
    if (frame.origin.x<0) {
       nowHight=preHight+offsetY*2;
    }else{
       nowHight=preHight-offsetY*2;
    }
    //获得形变缩放比例
    CGFloat k=nowHight/preHight;
    
    CGFloat nowWidth=preWidth*k;
    
    CGFloat nowX=frame.origin.x+offectX;
    CGFloat nowY=([UIScreen mainScreen].bounds.size.height-nowHight)/2;
    
    CGRect nowFrame=CGRectMake(nowX, nowY, nowWidth ,nowHight);
    
    return nowFrame;
    
}
/**
 *  创建view
 */
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
