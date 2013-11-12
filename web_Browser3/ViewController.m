//
//  ViewController.m
//  web_Browser3
//
//  Created by Wu Ymow on 11/12/12.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "favoriteList.h"
#import <QuartzCore/CoreAnimation.h>
#import <QuartzCore/QuartzCore.h>

@implementation ViewController

int a = 1,b=0;
@synthesize webAddress;
@synthesize webView;
@synthesize website;
@synthesize pageingView;
@synthesize favorite;
@synthesize addFavoriteArray;
@synthesize inputFavoriteName;
@synthesize inputFavoriteAddress;
@synthesize smallImage;
@synthesize addPageArray;
@synthesize pageNumberLabel;
@synthesize scrollView, pageControl;
@synthesize addPageBtn,webCutVIewBtn;
@synthesize pagecount;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    pageControlBeingUsed = NO;
    webAddress.text = @"http://www.google.com.tw";
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webAddress.text]]];
    [self.pageingView setHidden:YES];
    
    //存圖陣列初始化
    NSMutableArray *array = [[NSMutableArray alloc]init];
    self.addPageArray = array;
    [array release];
    
//    UIGraphicsBeginImageContext(CGSizeMake(self.view.frame.size.width, self.view.frame.size.height));
//    [self.webView.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *HomeImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    //將圖檔紀錄加到儲存到 array
//    [addPageArray addObject:HomeImage];
   
    [self windowcontroller];
}

- (void)viewDidUnload
{
    [webAddress release];
    webAddress = nil;
    [webView release];
    webView = nil;
    website = nil;
    addFavoriteArray = nil;
    inputFavoriteName = nil;
    inputFavoriteAddress = nil;
    scrollView = nil;
    addPageBtn = nil;
    webCutVIewBtn = nil;
    [self setPageingView:nil];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];    
    [self.navigationController setNavigationBarHidden:YES];
    pageControlBeingUsed = NO;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)backButton:(id)sender {
    [webView goForward];
    
}

- (IBAction)nextButton:(id)sender {
    [webView goBack];
}

- (IBAction)refreshButton:(id)sender {
     [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webAddress.text]]];
}

- (IBAction)homeButton:(id)sender {
    
    [self.pageingView setHidden:YES];

    webAddress.text = @"http://www.google.com.tw";
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webAddress.text]]];
}

- (IBAction)favorites:(id)sender {
    //switch page方法
	favorite = [[favoriteList alloc] initWithNibName:@"favoriteList" bundle:nil];
    //指定 delegate... 
    favorite.delegate = self;
    //	[self.view addSubview:favorite.view];    
    [self.navigationController pushViewController:favorite animated:YES];
}

- (IBAction)addMyFavorite:(id)sender {

}

- (IBAction)addWebPage:(id)sender {
 
    //跳出我的最愛alertView
    UIAlertView *favoriteAlertView = [[UIAlertView alloc]initWithTitle:@"新增我的最愛" message:@"\n\n\n" delegate:self cancelButtonTitle:@"Confirm" otherButtonTitles:@"Cancel", nil];
    //新增我的最愛名稱與網址
    inputFavoriteName = [[UITextField alloc]initWithFrame:CGRectMake(12, 50, 260, 25)];
    [inputFavoriteName setPlaceholder:@"website name"]; 
    [inputFavoriteName setBackgroundColor:[UIColor whiteColor]];
    [favoriteAlertView addSubview:inputFavoriteName];
    inputFavoriteAddress = [[UITextField alloc]initWithFrame:CGRectMake(12, 80, 260, 25)];
    [inputFavoriteAddress setBackgroundColor:[UIColor whiteColor]];
     [favoriteAlertView addSubview:inputFavoriteAddress];
    //將網址丟到alertview
    inputFavoriteAddress.text = webAddress.text;
    //顯示alertview
    [favoriteAlertView show];

    [favoriteAlertView release]; 
}

-(void) alertView:(UIAlertView *) alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //存到自dictionary 再從另一個自定義類別乎叫出來 
    NSMutableDictionary *favoriteDictionary = [[NSMutableDictionary alloc]init];
    [favoriteDictionary setValue:inputFavoriteName.text forKey:inputFavoriteAddress.text];
    [favoriteList addFavor:favoriteDictionary];
    
    switch (buttonIndex) {
        case 0:
    //        [[NSNotificationCenter defaultCenter] postNotificationName:@"發送我的最愛" object:favoriteDictionary];    
            break;
    }
       
}
-(void)returnURL:(NSString *)urlString
{
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    webAddress.text = urlString;
}


-(void)windowcontroller
{
    pageControlBeingUsed = YES;
    NSLog(@"viewdidload_a=%d",a);
/*pageview背景＋顏色    
    for (int i = 0; i <a; i++) {
        CGRect frame;
        frame.origin.x = self.scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.scrollView.frame.size;
        
        UIView *subview = [[UIView alloc] initWithFrame:frame];
        
        switch (i) {
            case 0:
                subview.backgroundColor = [UIColor redColor];
                
                
                break;
            case 1:
                subview.backgroundColor = [UIColor greenColor];
                break;
            case 2:
                subview.backgroundColor = [UIColor blueColor];
                break;
                
            default:
                break;
        }
         [self.scrollView addSubview:subview];
             [subview release];

        */
        
        //[self.view addSubview:scrollView];
        scrollView.tag = 2;
        [self.view viewWithTag:2];

    
    
    //[self.pageingView setHidden:YES];
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * a, self.scrollView.frame.size.height);

	self.pageControl.numberOfPages = a;   
}

- (void)makeAButton:(NSString *)strURL
{
    //網頁連結按鈕
        UIButton *webCutVIew = [UIButton buttonWithType:UIButtonTypeRoundedRect];
     webCutVIew.alpha = 0.5;
    int currentcontrolpage =self.pageControl.currentPage;
    if(a==1){
        [webCutVIew setFrame:CGRectMake(60, 120, 200, 200)];
        
    }else if(a>1 && currentcontrolpage == a-2)
    {
    [webCutVIew setFrame:CGRectMake(60+(320*(a-1)), 120, 200, 200)];
    }else{
        [webCutVIew removeFromSuperview];
        [webCutVIew setFrame:CGRectMake(60+(320*currentcontrolpage), 120, 200, 200)];
    }

    [webCutVIew setTitle:strURL forState:UIControlStateNormal];
    [webCutVIew addTarget:self action:@selector(tempBack:) forControlEvents:UIControlEventTouchUpInside];
 //   [webCutVIew setBackgroundImage:[UIImage imageNamed:@"abc.jpeg"] forState:UIControlStateNormal];
    [scrollView addSubview:webCutVIew];

}

- (IBAction)Window:(UIImage *)image {
    //    UIWindow *minWindow = [[UIWindow alloc]init]; 
    //    [self.view removeFromSuperview];
    
  /*  //setFrame方法
    [UIView animateWithDuration:0.3 animations:^{
        [self.view setFrame:CGRectMake(12, 50, 260, 25)]; 
    }];*/

    
//   UIImage *img = [Utils resizeImage:orgImg size:CGSizeMake(120, 120)];
//    CGRect myImageRect = CGRectMake(0.0f, 0.0f, 320.0f, 109.0f);
//    UIImageView *myImage = [[UIImageView alloc] initWithFrame:myImageRect];
//    [myImage setImage:[UIImage imageNamed:@"myImage.png"]];
//    myImage.opaque = YES; // explicitly opaque for performance
//    // 將原始圖片縮成120x120，這一步視原始圖片大小而定，不一定要做
//    UIImage *newImg = [Utils resizeImage:orgImg size:CGSizeMake(120, 120)];
//    UIImage *maskImg = [UIImage imageNamed:@"mask.png"]; // 取得mask的圖片物件
//    newImg = [ImageUtils maskImage:newImg withMask:maskImg]; // 開始做裁切(Clip)圖片
//    [self.view addSubview:myImage];
//    
//  //  [myImage release];
//    
//    UIWindow *theScreen = [[UIApplication sharedApplication].windows objectAtIndex:0];
//    UIGraphicsBeginImageContext(theScreen.frame.size);
//    [[theScreen layer] renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
//    CGContextDrawImage(bitmap, CGRectMake(0, 0, 100,100);
   // [ViewController addAttachmentData:UIImagePNGRepresentation(screenshot)]; 
    //    UIGraphicsEndImageContext();
//    	[self sendImage:screenshot];
//  screenshot = [UIImage imageWithCGImage:UIGetScreenImage()];  
    
/*    //擷取全畫面
    UIImage *screenImage; 
    UIGraphicsBeginImageContext(self.view.frame.size); 
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()]; 
    screenImage = UIGraphicsGetImageFromCurrentImageContext(); 
    UIGraphicsEndImageContext();
    UIImageView *showimage = [[UIImageView alloc]initWithImage:screenImage];
    [showimage setFrame:CGRectMake(12, 23, 200, 200)];
    [self.view removeFromSuperview];
    [self.view addSubview:showimage];*/

 /*   
        //擷取局部畫面
     UIImage *screenImage; 
    
 //   CGSize size = CGSizeMake(640, 320);

     UIGraphicsBeginImageContext(self.view.frame.size); 
    
     [self.view.layer renderInContext:UIGraphicsGetCurrentContext()]; 
//    CGSize newSize = CGSizeMake(30.0f, 30.0f);
 //   [screenImage drawInRect:CGRectMake(0.0f, 0.0f, newSize.width, newSize.height)];
     screenImage = UIGraphicsGetImageFromCurrentImageContext(); 
     UIGraphicsEndImageContext();
     
    
    
     UIImageView *showimage = [[UIImageView alloc]initWithImage:screenImage];
     [showimage setFrame:CGRectMake(76, 120, 200, 200)];
    [UIImage imageWithCGImage:finalImage];
    [UIImage imageWithCGImage:CGImageCreateWithImageInRect(showimage, CGRectMake(0, 0, 320, 320))];
    
   /* 
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGRect ret=CGRectMake(0.0, 0.0, 180, 180);
    CGContextClipToRect(context, ret);
    //獲取裁剪區域
    
    CGRect boudsc=CGContextGetClipBoundingBox(context);
    
    int cleft = boudsc.origin.x;
    
    int ctop = boudsc.origin.y;
    
    int cwidth = boudsc.size.width;
    
 //   int cborder="1"height = boudsc.size.border="1" Height;
    
    //畫出裁剪區域
    
    CGContextDrawImage(context, boudsc, image);
    
    
//     [self.view removeFromSuperview];

 //   [imageview bringSubviewToFront:self.view];
    
//    CGRect myImageRect = CGRectMake(10.0, 10.0, 57.0, 57.0);
//    [addPageArray addObject:showimage];
//    CGImageRef newImage = CGImageCreateWithImageInRect(aux.CGImage, imageRect);
//    UIImage* subImage = [UIImage imageWithCGImage:subImageRef];
     [self.view addSubview:showimage];
  
      
    pageNumberLabel.text = [NSString stringWithFormat:@"Page %d", pageNumber + 1];
    
    
    //     UIImage *screenImage = [self ];*/

    int currentpagenum = self.pageControl.currentPage;
    NSLog(@"CURRENTPAGE%d",currentpagenum);
     if(a==1){
        
    }
    else if(currentpagenum == a-1)
    {
    [[scrollView viewWithTag:a+20]removeFromSuperview];
    }else
    {
        [[scrollView viewWithTag:currentpagenum+21]removeFromSuperview];

    }

        b++;
    UIView* view = [UIView new];
    view.tag = a + 20;
   // [self.view addSubview:view];
    UIGraphicsBeginImageContext(CGSizeMake(self.view.frame.size.width, self.view.frame.size.height));
    [self.webView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //     UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
    //將圖檔紀錄加到儲存到 array
    [addPageArray addObject:viewImage];
    
    UIImageView *showimage = [[UIImageView alloc]initWithImage:[addPageArray objectAtIndex:b-1]];
      showimage.alpha = 0.5;
    showimage.tag = 11;
    [showimage setFrame:CGRectMake(60+(320*currentpagenum), 120, 200, 200)];
    
    [view addSubview:showimage];
    [scrollView  addSubview:view];
    [self windowcontroller];
    [self.pageingView setHidden:NO];



        //  [view addSubview:showimage]; // 取得showimage

//    UIImageView* imgView = (UIImageView *)[[self.view viewWithTag:10] viewWithTag:11];

 //   [addPageBtn addTarget:self action:@selector(addPageView) forControlEvents:UIControlEventTouchUpInside];
    

  //  NSMutableDictionary *addPageDic = [[NSMutableDictionary alloc]initWithObjects:addPageArray forKeys:@"newPage1"];
    
//    移除VIEW方法二    
//    NSArray* ary = [self.view subviews];
//    
//    for (UIView* vieww in ary) 
//    {
//        [vieww removeFromSuperview];
//    }


    //網頁連結按鈕
    /*
    UIButton *webCurrentVIewBtn = [[UIButton alloc]initWithFrame:CGRectMake(60+(320*(a-1)), 120, 320, 200)];
    webCurrentVIewBtn.alpha = 1;
    [webCurrentVIewBtn setTitle:webAddress.text forState:UIControlStateNormal];
    NSLog(@"WEBSITE ADD TITLE%@",webAddress.text);
    [webCurrentVIewBtn addTarget:self action:@selector(tempBack:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:webCurrentVIewBtn];
     */
    
        [self makeAButton:webAddress.text];

        
}

//擷取局部webview畫面
- (UIImage *) screenImage:(UIView *)view rect:(CGRect)rect { 
    CGPoint pt = rect.origin; 
    UIImage *screenImage; 
    UIGraphicsBeginImageContext(rect.size); 
    CGContextRef context = UIGraphicsGetCurrentContext(); 
    CGContextConcatCTM(context, 
                       CGAffineTransformMakeTranslation(-(int)pt.x, -(int)pt.y)); 
    [view.layer renderInContext:context]; 
    screenImage = UIGraphicsGetImageFromCurrentImageContext(); 
    UIGraphicsEndImageContext(); 
    return screenImage; 
}

-(UIImage*)captureView:(UIView *)theView

{
    CGRect rect = theView.frame;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return img;
    
}

// mask the original image and return a new UIImage object
+ (UIImage*) maskImage:(UIImage*)image withMask:(UIImage*)mask {
	CGImageRef imgRef = [image CGImage];
	CGImageRef maskRef = [mask CGImage];
	CGImageRef actualMask = CGImageMaskCreate(CGImageGetWidth(maskRef),
											  CGImageGetHeight(maskRef),
											  CGImageGetBitsPerComponent(maskRef),
											  CGImageGetBitsPerPixel(maskRef),
											  CGImageGetBytesPerRow(maskRef),
											  CGImageGetDataProvider(maskRef), NULL, false);
	CGImageRef masked = CGImageCreateWithMask(imgRef, actualMask);
	return [UIImage imageWithCGImage:masked];
    
}


- (IBAction)changePage {
	// Update the scroll view to the appropriate page
    	CGRect frame;
	frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
	frame.origin.y = 0;
	frame.size = self.scrollView.frame.size;
	[self.scrollView scrollRectToVisible:frame animated:YES];
	
	// Keep track of when scrolls happen in response to the page control
	// value changing. If we don't do this, a noticeable "flashing" occurs
	// as the the scroll delegate will temporarily switch back the page
	// number.
	pageControlBeingUsed = YES;

}


- (IBAction)addPageView:(id)sender
{ 
    UIView* view = [UIView new];
    view.tag = a + 20;

      a= a+1;
      
    NSLog(@"a=%d",a);
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homepage1.png"]];
    [imageView  setFrame:CGRectMake(60+(320*(a-1)), 120, 200, 200)];
    [[scrollView viewWithTag:a+20] addSubview:imageView];
    [self windowcontroller];
   // self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * a, self.scrollView.frame.size.height);
    [scrollView setContentOffset:CGPointMake(320 *(a-1), 0) animated:YES];
    
    //UIImageView *showimageadd = [[UIImageView alloc]initWithImage:[addPageArray objectAtIndex:0]];
   
 //   [[[self.view viewWithTag:10] viewWithTag:11] removeFromSuperview];
  //  [self.pageingView addSubview:showimageadd];
    
    /*
    //網頁連結按鈕
    UIButton *webCutVIew = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    webCutVIew.alpha = 0.5;
    [webCutVIew setFrame:CGRectMake(60+(320*(a-1)), 120, 200, 200)];
    [webCutVIew setTitle:@"http://www.google.com.tw" forState:UIControlStateNormal];
    [webCutVIew addTarget:self action:@selector(addhomeButton:) forControlEvents:UIControlEventTouchUpInside];
//    [webCutVIewBtn setBackgroundImage:[UIImage imageNamed:@"abc.jpeg"] forState:UIControlStateNormal];
    [scrollView addSubview:webCutVIew];
*/
    
    [self makeAButton:@"http://www.google.com.tw"];
    self.pageControl.currentPage = a;

}

- (IBAction)tempBack:(id)sender {

    [self.pageingView setHidden:YES];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[sender currentTitle]]]];
    webAddress.text = [sender currentTitle];
}

- (IBAction)addhomeButton:(id)sender {
    
    [self.pageingView setHidden:YES];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[sender currentTitle]]]];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
	if (!pageControlBeingUsed) {
		// Switch the indicator when more than 50% of the previous/next page is visible

		CGFloat pageWidth = self.scrollView.frame.size.width;
		int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        NSLog(@"page %d",page);
		self.pageControl.currentPage = page+1;
        
        NSLog(@"page + 1 %d",self.pageControl.currentPage);
	}
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView 
{
	pageControlBeingUsed = NO;
}
- (void)updateCurrentPageDisplay:(UIScrollView *)scrollView 
{
    if (    pageControlBeingUsed) {


    int currentpagenum = self.pageControl.currentPage;
    NSLog(@"CURRENTPAGE%@",currentpagenum);
    }
}


- (void)dealloc {
    [webAddress release];
    [webView release];
    [favorite release];
    [addFavoriteArray release];
    [inputFavoriteName release];
    [inputFavoriteAddress release];
    [smallImage release];
    [addPageArray release];
    [scrollView release];
    [pageControl release];
    [addPageBtn release];
    [pageingView release];
    [webCutVIewBtn release];
    [super dealloc];
}

//保存圖片
/*NSData * data = UIImagePNGRepresentation(image);
 
 if ([UIImagePNGRepresentation(viewImage) writeToFile:path atomically:YES])
 {
 NSLog(@"Succeeded!");
 NSLog(@"%@",path);
 }
 else
 {
 NSLog(@"Failed!");
 }*/
@end
