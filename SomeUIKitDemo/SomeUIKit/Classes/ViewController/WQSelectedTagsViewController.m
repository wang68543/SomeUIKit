//
//  WQSelectedTagsViewController.m
//  SomeUIKit
//
//  Created by WangQiang on 2016/11/24.
//  Copyright © 2016年 WangQiang. All rights reserved.
//

#import "WQSelectedTagsViewController.h"
#import "WQTagsFlowLayout.h"
#import "WQTagCollectionViewCell.h"
@interface WQSelectedTagsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,WQTagsFlowLayoutDelegate>

@property (strong ,nonatomic) UICollectionView *collectionView;
@property (strong ,nonatomic) NSMutableArray *testTags;

@end

@implementation WQSelectedTagsViewController
-(UICollectionView *)collectionView{
    if(!_collectionView){
        WQTagsFlowLayout *flowLayout = [[WQTagsFlowLayout alloc] init];
        flowLayout.rowHeight = 45.0;
    
        flowLayout.delegate = self;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView ;
}
static NSString *const identifier = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([WQTagCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:identifier];
    _testTags = [@[@"篮球",
                                  @"足球",
                                  @"羽毛球",
                                  @"乒乓球",
                                  @"排球",
                                  @"网球",
                                  @"高尔夫球",
                                  @"冰球",
                                  @"沙滩排球",
                                  @"棒球",
                                  @"垒球",
                                  @"藤球",
                                  @"毽球",
                                  @"台球",
                                  @"鞠蹴",
                                  @"板球",
                                  @"壁球",
                                  @"沙壶",
                                  @"克郎球",
                                  @"橄榄球",
                                  @"曲棍球",
                                  @"水球",
                                  @"马球",
                                  @"保龄球",
                                  @"健身球",
                                  @"门球",
                                  @"弹球",
                                  ]mutableCopy];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _testTags.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WQTagCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.tagLabel.text = _testTags[indexPath.row];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark -- WQTagsFlowLayoutDelegate
-(CGFloat)tagsFlowLayout:(WQTagsFlowLayout *)flowLayout widthAtIndex:(NSIndexPath *)indePath targetLine:(NSInteger)targetLine lineRemindWidth:(CGFloat)remindWidth{
    return [_testTags[indePath.row] sizeWithAttributes:@{NSFontAttributeName : MYFont(17.0)}].width + 58.0;
}
-(LineAlignment)tagsFlowLayout:(WQTagsFlowLayout *)flowLayout lineContentAliment:(NSInteger)line lastLine:(BOOL)isLast{
    if(isLast){
        return LineAlignmentFill;
    }
    if(line == 0){
        return LineAlignmentLeft;
    }else if(line == 1){
        return LineAlignmentRight;
    }else if(line == 2){
        return LineAlignmentFill;
    }else{
        return LineAlignmentCenter;
    }
    
}
-(CGFloat)tagsFlowLayout:(WQTagsFlowLayout *)flowLayout lineHeightAtLine:(NSInteger)line lastLine:(BOOL)isLast{
    if(line == 1){
        return 80;
    }else if(line == 2){
        return 180;
    }else{
        return 45;
    }
}
@end
