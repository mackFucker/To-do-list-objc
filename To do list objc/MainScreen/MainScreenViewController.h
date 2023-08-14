//
//  ViewController.h
//  To do list objc
//
//  Created by дэвид Кихтенко on 31.07.2023.
//

#import <UIKit/UIKit.h>
#import "CustomCell.h"
#import <Foundation/Foundation.h>
#import "NoteModel.h"
#import "MainScreenPresenter.h"

#import "InDetailCollectionViewController.h"
#import "MainScreenPresenter.h"
#import "AddNoteAnimateView.h"

@interface MainScreenViewController : UIViewController<UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
MainScreenViewDelegate,
NotifyAboutChanges,
UITextFieldDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property MainScreenPresenter* presenter;

@end
