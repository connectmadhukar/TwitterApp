//
//  TimelineVC.m
//  twitter
//
//  Created by Timothy Lee on 8/4/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "TimelineVC.h"
#import "TweetCell.h"
#import "TweetDetailedVC.h"
#import "ComposeVC.h"

@interface TimelineVC ()

@property (nonatomic, strong) NSMutableArray *tweets;

- (void)onSignOutButton;
- (void)reload;

@end

@implementation TimelineVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Twitter";
        
        [self reload];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.navigationController.navigationBar.barTintColor = [UIColor cyanColor];
    UIImage *image = [UIImage imageNamed: @"bird_blue_32.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: image];
    
    self.navigationItem.titleView = imageView;
    
    image = [UIImage imageNamed: @"composeSmall.png"];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(onSignOutButton)];
    //self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image  style:UIBarButtonItemStylePlain target:self action:@selector(onComposeButton)] ;
    //self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    //Register The Custom TweetCell
    UINib *toDoCustomCellNib = [UINib nibWithNibName:@"TweetCell" bundle:nil];
    [self.tableView registerNib:toDoCustomCellNib forCellReuseIdentifier:@"TweetCell"];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"cellForRowAtIndexPath");
    static NSString *CellIdentifier = @"TweetCell";
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    Tweet *tweet = self.tweets[indexPath.row];
    cell.tweetText.text = tweet.text;
    [cell.tweetText sizeToFit];
    cell.twittersName.text = tweet.name;
    [cell.twittersName sizeToFit];
    cell.tweeterScreenNameLabel.text = [@"@" stringByAppendingString:tweet.screenName];
    [cell.tweeterScreenNameLabel sizeToFit];
    
    
    //Time of tweet
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EEE MMM dd HH:mm:ss +zzzz yyyy"];
    
    NSDate *tweetDate = [dateFormat dateFromString:tweet.tweetTime];
    NSDate *NowDate = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar
            components:NSSecondCalendarUnit
                                               fromDate:tweetDate
                                                 toDate:NowDate
                                                options:0];
    NSLog(@"tweetDate: %@ components:%@", tweetDate,components);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:tweet.profileImageUrl];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *imageData, NSError *connectionError) {
        //NSLog(@"Image fetch done");
      [cell.profileImageView setImage:[UIImage imageWithData:imageData]];
    }];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   // NSLog(@"heightForRowAtIndexPath");
    Tweet *tweet = self.tweets[indexPath.row];
    //UITableViewCell *tvc = [tableView cellForRowAtIndexPath:indexPath];
    float width = 200.0f;
    if(UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
        width = 200.0f;
    } else if(UIInterfaceOrientationIsLandscape(self.interfaceOrientation)){
        width = 300.0f;
    }

    CGRect frame = [tweet.text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f]} context:nil];
    float height = frame.size.height;

    float diffHeight = ((34.0 + height) - 64.0);
    diffHeight = ( diffHeight > 0)?diffHeight:0;
    float calHeight = 67.0 + diffHeight;
    NSLog(@"heightForRowAtIndexPath \n %@ \n %f \n %f" , tweet.text, height, calHeight);
    return calHeight;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"didSelectRowAtIndexPath");
    TweetDetailedVC *tweetDetailedVC = [[TweetDetailedVC alloc] init];
    tweetDetailedVC.tweet = self.tweets[indexPath.row];
    [self.navigationController pushViewController:tweetDetailedVC animated:YES];
}

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

#pragma mark - Private methods

- (void)onSignOutButton {
    [User setCurrentUser:nil];
}

- (void)onComposeButton{
    NSLog(@"onComposeButton");
    //[self.navigationController presentViewController:[[ComposeVC alloc] init] animated:YES completion:nil];
    [self.navigationController pushViewController:[[ComposeVC alloc] init] animated:YES];
    /*
    UIViewController *viewController = [[ComposeVC alloc] initWithNibName:@"ComposeVC" bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self presentViewController:navController animated:YES completion:nil];
     */
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"- (void)viewWillAppear:(BOOL)animated;");
    [self reload];
}

- (void)reload {
    [[TwitterClient instance] homeTimelineWithCount:20 sinceId:0 maxId:0 success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"%@", response);
        self.tweets = [Tweet tweetsWithArray:response];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Do nothing
    }];
}

@end
