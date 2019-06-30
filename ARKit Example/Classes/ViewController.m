//
//  ViewController.m
//  ARKit Example
//
//
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()
@property (nonatomic) CLLocationDegrees lat1;
@property (nonatomic) CLLocationDegrees lat2;
@property (nonatomic) CLLocationDegrees lat3;
@property (nonatomic) CLLocationDegrees lat4;
@property (nonatomic) CLLocationDegrees lat5;
@property (nonatomic) CLLocationDegrees lat6;
@property (nonatomic) CLLocationDegrees lat7;

@property (nonatomic) CLLocationDegrees lon1;
@property (nonatomic) CLLocationDegrees lon2;
@property (nonatomic) CLLocationDegrees lon3;
@property (nonatomic) CLLocationDegrees lon4;
@property (nonatomic) CLLocationDegrees lon5;
@property (nonatomic) CLLocationDegrees lon6;
@property (nonatomic) CLLocationDegrees lon7;
@property (nonatomic, strong) NSArray *titleArray;
@end

@implementation ViewController

- (void) viewDidLoad {
    selectedIndex = -1;
    
    
    self.lat1=40.986502;
    self.lat2=40.912345;
    self.lat3=40.227391;
    self.lat4=40.337470;
    self.lat5=40.447392;
    
    self.lon1=28.872137;
    self.lon2=28.812345;
    self.lon3=28.621983;
    self.lon4=28.232468;
    self.lon5=28.542470;
    
    self.titleArray = [[NSArray alloc] initWithObjects:@"Etçi Mehmet",@"Dilek Restaurant", @"Taksim Hamburger", @"İstikbal Mobilya", @"Kamil Koç", nil];
    
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:self.lat1 longitude:self.lon1];
    ARGeoCoordinate *etci = [ARGeoCoordinate coordinateWithLocation:location];
    etci.dataObject = _titleArray[0];
    etci.numText = @"etci.jpg";
    
    CLLocation *location2 = [[CLLocation alloc] initWithLatitude:self.lat2 longitude:self.lon2];
    ARGeoCoordinate *dilek = [ARGeoCoordinate coordinateWithLocation:location2];
    dilek.dataObject = _titleArray[1];
    dilek.numText = @"dilek.jpg";
    
    location = [[CLLocation alloc] initWithLatitude:self.lat3 longitude:self.lon3];
    ARGeoCoordinate *taksim = [ARGeoCoordinate coordinateWithLocation:location];
    taksim.dataObject = _titleArray[2];
    taksim.numText = @"taksim.jpg";
    
    location = [[CLLocation alloc] initWithLatitude:self.lat4 longitude:self.lon4];
    ARGeoCoordinate *istikbal = [ARGeoCoordinate coordinateWithLocation:location];
    istikbal.dataObject = _titleArray[3];
    istikbal.numText = @"istikbal.jpg";
    
    location = [[CLLocation alloc] initWithLatitude:self.lat5 longitude:self.lon5];
    ARGeoCoordinate *koc = [ARGeoCoordinate coordinateWithLocation:location];
    koc.dataObject = _titleArray[4];
    koc.numText = @"koc.jpg";
    
    
    points = @[etci, dilek, taksim, istikbal, koc];
    
    
}

- (IBAction)showAR:(id)sender {
    ARKitConfig *config = [ARKitConfig defaultConfigFor:self];
    config.orientation = self.interfaceOrientation;
    
    CGSize s = [UIScreen mainScreen].bounds.size;
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
        config.radarPoint = CGPointMake(s.width - 50, s.height - 50);
    } else {
        config.radarPoint = CGPointMake(s.height - 50, s.width - 50);
    }
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [closeBtn sizeToFit];
    [closeBtn addTarget:self action:@selector(closeAr) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.center = CGPointMake(20, 20);
    
    engine = [[ARKitEngine alloc] initWithConfig:config];
    [engine addCoordinates:points];
    [engine addExtraView:closeBtn];
    [engine startListening];
}

- (void) closeAr {
    [engine hide];
}

#pragma mark - ARViewDelegate protocol Methods

- (ARObjectView *)viewForCoordinate:(ARGeoCoordinate *)coordinate floorLooking:(BOOL)floorLooking {
    NSString *text = (NSString *)coordinate.dataObject;
    
    ARObjectView *view = nil;
    
    if (floorLooking) {
        UIImage *arrowImg = [UIImage imageNamed:@"arrow.png"];
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:arrowImg];
        view = [[ARObjectView alloc] initWithFrame:arrowView.bounds];
        [view addSubview:arrowView];
        view.displayed = NO;
    } else {
        UIImageView *boxView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"taslak.png"]];
        boxView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(4, 13, boxView.frame.size.width - 8, 25)];
        lbl.font = [UIFont systemFontOfSize:12];
        lbl.minimumFontSize = 2;
        lbl.backgroundColor = [UIColor clearColor];
        lbl.textColor = [UIColor darkGrayColor];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.text = text;
        lbl.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        view = [[ARObjectView alloc] initWithFrame:boxView.frame];
        [view addSubview:boxView];
        [view addSubview:lbl];
        
        
        UILabel *lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(4, 30, boxView.frame.size.width - 8, 20)];
        lbl2.font = [UIFont systemFontOfSize:10];
        lbl2.minimumFontSize = 2;
        lbl2.backgroundColor = [UIColor clearColor];
        lbl2.textColor = [UIColor grayColor];
        lbl2.textAlignment = NSTextAlignmentCenter;
        lbl2.text = @"2 kampanya var!";
        lbl2.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        [view addSubview:lbl2];
        
        UIImageView *detailView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:coordinate.numText]];
        detailView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        CGRect rect = detailView.frame;
        rect.origin.x = 25;
        rect.origin.y = 55;
        rect.size.height = 70;
        rect.size.width = 70;
        detailView.frame = rect;
        detailView.alpha = 0.8;
        [view addSubview:detailView];
        
        view.alpha = 0.8;
        
    }
    
    [view sizeToFit];
    return view;
}

- (void) itemTouchedWithIndex:(NSInteger)index {
    selectedIndex = index;
    NSString *name = (NSString *)[engine dataObjectWithIndex:index];
    currentDetailView = [[NSBundle mainBundle] loadNibNamed:@"DetailView" owner:nil options:nil][0];
    currentDetailView.nameLbl.text = name;
    
    ARGeoCoordinate *cor = [engine coordinateWithIndex:index];
    currentDetailView.detailImg.image = [UIImage imageNamed:cor.numText];
    
    [engine addExtraView:currentDetailView];
}

- (void) didChangeLooking:(BOOL)floorLooking {
    if (floorLooking) {
        if (selectedIndex != -1) {
            [currentDetailView removeFromSuperview];
            ARObjectView *floorView = [engine floorViewWithIndex:selectedIndex];
            floorView.displayed = YES;
        }
    } else {
        if (selectedIndex != -1) {
            ARObjectView *floorView = [engine floorViewWithIndex:selectedIndex];
            floorView.displayed = NO;
            selectedIndex = -1;
        }
    }
}

@end
