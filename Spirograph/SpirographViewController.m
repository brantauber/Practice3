//
//  SpirographViewController.m
//  Spirograph
//
//  Created by Michael Toth on 2/20/14.
//  Copyright (c) 2014 Michael Toth. All rights reserved.
//

#import "SpirographViewController.h"
#import "SpirographView.h"
#import "HarmonigraphView.h"

@interface SpirographViewController ()
@property SpirographView *sView;
@property HarmonigraphView *hView;
@end

@implementation SpirographViewController

@synthesize sView;
@synthesize hView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIDevice *device = [UIDevice currentDevice];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:device];
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:device];
    
	// Do any additional setup after loading the view, typically from a nib.
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 20, 280, 280)];
    scrollView.pagingEnabled = YES;
    hView = [[HarmonigraphView alloc] initWithFrame:CGRectMake(0, 0, 280, 280)];
    hView.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:hView];
    sView = [[SpirographView alloc] initWithFrame:CGRectMake(280, 0, 280, 280)];
    sView.backgroundColor = [UIColor yellowColor];
    [scrollView addSubview:sView];
    scrollView.contentSize = CGSizeMake(560, 280);
    [self.view addSubview:scrollView];
}

- (IBAction)redraw:(id)sender {
    sView.k = self.kSlider.value;
    sView.l = self.lSlider.value;
    sView.stepSize = [self.stepSizeText.text floatValue];
    sView.numberOfSteps = [self.numStepsText.text integerValue];
    [sView setNeedsDisplay];
    [hView setNeedsDisplay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keyboardWillShow:(NSNotification *) note {
    CGSize keyboardSize = [[[note userInfo] objectForKey: UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect newFrame = self.view.frame;
    newFrame.origin.y -= keyboardSize.height;
    self.view.frame = newFrame;
}

- (void)keyboardWillHide:(NSNotification *) note {
    CGSize keyboardSize = [[[note userInfo] objectForKey: UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGRect newFrame = self.view.frame;
    newFrame.origin.y += keyboardSize.height;
    self.view.frame = newFrame;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.stepSizeText resignFirstResponder];
    [self.numStepsText resignFirstResponder];
}

@end
