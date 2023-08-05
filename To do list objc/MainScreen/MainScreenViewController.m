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
bool isOpen = false;
CGFloat screenWidth;

AddNoteAnimateView *addNoteView;

- (void)viewDidLoad {
    [super viewDidLoad];
    screenWidth = [UIScreen mainScreen].bounds.size.width;
    _presenter = [[MainScreenPresenter alloc] init];
    [_presenter initWithView:self];
    
    [self _setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    isOpen = false;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC),
                   dispatch_get_main_queue(), ^{
        isOpen = true;
        
        [self->_collectionView performBatchUpdates:^{
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self->_collectionView.numberOfSections)];
            [self->_collectionView reloadSections:indexSet];
        } completion:nil];
    });
}

- (void)viewWillDisappear:(BOOL)animated {
    
    isOpen = false;
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
    
    addNoteView = [[AddNoteAnimateView alloc] initWithFrame:CGRectMake(screenWidth - 110, 60, 100, 40)
                                                   delegate:self];
    
    UIWindowScene *windowScene = (UIWindowScene *)[UIApplication sharedApplication].connectedScenes.allObjects.firstObject;
    UIWindow *window = windowScene.windows.firstObject;
    [window addSubview:addNoteView];

    [self.view addSubview:_collectionView];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    [self->_presenter addNote: addNoteView.getText];
    [addNoteView setupUIСreatureNotActivate];
    
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow: [_presenter getNotesData].count - 1
                                                   inSection:0];
    
    [self.collectionView performBatchUpdates:^{
        [self.collectionView insertItemsAtIndexPaths:@[newIndexPath]];
    } completion:nil];
    activePlusButton = true;
    return YES;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    if (isOpen) {
        return [_presenter getNotesData].count;
    }
    else {
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: reuseIdentifier
                                                                 forIndexPath:indexPath];
    NoteModel *noteData = _presenter.getNotesData[indexPath.row];
    
    [cell setupNote:noteData.title noteText:noteData.noteText];
    
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
    
    UIViewController *vc = [[InDetailCollectionViewController alloc] init];
    [self.navigationController pushViewController:vc animated: true];
}

@end
