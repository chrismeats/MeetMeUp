//
//  WebViewController.m
//  MeetMeUp
//
//  Created by ETC ComputerLand on 8/4/14.
//  Copyright (c) 2014 cmeats. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *eventWebView;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIButton *forwardButton;

@end

@implementation WebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.eventWebView loadRequest:request];
    self.eventWebView.delegate = self;

    self.navigationController.navigationBar.topItem.title = @"";
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    if ([self.eventWebView canGoBack]) {
        [self enableButton:self.backButton];
    } else {
        [self disableButton:self.backButton];
    }

    if([self.eventWebView canGoForward]) {
        [self enableButton:self.forwardButton];
    } else {
        [self disableButton:self.forwardButton];
    }
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

-(void)disableButton: (UIButton *)button
{
    button.enabled = NO;
    button.alpha = .5;
}

-(void)enableButton: (UIButton *)button
{
    button.enabled = YES;
    button.alpha = 1;
}

- (IBAction)onBackButtonPressed:(UIButton *)sender {
    [self.eventWebView goBack];
}

- (IBAction)onForwardButtonPressed:(UIButton *)sender {
    [self.eventWebView goForward];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
