//
//  DownloadViewController.h
//  Gre Cards
//
//  Created by Satyam Krishna on 27/07/14.
//

#import <UIKit/UIKit.h>
#import "DashboardViewController.h"
#import "WordObject.h"

@interface DownloadViewController : UIViewController<UIAlertViewDelegate,NSURLConnectionDataDelegate>

@property (nonatomic,strong) UIProgressView* progressBar;
@property (strong, nonatomic) NSURLConnection *connectionManager;
@property (strong, nonatomic) NSMutableData *downloadedMutableData;
@property (strong, nonatomic) NSURLResponse *urlResponse;

@end
