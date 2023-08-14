//
//  IndetailViewControllerCollectionViewController.m
//  To do list objc
//
//  Created by дэвид Кихтенко on 01.08.2023.
//

#import "InDetailCollectionViewController.h"
#import "ImportanceCellImpl.h"

@implementation InDetailCollectionViewController

static NSString * const reuseIdentifier = @"Cell";
static NSString * const reuseIdentifier2 = @"Cell2";

bool _isOpen = false;

UIButton *_doneButton;
NoteModel *_data;

InDetaileNoteTextCellImpl *noteTextCell;

- (instancetype)initWithNoteData:(NoteModel *)data {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _data = data;
        _presenter = [[InDetailPresenter alloc] initWithView:self];
        self.title = data.title;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tapGesture];
    
    [self _setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC),
                   dispatch_get_main_queue(), ^{
        _isOpen = true;
        
        [self->_collectionView performBatchUpdates:^{
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self->_collectionView.numberOfSections)];
            [self->_collectionView reloadSections:indexSet];
        } completion:nil];
    });
}

- (void)viewWillDisappear:(BOOL)animated {
    
    _isOpen = false;
}

-(void)_setupUI {
    
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame
                                         collectionViewLayout:layout];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    
    [_collectionView registerClass:[InDetaileNoteTextCellImpl class] forCellWithReuseIdentifier: reuseIdentifier];
    [_collectionView registerClass:[ImportanceCellImpl class] forCellWithReuseIdentifier: reuseIdentifier2];
    
    [_collectionView setBackgroundColor:[UIColor systemBackgroundColor]];
    [self.view addSubview:_collectionView];
    
    _doneButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [_doneButton setTitle:@"Done" forState: UIControlStateNormal];
    [_doneButton setTitleColor:[UIColor systemBlueColor] forState:UIControlStateNormal];
    [_doneButton addTarget:self action:@selector(doneButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *doneBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_doneButton];
    self.navigationItem.rightBarButtonItem = doneBarButtonItem;
}

- (void)doneButtonTapped {
    [UIView animateWithDuration:0.2 animations:^{
        [_doneButton setAlpha:0.0];
    } completion:^(BOOL finished) {
        if (finished) {
            NoteModel *note = [[NoteModel alloc] initWithNoteID: _data.noteID
                                                          title:@"(nonnull NSString *)"
                                                           text:[noteTextCell returnNoteText]];
            
            
            [self->_presenter editNote: note];
            [self.view endEditing:YES];
            [self hideKeyboard];
        }
    }];
}

- (void)hideKeyboard {
    [self.view endEditing:YES];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    
    if(_isOpen) {
        switch(section) {
            case 0:
                return 1;
            case 1:
                return 1;
            default:
                return 0;
        }
    }
    else {
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = nil;
    
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    noteTextCell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                     forIndexPath:indexPath];
                    [noteTextCell setup:_data];
                    cell = noteTextCell;
                    break;
            }
            break;
            
        case 1:
            switch (indexPath.row) {
                case 0:
                    cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier2
                                                                     forIndexPath:indexPath];
                    break;
            }
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat screenWidth  = [UIScreen mainScreen].bounds.size.width;
    CGSize size = CGSizeMake(screenWidth / 2.3, screenWidth / 2.7);
    
    switch (indexPath.section) {
        case (0):
            switch (indexPath.row) {
                case 0:
                    size = CGSizeMake(screenWidth / 1.1, screenWidth / 2.7);
                    break;
            }
            break;
            
        case (1):
            switch (indexPath.row) {
                case 0:
                    size = CGSizeMake(screenWidth / 1.1, screenWidth / 10);
                    break;
                default:
                    size = CGSizeMake(screenWidth / 1.1, screenWidth / 2);
                    break;
            }
            break;
    }
    
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    
    CGFloat spacing = [UIScreen mainScreen].bounds.size.width / 20;
    UIEdgeInsets edgeInsetsMake = UIEdgeInsetsMake(spacing, spacing, spacing, spacing);
    
    return edgeInsetsMake;
}

@end
