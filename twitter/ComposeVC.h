//
//  ComposeVC.h
//  twitter
//
//  Created by Madhukar Mulpuri on 1/24/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComposeVC : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *userNameCLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameCLabel;
@property (weak, nonatomic) IBOutlet UIImageView *curUserImage;
@property (weak, nonatomic) IBOutlet UITextField *tweetTextWidget;
@property (weak, nonatomic) IBOutlet UILabel *charactersRemainingLabel;
@property (nonatomic, strong) Tweet *tweet;
@end
