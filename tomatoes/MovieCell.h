//
//  MovieCell.h
//  tomatoes
//
//  Created by blue elixir on 8/6/14.
//  Copyright (c) 2014 JAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;


@end
