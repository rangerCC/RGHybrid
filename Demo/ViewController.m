//
//  ViewController.m
//  Demo
//
//  Created by TingtingYan on 2018/2/24.
//  Copyright © 2018年 ranger. All rights reserved.
//

#import "ViewController.h"
#import "RGDemoWebController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Demo";
    
    self.datas = @[
                   @{@"title":@"RGWebView Demo",@"class":@"RGDemoWebController"},
                   @{@"title":@"Origin UIWebView Demo",@"class":@"RGDemoUIWebViewController"},
                   @{@"title":@"origin WKWebView Demo",@"class":@"RGDemoWKWebViwController"}
                   ];
    
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row>self.datas.count)
        return nil;
    
    static NSString *CellIdentifier;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *info = self.datas[indexPath.row];
    cell.textLabel.text = info[@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    if (row >= 0 && row < self.datas.count) {
        Class cls = NSClassFromString(self.datas[row]);
        if (cls && [cls isKindOfClass:[UIViewController class]]) {
            UIViewController *vc = [cls new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark - Lazy loads
- (UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.dataSource = (id)self;
        tableView.delegate = (id)self;
        _tableView = tableView;
    }
    return _tableView;
}
@end
