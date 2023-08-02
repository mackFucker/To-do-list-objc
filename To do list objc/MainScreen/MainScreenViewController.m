//
//  ViewController.m
//  To do list objc
//
//  Created by дэвид Кихтенко on 31.07.2023.
//

#import "MainScreenViewController.h"
#import "InDetailCollectionViewController.h"

@implementation MainScreenViewController

static NSString * const reuseIdentifier = @"cellIdentifier";
UIButton *_addNoteButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _setupUI];
}

- (void)_setupUI {
    
    self.title = @"Notes";
        
    UICollectionViewFlowLayout *layout = UICollectionViewFlowLayout.new;
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame
                                         collectionViewLayout:layout];
    
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    
    [_collectionView registerClass:[CustomCell class] forCellWithReuseIdentifier: reuseIdentifier];
    [_collectionView setBackgroundColor:[UIColor systemBackgroundColor]];
    
    _addNoteButton = UIButton.new;
    _addNoteButton.tintColor = UIColor.systemBlueColor;
    UIImage *btnImage = [UIImage systemImageNamed:@"plus"];
    [_addNoteButton setImage: btnImage forState:UIControlStateNormal];
    [_addNoteButton addTarget:self action:@selector(addNote) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *addNoteButtonBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: _addNoteButton];
    self.navigationItem.rightBarButtonItem = addNoteButtonBarButtonItem;
    
    [self.view addSubview:_collectionView];
}

-(void)addNote {
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: reuseIdentifier
                                                                 forIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    return CGSizeMake(screenWidth / 2.3, screenWidth / 2.7);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    
    CGFloat spacing = [UIScreen mainScreen].bounds.size.width / 20;
    UIEdgeInsets edgeInsetsMake = UIEdgeInsetsMake(spacing, spacing, spacing, spacing);
    
    return edgeInsetsMake;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UIViewController *vc = [[InDetailCollectionViewController alloc] init];
    [self.navigationController pushViewController:vc animated: true];
}

@end
