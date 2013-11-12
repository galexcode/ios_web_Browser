//
//  favoriteList.h
//  web_Browser3
//
//  Created by Wu Ymow on 11/12/13.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

@protocol DM_DELEGATE <NSObject>

@required
-(void)returnURL:(NSString *)urlString;

@end

#import <UIKit/UIKit.h>

@interface favoriteList : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
 
    NSMutableArray *tableFavoriteName,*tableFavoriteAddress;
    id   delegate;
}
@property (nonatomic,retain) IBOutlet UITableView *table;
@property (nonatomic,retain) NSMutableArray *tableFavoriteName, *tableFavoriteAddress;
@property (nonatomic,retain) id delegate;
+(NSString *)addFavor:(NSDictionary *)favoriteDictionary;
-(NSString *) loadFile;
@end
