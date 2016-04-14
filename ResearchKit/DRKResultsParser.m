//
//  DRKResultsParser.m
//  OurChild
//
//  Created by Jamie Daniel on 6/19/15.
//  Copyright (c) 2015 Duke Health. All rights reserved.
//

#import "DRKResultsParser.h"
#import "NSDate+DMAdditions.h"

#ifdef DEBUG
#define DLog(...) NSLog(@"%s(%p) %@", __PRETTY_FUNCTION__, self, [NSString stringWithFormat:__VA_ARGS__])
#else
#define DLog(...)
#endif

@interface DRKResultsParser ()
-(BOOL)addStepResultValues:(ORKStepResult*)stepResult toDictionary:(NSDictionary*)targetDictionary;
-(BOOL)addStepResultValues:(ORKStepResult*)stepResult fromSteps:(NSArray*)steps toDictionary:(NSDictionary*)targetDictionary questionAsKey:(BOOL)questionAsKey labelAsValue:(BOOL)labelAsValue;
@end

@implementation DRKResultsParser

// returns a dictionary of the identifier and value of each step
-(NSDictionary *)resultsAsDictionary:(ORKTaskResult *)taskResults
{
    return [self resultsAsDictionary:taskResults fromSteps:nil questionAsKey:NO labelAsValue:NO];
}

-(NSDictionary *)resultsAsDictionary:(ORKTaskResult *)taskResults fromSteps:(NSArray *)steps questionAsKey:(BOOL)questionAsKey labelAsValue:(BOOL)labelAsValue
{
    _taskResult = taskResults;

    NSMutableDictionary *returnDict = [[NSMutableDictionary alloc] init]; // dict that will have identity / value pairs

    for(int i = 0; i < [_taskResult.results count]; i++)
    {
        ORKStepResult *stepResult = [_taskResult stepResultForStepIdentifier:[[_taskResult.results objectAtIndex:i] identifier]];
        [self addStepResultValues:stepResult fromSteps:steps toDictionary:returnDict questionAsKey:questionAsKey labelAsValue:labelAsValue];
    }


    return returnDict;
}

-(NSString *)resultsAsJSONString:(ORKTaskResult *)taskResults
{
    NSError *error;
    NSDictionary *resultsDictionary = [self resultsAsDictionary:taskResults];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:resultsDictionary
                                                       options:0
                                                         error:&error];

    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    return jsonString;
}

#pragma mark ------------------------------------------
#pragma mark methods to pull values from result answers
#pragma mark ------------------------------------------
-(BOOL)addStepResultValues:(ORKStepResult*)stepResult toDictionary:(NSDictionary*)targetDictionary {
    return [self addStepResultValues:stepResult fromSteps:nil toDictionary:targetDictionary questionAsKey:NO labelAsValue:NO];
}

-(BOOL)addStepResultValues:(ORKStepResult*)stepResult fromSteps:(NSArray *)steps toDictionary:(NSDictionary*)targetDictionary questionAsKey:(BOOL)questionAsKey labelAsValue:(BOOL)labelAsValue {
    NSMutableDictionary *questions = nil;
    NSMutableDictionary *labels = nil;

    if (steps && (questionAsKey || labelAsValue)) {
        if (questionAsKey) questions = [[NSMutableDictionary alloc] init];
        if (labelAsValue) labels = [[NSMutableDictionary alloc] init];

        for (ORKStep *step in steps) {
            if ([step isKindOfClass:[ORKQuestionStep class]]) {
                ORKQuestionStep *s = (ORKQuestionStep *)step;
                if (questionAsKey) {
                    [questions setObject:s.title forKey:s.identifier];
                }
                if (labelAsValue) {
                    if (s.questionType == ORKQuestionTypeMultipleChoice || s.questionType == ORKQuestionTypeSingleChoice) {
                        NSMutableDictionary *values = [[NSMutableDictionary alloc] init];
                        if ([s.answerFormat isKindOfClass:[ORKTextChoiceAnswerFormat class]]) {
                            ORKTextChoiceAnswerFormat *format = (ORKTextChoiceAnswerFormat *)s.answerFormat;
                            for (ORKTextChoice *choice in format.textChoices) {
                                [values setObject:choice.text forKey:choice.value];
                            }
                        }
#if DEBUG
                        else {
                            NSAssert(YES, @"unknown answer format (%@)", [s.answerFormat class]);
                        }
#endif
                        [labels setObject:values forKey:s.identifier];
                    }
                }
            }
        }
    }

    for(int x = 0; x < [stepResult.results count]; x++)
    {
        NSString *identifier = [[stepResult.results objectAtIndex:x] identifier];
        NSString *ident = nil;
        if (questionAsKey) {
            ident = [questions valueForKey:[[stepResult.results objectAtIndex:x] identifier]];
        }
        if (!ident) {
            ident = [[stepResult.results objectAtIndex:x] identifier];
        }

        if([[stepResult.results objectAtIndex:x] isKindOfClass:[ORKChoiceQuestionResult class]]) {
            if([((ORKChoiceQuestionResult *)[stepResult.results objectAtIndex:x]) questionType] == ORKQuestionTypeMultipleChoice)
            {
                DLog(@"ORKChoiceQuestionResult:ORKQuestionTypeMultipleChoice");
                NSArray *choiceAnswers = [NSArray arrayWithArray:[((ORKChoiceQuestionResult *)[stepResult.results objectAtIndex:x]) choiceAnswers]];
                if (labelAsValue && [labels objectForKey:identifier]) {
                    NSDictionary *choiceLabels = [labels objectForKey:identifier];
                    NSMutableArray *a = [[NSMutableArray alloc] initWithCapacity:choiceAnswers.count];
                    for (NSString *answer in choiceAnswers) {
                        NSString *ans = [choiceLabels objectForKey:answer];
                        [a addObject:ans];
                    }
                    choiceAnswers = a;
                }
                [targetDictionary setValue:choiceAnswers forKey:ident];
            }else if([((ORKChoiceQuestionResult *)[stepResult.results objectAtIndex:x]) questionType] == ORKQuestionTypeSingleChoice)
            {
                DLog(@"ORKChoiceQuestionResult:ORKQuestionTypeSingleChoice");
                ORKChoiceQuestionResult *qr = [stepResult.results objectAtIndex:x];
                NSString *choiceAnswer = [qr.choiceAnswers objectAtIndex:0];
                if (labelAsValue && [labels objectForKey:identifier]) {
                    NSDictionary *choiceLabels = [labels objectForKey:identifier];
                    choiceAnswer = [choiceLabels objectForKey:choiceAnswer];
                }
                [targetDictionary setValue:choiceAnswer forKey:ident];
            }else {
                ORKChoiceQuestionResult *qr = [stepResult.results objectAtIndex:x];
                DLog(@"ORKChoiceQuestionResult");
                NSString *choiceAnswer = [qr.choiceAnswers objectAtIndex:0];
                if (labelAsValue && [labels objectForKey:identifier]) {
                    NSDictionary *choiceLabels = [labels objectForKey:identifier];
                    choiceAnswer = [choiceLabels objectForKey:choiceAnswer];
                }
                [targetDictionary setValue:choiceAnswer forKey:ident];
            }

        }else if([[stepResult.results objectAtIndex:x] isKindOfClass:[ORKTextQuestionResult class]])
        {
            DLog(@"ORKTextQuestionResult");
            ORKTextQuestionResult *tr = [stepResult.results objectAtIndex:x];
            [targetDictionary setValue:tr.textAnswer forKey:ident];

        }else if([[stepResult.results objectAtIndex:x] isKindOfClass:[ORKNumericQuestionResult class]])
        {
            DLog(@"ORKNumericAnswerFormat");
            ORKNumericQuestionResult *nr = [stepResult.results objectAtIndex:x];
            [targetDictionary setValue:nr.numericAnswer forKey:ident];

        }else if([[stepResult.results objectAtIndex:x] isKindOfClass:[ORKDateQuestionResult class]]){
            DLog(@"ORKDateQuestionResult");
            ORKDateQuestionResult *dr = [stepResult.results objectAtIndex:x];
            [targetDictionary setValue:[dr.dateAnswer ISO8601String] forKey:ident];

        }else if([[stepResult.results objectAtIndex:x] isKindOfClass:[ORKScaleQuestionResult class]])
        {
            DLog(@"ORKScaleQuestionResult");
            ORKScaleQuestionResult *sr = [stepResult.results objectAtIndex:x];
            [targetDictionary setValue:sr.scaleAnswer forKey:ident];

        }else if([[stepResult.results objectAtIndex:x] isKindOfClass:[ORKSpatialSpanMemoryResult class]])
        {
            DLog(@"ORKSpatialSpanMemoryResult");
            ORKSpatialSpanMemoryResult *smr = [stepResult.results objectAtIndex:x];

            NSMutableDictionary *spatialSpanMemoryAnswers = [[NSMutableDictionary alloc] init];
            [spatialSpanMemoryAnswers setValue:[NSNumber numberWithInteger:smr.score] forKey:@"score"];
            [spatialSpanMemoryAnswers setValue:smr.gameRecords forKey:@"gamerecordsarray"];
            [spatialSpanMemoryAnswers setValue:smr.userInfo forKey:@"userdatadictionary"];
            [targetDictionary setValue:spatialSpanMemoryAnswers forKey:ident];

        }else if([[stepResult.results objectAtIndex:x] isKindOfClass:[ORKTappingIntervalResult class]])
        {
            DLog(@"ORKTappingIntervalResult");
            ORKTappingIntervalResult *tr = [stepResult.results objectAtIndex:x];
            [targetDictionary setValue:tr.samples forKey:ident];

        }else if([[stepResult.results objectAtIndex:x] isKindOfClass:[ORKTimeIntervalQuestionResult class]])
        {
            DLog(@"ORKTimeIntervalQuestionResult");
            ORKTimeIntervalQuestionResult *result = [stepResult.results objectAtIndex:x];
            [targetDictionary setValue:result.intervalAnswer forKey:ident];

        }else if([[stepResult.results objectAtIndex:x] isKindOfClass:[ORKTimeOfDayQuestionResult class]])
        {
            DLog(@"ORKTimeOfDayQuestionResult");
            ORKTimeOfDayQuestionResult *tdr = [stepResult.results objectAtIndex:x];
            [targetDictionary setValue:tdr.dateComponentsAnswer forKey:ident];

        }else if([[stepResult.results objectAtIndex:x] isKindOfClass:[ORKToneAudiometryResult class]])
        {
            DLog(@"ORKToneAudiometryResult");
            ORKToneAudiometryResult *tar = [stepResult.results objectAtIndex:x];
            [targetDictionary setValue:tar.samples forKey:ident];

        }else if([[stepResult.results objectAtIndex:x] isKindOfClass:[ORKBooleanQuestionResult class]])
        {
            DLog(@"ORKBooleanQuestionResult");
            ORKBooleanQuestionResult *br = [stepResult.results objectAtIndex:x];
            [targetDictionary setValue:br.booleanAnswer forKey:ident];

        }else if([[stepResult.results objectAtIndex:x] isKindOfClass:[ORKConsentSignatureResult class]])
        {
            DLog(@"ORKConsentSignatureResult");
            ORKConsentSignatureResult *csr = [stepResult.results objectAtIndex:x];
            [targetDictionary setValue:csr.signature forKey:ident];

        }else if([[stepResult.results objectAtIndex:x] isKindOfClass:[ORKFileResult class]])
        {
            DLog(@"ORKFileResult");
            ORKFileResult *fr = [stepResult.results objectAtIndex:x];
            [targetDictionary setValue:fr.fileURL forKey:ident];

        }else{
            NSLog(@"NOPE ; The class is : %@", [[stepResult.results objectAtIndex:x] class]);
            return NO; // This means something went wrong
        }

    }

    return YES; // if add is ok.
}

#pragma mark ------------------------------------------

@end
