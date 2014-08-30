//
//  DownloadViewController.m
//  Gre Cards
//
//  Created by Satyam Krishna on 27/07/14.
//  Copyright (c) 2014 Zomato. All rights reserved.
//

#import "DownloadViewController.h"

@interface DownloadViewController ()

@property NSString* cancelTitle;
@property NSString*  otherTitle;

@end

@implementation DownloadViewController

@synthesize progressBar;
@synthesize cancelTitle;
@synthesize otherTitle;
@synthesize connectionManager;
@synthesize downloadedMutableData;
@synthesize urlResponse;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createViews];
    [self askPermission];
}

- (void)startDownload
{
    [self.progressBar setHidden:NO];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:JSON_URL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60.0];
    self.connectionManager = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    [self.connectionManager start];
}

- (void)askPermission
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Attention" message:@"The next process is going to download the word list.This is a one time process.However the download is around 8MB.So it will cost you a siginificant charge if you don't have a data pack.So you can close the application and come later when you have internt or you can choose no which will log you out." delegate:nil cancelButtonTitle:cancelTitle otherButtonTitles:otherTitle,nil];
    
    [alert show];
    [alert setDelegate:self];
}

- (void)createViews
{
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    //Title
    UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(2*SIDE_PADDING,50, W(self.view), 50)];
    [title setText:@"Downloading Data"];
    //ProgressBar
    self.progressBar = [[UIProgressView alloc] initWithFrame:CGRectMake(2*SIDE_PADDING,BOTTOM(title)+SIDE_PADDING,W(self.view)-4*SIDE_PADDING,30)];
    [self.progressBar setHidden:YES];
    
    [self.view addSubview:title];
    [self.view addSubview:progressBar];
    
    //Setting up Basic Parameters
    cancelTitle = [NSString stringWithFormat:@"No"];
    otherTitle  = [NSString stringWithFormat:@"Yes"];
    self.downloadedMutableData = [[NSMutableData alloc] init];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString* title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:cancelTitle])
    {
        [CommonFunction logOutUser];
        LoginViewController *viewController = [[LoginViewController alloc] init];
        [self presentViewController:viewController animated:YES completion:^{
            
        }];
    }
    else if([title isEqualToString:otherTitle])
    {
        [self startDownload];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -NSURLConnectionDataDelegate

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"%lld", response.expectedContentLength);
    self.urlResponse = response;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.downloadedMutableData appendData:data];
    [self.progressBar setProgress:((100.0/self.urlResponse.expectedContentLength)*self.downloadedMutableData.length)/100 animated:NO];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSArray *dic = [NSJSONSerialization JSONObjectWithData:self.downloadedMutableData options:NSJSONReadingMutableLeaves error:nil];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IS_JSON_DOWNLOADED];
    DashboardViewController *viewController = [[DashboardViewController alloc] init];
    [self presentViewController:viewController animated:YES completion:^{
        
    }];
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
