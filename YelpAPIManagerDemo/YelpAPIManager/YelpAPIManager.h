//
//  YelpAPIManager.h
//  YelpAPIManagerDemo
//
//  Created by Zian Chen on 4/21/14.
//  Copyright (c) 2014 Zian Mobile Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/**
 *  Sort mode: 0=Best matched (default), 1=Distance, 2=Highest Rated. If the mode is 1 or 2 a search may retrieve an additional 20 businesses past the initial limit of the first 20 results. This is done by specifying an offset and limit of 20. Sort by distance is only supported for a location or geographic search. The rating sort is not strictly sorted by the rating value, but by an adjusted rating value that takes into account the number of ratings, similar to a bayesian average. This is so a business with 1 rating of 5 stars doesn't immediately jump to the top.
 */

typedef enum {
    YelpSearchSortByBestMatch = 0,
    YelpSearchSortByDistance = 1,
    YelpSearchSortByHighestRated = 2,
} YelpSearchSortBy;


@interface YelpAPIManager : NSObject

/**
 *  Generic method for Yelp Search API
 *
 *  @param term           Search term (e.g. "food", "restaurants"). If term isn't included we search everything.
 
 //We should use either neighborhood+coordinate or location
 *  @param neighborhood   Neighborhood to search within.
 *  @param coordinate     Coordinate to unambiguous the results.
 
 *  @param location       CLLocation that should contain coordinate, altitude and accuracy information, results would be search around this location information.
 
 *  @param limit          Number of business results to return.
 *  @param offset         Offset the list of returned business results by this amount - to enable pagination.
 *  @param sort           Give sort functionality, see YelpSearchSortBy above for more detail.
 *  @param categoryFilter See http://www.yelp.com/developers/documentation/category_list
 *  @param radius         Search radius in meters. If the value is too large, a AREA_TOO_LARGE error may be returned. The max value is 40000 meters (25 miles).
 *  @param deal           Whether to exclusively search for businesses with deals.
 */

- (void)searchTerm:(NSString *)term
      neighborhood:(NSString *)neighborhood
        coordinate:(CLLocationCoordinate2D)coordinate
          location:(CLLocation *)location
             limit:(NSUInteger)limit
            offset:(NSUInteger)offset
              sort:(YelpSearchSortBy)sort
    categoryFilter:(NSString *)categoryFilter
            radius:(NSUInteger)radius
              deal:(BOOL)deal;


- (void)search;
- (void)business;

+ (id)sharedInstance;

@end
