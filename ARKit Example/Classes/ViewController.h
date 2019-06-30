//
//  ViewController.h
//  ARKit Example
//
//
//

#import <UIKit/UIKit.h>
#import "ARKit.h"
#import "DetailView.h"

@interface ViewController : UIViewController<ARViewDelegate>  {
    NSArray *points;
    ARKitEngine *engine;
    
    NSInteger selectedIndex;
    DetailView *currentDetailView;
}

@end
