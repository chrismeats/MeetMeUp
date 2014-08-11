//
//  DetailViewController.m
//  MeetMeUp
//
//  Created by ETC ComputerLand on 8/4/14.
//  Copyright (c) 2014 cmeats. All rights reserved.
//

#import "DetailViewController.h"
#import "WebViewController.h"
#import "CommentsViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) IBOutlet UILabel *rsvpLabel;
@property (strong, nonatomic) IBOutlet UILabel *groupNameLabel;
@property (strong, nonatomic) IBOutlet UIWebView *descriptionWebView;

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.rsvpLabel.text = [NSString stringWithFormat:@"%@", self.meetUp[@"yes_rsvp_count"]];
    self.groupNameLabel.text = self.meetUp[@"group"][@"name"];
    [self.descriptionWebView loadHTMLString:self.meetUp[@"description"] baseURL:nil];
    self.title = self.meetUp[@"name"];

    self.navigationController.navigationBar.topItem.title = @"";
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"webView"]) {
        WebViewController *dvc = segue.destinationViewController;
        dvc.urlString = self.meetUp[@"event_url"];
    } else if ([segue.identifier isEqualToString:@"comments"]) {
        CommentsViewController *dvc = segue.destinationViewController;
        dvc.meetUp = self.meetUp;
    }
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
