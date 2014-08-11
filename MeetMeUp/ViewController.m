//
//  ViewController.m
//  MeetMeUp
//
//  Created by ETC ComputerLand on 8/4/14.
//  Copyright (c) 2014 cmeats. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "UIImageView+WebCache.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITextField *searchTextField;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.searchTextField.delegate = self;

    [self doApi:@"mobile"];

}

-(void)doApi: (NSString *)searchTerm
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.meetup.com/2/open_events.json?zip=60604&text=%@&time=,1w&key=477d1928246a4e162252547b766d3c6d", searchTerm]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        NSDictionary *fullJsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.meetUps = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil][@"results"];

        [self.tableView reloadData];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.meetUps.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *meetUp = self.meetUps[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    cell.textLabel.text = meetUp[@"name"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@ %@", meetUp[@"venue"][@"address_1"], meetUp[@"venue"][@"city"], meetUp[@"venue"][@"state"]];

    //cell.imageView setImageWithURL:[NSURL URLWithString:<#(NSString *)#>]

    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *dvc = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    dvc.meetUp = self.meetUps[indexPath.row];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self doApi:textField.text];
    [textField resignFirstResponder];
    return YES;
}


@end
