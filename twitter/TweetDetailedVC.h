//
//  TweetDetailedVC.h
//  twitter
//
//  Created by Madhukar Mulpuri on 1/22/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetDetailedVC : UIViewController

    @property (weak, nonatomic) IBOutlet UILabel *userNameDVLabel;
    @property (weak, nonatomic) IBOutlet UIImageView *profileDVImageView;

    @property (weak, nonatomic) IBOutlet UILabel *screenNameDVLabel;
    @property (weak, nonatomic) IBOutlet UILabel *tweetDVLabel;
    @property (weak, nonatomic) IBOutlet UILabel *tweetTimeDVLabel;
    @property (weak, nonatomic) IBOutlet UILabel *retweetCountDVLabel;
    @property (weak, nonatomic) IBOutlet UILabel *favCountDVLabel;
    @property (weak, nonatomic) IBOutlet UIButton *retweetDVButton;
    @property (weak, nonatomic) IBOutlet UIButton *favouritedDVButton;
    @property (nonatomic) NSInteger favorited;
    @property (nonatomic) NSInteger retweeted;
    @property (nonatomic, strong) Tweet *tweet;

@end
