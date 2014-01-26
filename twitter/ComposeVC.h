//
//  ComposeVC.h
//  twitter
//
//  Created by Madhukar Mulpuri on 1/24/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComposeVC : UIViewController<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *userNameCLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameCLabel;
@property (weak, nonatomic) IBOutlet UIImageView *curUserImage;
@property (weak, nonatomic) IBOutlet UITextView *tweetTextWidget;

@end
