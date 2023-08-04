//
//  ViewController.m
//  To do list objc
//
//  Created by дэвид Кихтенко on 31.07.2023.
//

#import "MainScreenViewController.h"

@implementation MainScreenViewController

static NSString * const reuseIdentifier = @"cellIdentifier";
//UIButton *_addNoteButton;
bool activePlusButton = true;
bool isOpen = false;

CustomTextField *textFieldNoteName;

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
//    _addNoteButton = UIButton.new;
//    _addNoteButton.tintColor = UIColor.systemBlueColor;
    
    UIImage *btnImage = [UIImage systemImageNamed: @"plus"];
//    [_addNoteButton setImage: btnImage forState:UIControlStateNormal];
//    [_addNoteButton addTarget:self action:@selector(addNote) forControlEvents: UIControlEventTouchUpInside];
//    
    UIBarButtonItem *addNoteButtonBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: _addNoteButton];
    self.navigationItem.rightBarButtonItem = addNoteButtonBarButtonItem;
    
    [self.view addSubview:_collectionView];
}

//-(void)addNote {
//    if (activePlusButton) {
        
//    -----------------------запуск анимации -----------------------
//        activePlusButton = false;
//        
//        textFieldNoteName = [[CustomTextField alloc] initWithFrame:CGRectMake(0, 0, 200, 30) delegate:self];
//        
//        [self.view addSubview:textFieldNoteName];
//    }
//    else {
//        NSLog(@"%@", @"non active");
//    }
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    NSLog(@"%@", textFieldNoteName.noteName.text);
    [self->_presenter addNote: textFieldNoteName.getText];
    
    [textFieldNoteName removeFromSuperview];
    
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
