//
//  ViewController.m
//  DevKitUI
//
//  Created by sddz_yuxiaohua on 15/10/14.
//
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self addAlertButton];
    [self addAnimationImageView];
}

- (void)addAlertButton
{
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 80, 60, 20)];
    [btn setBackgroundColor:[UIColor lightGrayColor]];
    [btn setTitle:@"Alert" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    [btn showAlert];
}

- (void)btnAction:(UIButton *)sender
{
    [sender setAlertBackgroundTintColor:[UIColor colorWithRed:((1.0 * (random()%255))/255)
                                                        green:((1.0 * (random()%255))/255)
                                                         blue:((1.0 * (random()%255))/255)
                                                        alpha:1]];
    if (random()%3 == 0) {
        [sender hideAlert];
    }
    else if (random()%3 == 1) {
        [sender showAlert];
    }
    else {
        [sender showAlertWithCount:(random()%99)];
    }
}

- (void)addAnimationImageView
{
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 80, 16, 16)];
    [self.view addSubview:imageView];
    
    // pattern: SyncPrompt%2d.png
    [imageView animateWithPattern:@"SyncPrompt%02d" frames:35];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [imageView stopAnimating];
    });
}

@end
