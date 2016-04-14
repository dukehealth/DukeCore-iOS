//
//  DRKResultsParser.h
//  OurChild
//
//  Created by Jamie Daniel on 6/19/15.
//  Copyright (c) 2015 Duke Health. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ResearchKit/ResearchKit.h>

@interface DRKResultsParser : NSObject

@property (nonatomic, strong) ORKTaskResult *taskResult;

-(NSDictionary *)resultsAsDictionary:(ORKTaskResult *)taskResults;
-(NSDictionary *)resultsAsDictionary:(ORKTaskResult *)taskResults fromSteps:(NSArray *)steps questionAsKey:(BOOL)questionAsKey labelAsValue:(BOOL)labelAsValue;
-(NSString *)resultsAsJSONString:(ORKTaskResult *)taskResults;

@end
