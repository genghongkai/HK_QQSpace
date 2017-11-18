//
//  ViewController.m
//  QQHomePage
//
//  Created by ghk on 2017/11/8.
//  Copyright © 2017年 geng hongkai. All rights reserved.
//

#import "ViewController.h"

static CGFloat ratio = 0.8;

@interface ViewController ()
<UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) NSArray *dataArray;
/** <##>*/
@property (nonatomic, strong) UIImageView *bgView;

/** <##> */
@property (nonatomic,) CGRect originImageFrame;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _bgView = [[UIImageView alloc] init];
    CGFloat bgWidth = self.view.frame.size.width;
    _bgView.frame = CGRectMake(0.f, 0.f, self.view.frame.size.width, ratio* bgWidth);
    _bgView.image = [UIImage imageNamed:@"carnival_2017_11_11"];
    [self.view addSubview:_bgView];
    _originImageFrame = _bgView.frame;
    
    [self loadUI];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)loadUI
{
    //创建表格视图
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _bgView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-_bgView.frame.size.height) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    CGFloat offSetY = scrollView.contentOffset.y;
    
    //往下滑动，改变图片大小
    if (offSetY < 0) {
        
        _bgView.frame = ({
            
            CGRect frame = _originImageFrame;
            frame.size.height = _originImageFrame.size.height - offSetY;
            frame.size.width = frame.size.height/ratio;
            frame.origin.x = _originImageFrame.origin.x - (frame.size.width-_originImageFrame.size.width)/2;
            frame;
        });
        
    } else  {
        //往上滑动，改变图片y
        _bgView.frame = ({
            
            CGRect frame = _originImageFrame;
            frame.origin.y = _originImageFrame.origin.y - offSetY;
            frame;
        });
    }
}

#pragma mark - Lazy Methods
- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[@"进度条",@"进度条",@"二维码",@"进度条",@"进度条",@"进度条",@"进度条"];
    }
    return _dataArray;
}




@end
