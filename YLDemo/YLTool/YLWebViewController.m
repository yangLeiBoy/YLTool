//
//  YLWebViewController.m
//  YLCustomControls
//
//  Created by yangLei on 2019/1/8.
//  Copyright © 2019 yangLei. All rights reserved.
//

#import "YLWebViewController.h"

@interface YLWebViewController ()

@end

@implementation YLWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.title = _navcTitle;
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    WKWebView *webview = [[WKWebView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:webview];
    
    
    if(_url.length > 0)
    {
        [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    }
    else if (_html.length > 0)
    {
        [webview loadHTMLString:_html baseURL:nil];
    }

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
