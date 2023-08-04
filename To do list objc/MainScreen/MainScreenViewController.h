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
#import "CustomTextField.h"

@protocol MainScreenPresenterDelegate;
@interface MainScreenViewController : UIViewController<UICollectionViewDataSource,
                                                        UICollectionViewDelegateFlowLayout,
                                                        UITextFieldDelegate,
                                                        MainScreenViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property MainScreenPresenter* presenter;

@end
