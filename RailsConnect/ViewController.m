//
//  ViewController.m
//  RailsConnect
//
//  Created by Katlyn Schwaebe on 9/4/14.
//  Copyright (c) 2014 Katlyn Schwaebe. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@end

@implementation ViewController
{
    UITableView * contacts;
    NSMutableArray * stuff;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
//    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //self.blah.delegate = self;
    
    stuff = [@[] mutableCopy];
    
    contacts = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    contacts.backgroundColor = [UIColor magentaColor];
    contacts.rowHeight = 100;
    contacts.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    contacts.delegate = self;
    contacts.dataSource = self;
    
    [self.view addSubview:contacts];
    
    NSString* urlString =[NSString stringWithFormat:@"http://damp-savannah-6124.herokuapp.com/"];
    NSURL* url = [NSURL URLWithString:urlString];
   // NSURLRequest* request = [NSURLRequest requestWithURL:url];
    NSData * coinData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://damp-savannah-6124.herokuapp.com/"]];
    
    _contactList = [NSJSONSerialization JSONObjectWithData:coinData options:NSJSONReadingMutableContainers error:nil];
    
//    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
//    operation.responseSerializer = [AFJSONResponseSerializer serializer];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        //    NSLog(@"%@", responseObject);
//        
//    } failure:nil];
    
//    [operation start];
    
    NSLog(@"%@", [_contactList class]);
    
    for (NSDictionary* dict in _contactList)
    {
        NSLog(@"%@", dict);
    }
    
    stuff = _contactList;
    
    [contacts reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return stuff.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
 
     if (cell == nil) {
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
     }
     
     NSDictionary* currentInfo = stuff[indexPath.row];
    
    
    cell.textLabel.text = currentInfo[@"first_name"];
   // cell.textLabel.text = currentInfo[@"last_name"];
     
 
 return cell;
 }

@end
