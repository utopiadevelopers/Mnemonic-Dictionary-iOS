//
//  DownloadViewController.m
//  Gre Cards
//
//  Created by Satyam Krishna on 27/07/14.
//

#import "DownloadViewController.h"
#import "MainHeaderView.h"

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createViews];
    [self setupNavigationBar];
    [self askPermission];
}

- (void)createViews
{
    [self.view setBackgroundColor:UIColorFromRGB(UTOPIA_GREY)];
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

- (void) setupNavigationBar
{
    MainHeaderView *headerView = [[MainHeaderView alloc] initMainHeaderWithParent:self WithTitle:@"Download" backButtonRequired:NO];
    [[self navigationItem] setTitleView:headerView];
}


- (void)startDownload
{
    [self.progressBar setHidden:NO];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:JSON_URL_TEST] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60.0];
    self.connectionManager = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    [self.connectionManager start];
}

- (void)askPermission
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Attention" message:@"The next process is going to download the word list.This is a one time process.However the download is around 8MB.So it will cost you a siginificant charge if you don't have a data pack.So you can close the application and come later when you have internt or you can choose no which will log you out." delegate:nil cancelButtonTitle:cancelTitle otherButtonTitles:otherTitle,nil];
    
    [alert show];
    [alert setDelegate:self];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString* title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:cancelTitle])
    {
        [CommonFunction logOutUser];
        [self presentViewController:[CommonFunction getLoginViewController] animated:YES completion:^{
            
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
    [[DBManager sharedDBManager] startTransaction];
    for (NSMutableDictionary *wordJSON in dic)
    {
        WordObject *obj = [[WordObject alloc] init];
        
        [obj setWordID:[wordJSON objectForKey:@"wordID"]];
        [obj setWord:[wordJSON objectForKey:@"word"]];
        [obj setDefinition_short:[wordJSON objectForKey:@"definition_short"]];
        [obj setMnemonics_arr:[wordJSON objectForKey:@"mnemonics_arr"]];
        
        NSMutableArray *defObj = [[NSMutableArray alloc] init];
        
        for (NSMutableDictionary *defJSON in [wordJSON objectForKey:@"defintion_arr"])
        {
            DefinitionObject *temp = [[DefinitionObject alloc] init];
            
            [temp setDef:[defJSON objectForKey:@"def"]];
            [temp setSent:[defJSON objectForKey:@"sent"]];
            [temp setSyn:[defJSON objectForKey:@"syn"]];
            
            [defObj addObject:temp];
        }
        
        [obj setDefintion_arr:defObj];
        [[DBManager sharedDBManager] addWord:obj];
    }
    [[DBManager sharedDBManager] commitTransaction];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IS_JSON_DOWNLOADED];
    [self presentViewController:[CommonFunction getDashboardViewController] animated:YES completion:^{
        
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
