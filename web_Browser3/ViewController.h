//
//  ViewController.h
//  web_Browser3
//
//  Created by Wu Ymow on 11/12/12.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "favoriteList.h"
#import <QuartzCore/CoreAnimation.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewController : UIViewController <DM_DELEGATE,UIAlertViewDelegate>
{
        favoriteList    *favorite;
    
    IBOutlet UITextField *webAddress;
    IBOutlet UIWebView *webView;
    
             NSString *website;
    NSMutableArray *addFavoriteArray, *addPageArray;
    
    IBOutlet UILabel        *pageNumberLabel;
    IBOutlet UIScrollView   *scrollView;
             UIPageControl  *pageControl;
    
             UIButton       *addPageBtn, *webCutVIewBtn;
    int pageNumber,pagecount;
    BOOL pageControlBeingUsed;
    
    
    id delegate;
}
@property (retain, nonatomic) IBOutlet UIView *pageingView;
@property (nonatomic,retain) favoriteList    *favorite;
@property (nonatomic,retain)  UITextField    *webAddress;
@property (nonatomic,retain)  UIWebView      *webView;
@property (nonatomic,retain)  NSString       *website;
@property (nonatomic,retain)  NSMutableArray *addFavoriteArray,*addPageArray;
@property (nonatomic,retain)  UITextField    *inputFavoriteAddress;
@property (nonatomic,retain)  UITextField    *inputFavoriteName;
@property (nonatomic,retain)  UIImage        *smallImage;
@property (nonatomic, retain) UILabel        *pageNumberLabel;
@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl* pageControl;
@property (nonatomic,retain)IBOutlet UIButton       *addPageBtn,*webCutVIewBtn;
@property (nonatomic,assign) int pagecount;
- (IBAction)changePage;
- (id)initWithPageNumber:(int)page;
- (IBAction)backButton:(id)sender;
- (IBAction)nextButton:(id)sender;
- (IBAction)refreshButton:(id)sender;
- (IBAction)homeButton:(id)sender;
- (IBAction)favorites:(id)sender;
- (IBAction)addMyFavorite:(id)sender;
- (IBAction)addWebPage:(id)sender;
- (IBAction)Window:(UIImage *)image;
- (IBAction)addPageView:(id)sender;
- (IBAction)tempBack:(id)sender;
- (IBAction)newWebBroswer:(id)sender;

@end
