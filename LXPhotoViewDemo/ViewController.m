//
//  ViewController.m
//  LXPhotoViewDemo
//
//  Created by xxf on 2017/4/27.
//  Copyright © 2017年 suokeer. All rights reserved.
//

#import "ViewController.h"

#import "LXUploadPhotoView.h"

#import "TZImagePickerController.h"


#import "UIView+LXFrame.h"

#define kLXSCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define kLXSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define kLXWeakSelf(weakSelf) __weak __typeof(&*self) weakSelf = self

#define kMaxCount 8

@interface ViewController () <TZImagePickerControllerDelegate>{
    
    __weak IBOutlet UIView *photoBgView;
    
    LXUploadPhotoView *photoView;
    NSMutableArray *selectedImages; /**< 选择了的图片 */
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewLayoutConstraint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    selectedImages = [[NSMutableArray alloc]init];
    
    [self setupPhotoView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)setupPhotoView {
    
    CGFloat itemSpacing = 10;
    CGFloat lineSpacing = 10;
    NSInteger numberOfRow = 3;
    NSInteger maxRows = 3;
    NSInteger maxCount = kMaxCount;
    CGFloat topMargin = 10;
    CGFloat bottomMargin = 10;
    CGFloat leftMargin = 10;
    CGFloat rightMargin = 10;
    
    CGFloat width = (kLXSCREEN_WIDTH - itemSpacing * (numberOfRow - 1) - 20 - leftMargin - rightMargin)/numberOfRow;
    
    LXUploadPhotoViewFlowLayout *layout = [[LXUploadPhotoViewFlowLayout alloc]init];
    layout.lx_maxRows = maxRows;
    layout.lx_numberOfRow = numberOfRow;
    layout.lx_maxCount = maxCount;
    layout.lx_needDrag = NO;
    layout.lx_addImageName = @"添加图片";
    layout.itemSize = CGSizeMake(width, width);
    layout.minimumInteritemSpacing = itemSpacing;
    layout.minimumLineSpacing = lineSpacing;
    layout.sectionInset = UIEdgeInsetsMake(topMargin, leftMargin, bottomMargin, rightMargin);
    layout.lx_photoCellDeleteButtonImageName = @"delete_publsh_btn";
    
    photoView = [[LXUploadPhotoView alloc]initWithFrame:CGRectMake(0, 0, kLXSCREEN_WIDTH - 20, 0) layout:layout];
    photoView.backgroundColor = [UIColor clearColor];
    [photoBgView addSubview:photoView];
    
    [self resetFrame];
    
    kLXWeakSelf(weakSelf);
    photoView.lx_didTouchedAdd = ^() {
        [weakSelf photoViewDidTouchedSelectedImage];
    };
    
    photoView.lx_didSelectedWithIndex = ^(NSInteger index) {
        
    };
    
    __weak NSMutableArray *weakArray = selectedImages;
    photoView.lx_deleteSelectedWithIndex = ^(NSInteger index) {
        [weakArray removeObjectAtIndex:index];
        
        [weakSelf resetFrame];
    };
    
}

- (void)resetFrame {
    
    CGFloat photoHeight = photoView.lx_height;
    self.bgViewLayoutConstraint.constant = photoHeight;
}


#pragma mark - photo  add image
- (void)photoViewDidTouchedSelectedImage {
    
    NSInteger maxImageCount = kMaxCount - photoView.lx_origindImages.count;
    
    TZImagePickerController *picker = [[TZImagePickerController alloc]initWithMaxImagesCount:maxImageCount delegate:self];
    [self presentViewController:picker animated:YES completion:^{
        
    }];
}

#pragma mark - TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    
    [selectedImages addObjectsFromArray:photos];
    
    photoView.lx_origindImages = selectedImages;
    
    [self resetFrame];
}

- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
