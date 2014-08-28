//
//  MovieDetailsViewController.m
//  tomatoes
//
//  Created by blue elixir on 8/20/14.
//  Copyright (c) 2014 JAB. All rights reserved.
//

#import "MovieDetailsViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"

@interface MovieDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *posterImage;
@property (weak, nonatomic) IBOutlet UILabel *SynopsisDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIScrollView *scrolling;

@end

@implementation MovieDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //add poster image
    NSString *bigImage = [self.movie[@"posters"][@"original"] stringByReplacingOccurrencesOfString:@"_tmb" withString:@"_ori"];
    NSURL *imageURL = [NSURL URLWithString:bigImage];
    [self.posterImage setImageWithURL:imageURL];
    
    //add title
    self.titleLabel.text = self.movie[@"title"];
    //add snyopsis text
    self.SynopsisDetailLabel.text = self.movie[@"synopsis"];
    
    //scrolling
    [self.SynopsisDetailLabel sizeToFit];
    self.scrolling.contentSize = CGSizeMake(320, self.SynopsisDetailLabel.frame.size.height + 200);
    //self.scrolling.contentSize = CGSizeMake (320, self.SynopsisDetailLabel.frame.size.width);
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
