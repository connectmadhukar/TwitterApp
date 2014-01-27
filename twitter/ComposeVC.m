//
//  ComposeVC.m
//  twitter
//
//  Created by Madhukar Mulpuri on 1/24/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "ComposeVC.h"
#import "TwitterClient.h"
#import "User.h"

@interface ComposeVC ()

@end

@implementation ComposeVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onTweetButton)];
    //self.navigationItem.title = @"140";
    User *curUser = [User currentUser];
    NSLog(@"Current User: %@", curUser);
    self.userNameCLabel.text = curUser.name;
    [self.userNameCLabel sizeToFit];
    self.screenNameCLabel.text =  [@"@" stringByAppendingString:curUser.screenName];
    [self.screenNameCLabel sizeToFit];
    self.tweetTextWidget.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:curUser.profileImageUrl];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *imageData, NSError *connectionError) {
        //NSLog(@"Image fetch done");
        [self.curUserImage setImage:[UIImage imageWithData:imageData]];
    }];
    if( self.tweet == nil) {
        NSLog(@" Not in Reply mode");
    } else {
        self.tweetTextWidget.text = [@"@" stringByAppendingString:self.tweet.screenName];
        self.charactersRemainingLabel.text = [NSString stringWithFormat:@"%d", (140 - self.tweetTextWidget.text.length)];
    }
}

- (void)onTweetButton {
    NSLog(@"onTweet");
    //TODO: Tweet
    TwitterClient *twitterClient = [TwitterClient instance];
    if( self.tweet == nil) {
        [twitterClient addTweet:self.tweetTextWidget.text success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"%@", response);
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Do nothing
    }];
    } else {
        [twitterClient replyTweet:self.tweetTextWidget.text tweetId:self.tweet.tweetID success:^(AFHTTPRequestOperation *operation, id response) {
            NSLog(@"%@", response);
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            // Do nothing
        }];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //NSLog(@" textViewDidChange: %d", textField.text.length);
    NSString *resultString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if( resultString.length > 140 ) {
        return NO;
    }
    self.charactersRemainingLabel.text = [NSString stringWithFormat:@"%d", (140 - resultString.length)];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
