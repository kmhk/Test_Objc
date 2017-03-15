//
//  BrowseViewController.h
//  Test
//
//  Created by Com on 23/02/2017.
//  Copyright © 2017 Com. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *detailWebView;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.detailWebView.allowsInlineMediaPlayback = YES;
    self.detailWebView.scalesPageToFit = YES;
    self.detailWebView.contentMode = UIViewContentModeScaleAspectFit;
    self.detailWebView.delegate = self;
    
    NSString *vimeoVideoId = @"7100569";
    
    NSString *templateHtmlContent = [self templateHtmlString];
    if (templateHtmlContent.length > 0) {
        NSString *htmlContent = [templateHtmlContent stringByReplacingOccurrencesOfString:@"__VimeoVideoId__" withString:vimeoVideoId];
        htmlContent = [htmlContent stringByReplacingOccurrencesOfString:@"__ImageTitle__" withString:self.imageTitle];
        htmlContent = [htmlContent stringByReplacingOccurrencesOfString:@"__ImageSrcURL__" withString:self.imageSrcURL];
        htmlContent = [htmlContent stringByReplacingOccurrencesOfString:@"__ImageSrcLocalURL__" withString:self.imageSrcLocalURL];
        
        NSURL *resourceURL = [[NSBundle mainBundle] resourceURL];
        [self.detailWebView loadHTMLString:htmlContent baseURL:resourceURL];
    } else {
        // Show Error
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Read HTML Template File
- (NSString *)templateHtmlString {
    NSString *htmlTemplateFilePath = [[NSBundle mainBundle] pathForResource:@"imgeview" ofType:@"html"];
    NSString *fileContentString = [NSString stringWithContentsOfFile:htmlTemplateFilePath encoding:NSUTF8StringEncoding error:nil];
    
    return fileContentString;
}

#pragma mark - UIWebView Delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        [[UIApplication sharedApplication] openURL:request.URL options:[NSDictionary dictionary] completionHandler:nil];
        return NO;
    }
    
    return YES;
}
@end
