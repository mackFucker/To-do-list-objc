//
//  ViewController.m
//  To do list objc
//
//  Created by дэвид Кихтенко on 31.07.2023.
//

#import "MainScreenViewController.h"

@implementation MainScreenViewController

static NSString * const reuseIdentifier = @"cellIdentifier";
bool activePlusButton = true;

AddNoteAnimateView *addNoteView;
CGFloat screenWidth;

UIWindowScene *windowScene;
UIWindow *window;

- (void)viewDidLoad {
    [super viewDidLoad];
    windowScene = (UIWindowScene *)[UIApplication sharedApplication].connectedScenes.allObjects.firstObject;
    window = windowScene.windows.firstObject;
    
    screenWidth = [UIScreen mainScreen].bounds.size.width;
    _presenter = [[MainScreenPresenter alloc] initWithView:self];
    
    [self _setupUI];
    [_presenter setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        [_presenter receivingFromPersistenStore];
    });
    
    [window addSubview:addNoteView];
    //    [_collectionView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [addNoteView removeFromSuperview];
}

- (void)_setupUI {
    
    self.title = @"Notes";
    
    UICollectionViewFlowLayout *layout = UICollectionViewFlowLayout.new;
    _collectionView = [[UICollectionView alloc] initWithFrame: self.view.frame
                                         collectionViewLayout: layout];
    
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    
    [_collectionView registerClass:[CustomCell class] forCellWithReuseIdentifier: reuseIdentifier];
    [_collectionView setBackgroundColor:[UIColor systemBackgroundColor]];
    
    addNoteView = [[AddNoteAnimateView alloc] initWithFrame:CGRectMake(screenWidth - 110, 45, 100, 40)
                                                   delegate:self];
    
    [window addSubview:addNoteView];
    
    
    [self.view addSubview:_collectionView];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    NSNumber *noteID = [NSNumber numberWithUnsignedInteger:[_presenter getNotesData].count + 1];
    [_presenter addNote: noteID title:addNoteView.getText];
    
    [addNoteView setupUIСreatureNotActivate];
    
    //    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow: [_presenter getNotesData].count - 1
    //                                                   inSection:0];
    
    //        [self.collectionView performBatchUpdates:^{
    //            [self.collectionView insertItemsAtIndexPaths:@[newIndexPath]];
    //        } completion:nil];
    activePlusButton = true;
    return YES;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    
    return [_presenter getNotesData].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: reuseIdentifier
                                                                 forIndexPath:indexPath];
    
    NoteModel *noteData = [_presenter getNote:@(indexPath.row)];
    [cell setupNote:noteData];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
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
    
    NoteModel *data = [_presenter getNote:@(indexPath.row)];
    UIViewController *vc = [[InDetailCollectionViewController alloc] initWithNoteData: data];
    [self.navigationController pushViewController:vc animated: true];
}

- (void)notify:(NSNumber*)index type:(TypeofChanges)type {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow: index.intValue
                                                inSection:0];
    switch (type) {
        case TypeofChangesDelete:
            [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
            break;
        case TypeofChangesAdd:
            [self.collectionView insertItemsAtIndexPaths:@[indexPath]];
            break;
        case TypeofChangesEdit:
            [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
            break;
        case TypeofChangesToggle:
            [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
            break;
    }
}

@end
