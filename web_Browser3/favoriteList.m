//
//  favoriteList.m
//  web_Browser3
//
//  Created by Wu Ymow on 11/12/13.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "favoriteList.h"

@implementation favoriteList


@synthesize table;
@synthesize tableFavoriteName,tableFavoriteAddress;
@synthesize delegate;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)dealloc
{

    [table release];
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"我的最愛";
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self loadFile];
    [table reloadData];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.tableFavoriteAddress count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    NSUInteger row = [indexPath  row];
    cell.textLabel.text = [tableFavoriteName objectAtIndex:row];
    cell.detailTextLabel.text = [tableFavoriteAddress objectAtIndex:row];     
    return cell;
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    NSInteger row = [indexPath row];
   //[delegate returnURL:@"http://www.mobile01.com"];
     [delegate returnURL:[tableFavoriteAddress objectAtIndex:row]];
    NSLog(@"row%@",tableFavoriteAddress);
     [self.navigationController popToRootViewControllerAnimated:YES];    

}

+(NSString *)filePathwithFileName:(NSString *)filename
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [path objectAtIndex:0];
    NSLog(@"Path%@",path);
    NSString *testFile = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",filename]];
    return testFile;
}

+(NSString *)addFavor:(NSDictionary *)favoriteDictionary
{
    NSString *testFile = [favoriteList filePathwithFileName:@"text.txt"];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:testFile];
    if(fileExists)
    {
        NSLog(@"FileExists");
        NSMutableDictionary *oldDict = [NSMutableDictionary dictionaryWithContentsOfFile:testFile];
        [oldDict addEntriesFromDictionary:favoriteDictionary];
        [oldDict writeToFile:testFile atomically:YES];
        NSLog(@"oldDict %@",oldDict);
    }
    else{
        NSLog(@"Create File = %@",testFile);
        [favoriteDictionary writeToFile: testFile atomically:YES];
    }
    return testFile;
}

-(NSString *)loadFile
{
    
    NSString* str = [favoriteList filePathwithFileName:@"text.txt"];
    NSLog(@"str%@",str);
    NSDictionary *loadFav = [NSDictionary dictionaryWithContentsOfFile:str];
    
    NSMutableArray* loadkeyArray = [NSMutableArray array];
    
    NSArray* keys2 = [loadFav allKeys];
    for (NSString* key in keys2) 
    {
        [loadkeyArray addObject:[loadFav objectForKey:key]];
    }
    
    self.tableFavoriteAddress = (NSMutableArray *)keys2;
    self.tableFavoriteName = loadkeyArray ;
    //    self.FavName = [loadkeyArray objectAtIndex:0];
    //    self.FavArray = [loadkeyArray objectAtIndex:1];
    NSLog(@"tableFavoriteName %@",tableFavoriteName);
    NSLog(@"tableFavoriteAddress %@",tableFavoriteAddress);
    
}

@end
