//
//  MovieViewController.m
//  tomatoes
//
//  Created by blue elixir on 7/17/14.
//  Copyright (c) 2014 JAB. All rights reserved.
//

#import "MovieViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "MovieDetailsViewController.h"

@interface MovieViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *movies;
@property (weak, nonatomic) IBOutlet UISearchBar *navigationBar;
@end

@implementation MovieViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @".::Movies::.";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view from its nib.
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=np4pvukhemwjzckp7geyk7k8";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        //NSLog(@"%@", object);
        
        self.movies = object[@"movies"];
        [self.tableView reloadData];
        
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
    self.tableView.rowHeight = 150;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //NSLog(self.movies.count);
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    //NSLog(@"cell for row at index path: %d", indexPath.row);
    
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    NSDictionary *movie = self.movies[indexPath.row];
    
    cell.movieTitleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"synopsis"];

    NSURL *url = [NSURL URLWithString:movie[@"posters"][@"thumbnail"]];

    NSURLRequest *imageRequest = [NSURLRequest requestWithURL:url];
    //UIImage *placeholderImage = [UIImage imageNamed:@"placeholder"];
    [cell.posterView setImageWithURLRequest:imageRequest placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        cell.posterView.image = image;
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"%@", error);
    }];
    // another way to write lines 82-85
    // [cell.posterView setImageWithURL:([NSURL URLWithString:movie[@"posters"][@"thumbnail"]])];
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    
    MovieDetailsViewController *vc = [[MovieDetailsViewController alloc] init];
    vc.movie = self.movies[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
