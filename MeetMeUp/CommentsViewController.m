//
//  CommentsViewController.m
//  MeetMeUp
//
//  Created by ETC ComputerLand on 8/5/14.
//  Copyright (c) 2014 cmeats. All rights reserved.
//

#import "CommentsViewController.h"

@interface CommentsViewController ()
@property (strong, nonatomic) IBOutlet UILabel *memberName;
@property (strong, nonatomic) IBOutlet UILabel *timePosted;
@property (strong, nonatomic) IBOutlet UITextView *comment;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;

@end

@implementation CommentsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self doApi];
}

-(void)doApi
{

    [self.loadingIndicator startAnimating];

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.meetup.com/2/event_comments.json?event_id=%@&key=477d1928246a4e162252547b766d3c6d", self.meetUp[@"id"]]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *fullJsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.comments = [fullJsonDict objectForKey:@"results"];
        [self.loadingIndicator stopAnimating];
        [self loadComments];

    }];
}

-(void)loadComments
{
    for (int i = 0; i<self.comments.count; i++) {
        NSDictionary *comment = self.comments[i];
        // do first comment
        if (i == 0) {
            self.memberName.text = comment[@"member_name"];
            self.timePosted.text = @"Add time Posted";
            self.comment.text = comment[@"comment"];
        } else {
            
        }
        
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
