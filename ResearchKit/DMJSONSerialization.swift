//
//  DMJSONSerialization.swift
//  cancercoach
//
//  Created by Harrison Suh on 7/8/16.
//  Copyright © 2016 DIHI. All rights reserved.
//

import Foundation
import ResearchKit

/**
 This class provides serialization to load consent sections, surveys, and other elements frequently utilized by ResearchKit apps from JSON files.
 */
class DMJSONSerialization {
    
    // Some localized strings taken from Apple's AppCore. Copyright 2016.
    
    // MARK: Consent Section Localized Strings
    
    static let kSectionType                         = "sectionType"
    static let kSectionTitle                        = "sectionTitle"
    static let kSectionSummary                      = "sectionSummary"
    static let kSectionContent                      = "sectionContent"
    static let kSectionHtmlContent                  = "sectionHtmlContent"
    static let kSectionImage                        = "sectionImage"
    static let kSectionAnimationUrl                 = "sectionAnimationUrl"
    static let kSectionLearnMoreButtonTitle         = "sectionLearnMoreButtonTitle"
    static let kSectionRequiresAcceptance           = "sectionRequireAcceptance"
    
    static let kSectionTypeValueOverview            = "overview"
    static let kSectionTypeValuePrivacy             = "privacy"
    static let kSectionTypeValueDataGathering       = "dataGathering"
    static let kSectionTypeValueDataUse             = "dataUse"
    static let kSectionTypeValueTimeCommitment      = "timeCommitment"
    static let kSectionTypeValueStudySurvey         = "studySurvey"
    static let kSectionTypeValueStudyTasks          = "studyTasks"
    static let kSectionTypeValueWithdrawing         = "withdrawing"
    static let kSectionTypeValueCustom              = "custom"
    static let kSectionTypeValueOnlyInDocument      = "onlyInDocument"
    
    // MARK: Survey Steps Localized Strings
    
    static let kStepType                            = "type"
    static let kStepTypeInstructionStep             = "InstructionStep"
    static let kStepTypeQuestionStep                = "SurveyQuestion"
    static let kStepTypeCompletionStep              = "CompletionStep"
    static let kStepTypeCustomStep                  = "CustomStep"
    static let kStepClass                           = "stepClass"
    static let kStepClassMusicSelectionStep         = "org.dihi.rfa.cancercoach.task.MusicSelectionStep"
    static let kStepClassPictureSelectionStep       = "org.dihi.rfa.cancercoach.task.PictureSelectionStep"
    static let kStepClassContactSelectionStep       = "org.dihi.rfa.cancercoach.task.ContactSelectionStep"
    static let kStepTypeFindSupportStep             = "org.dihi.rfa.cancercoach.task.ContactStep"
    static let kStepTypeInterventionStep            = "org.dihi.rfa.cancercoach.task.InterventionStep"
    static let kStepTypeAudioVisualPlaybackStep     = "AudioVisualPlaybackStep"
    static let kStepTypeHtmlViewStep                = "org.dihi.rfa.cancercoach.task.HtmlViewStep"
    
    static let kStepIdentifier                      = "identifier"
    static let kStepTitle                           = "prompt"
    static let kStepText                            = "promptDetail"
    static let kStepImage                           = "image"
    static let kStepOptional                        = "optional"
    static let kStepQuestionFormat                  = "constraints"
    
    static let kStepConstraints                     = "constraints"
    static let kStepNavRules                        = "rules"
    static let kStepNavType                         = "type"
    static let kStepNavOperator                     = "operator"
    static let kStepNavValue                        = "value"
    static let kStepNavSkipTo                       = "skipTo"
    
    static let kQuestionType                        = "type"
    static let kQuestionTypeInteger                 = "IntegerConstraints"
    static let kQuestionTypeIntegerScale            = "SliderConstraints"
    static let kQuestionTypeMultipleChoice          = "MultiValueConstraints"
    static let kQuestionTypeDate                    = "DateConstraints"
    static let kQuestionTypeText                    = "TextConstraints"
    static let kQuestionTypeBoolean                 = "BooleanConstraints"
    
    static let kScaleQuestionMaxValue               = "maxValue"
    static let kScaleQuestionMinValue               = "minValue"
    static let kScaleQuestionMaxValueDescription    = "maxValueDescription"
    static let kScaleQuestionMinValueDescription    = "minValueDescription"
    static let kScaleQuestionDefaultValue           = "defaultValue"
    static let kScaleQuestionStepInterval           = "step"
    static let kScaleQuestionIsVertical             = false
    
    static let kMCQuestionDataType                  = "dataType"
    static let kMCQuestionAllowsMultiple            = "allowMultiple"
    static let kMCQuestionAllowsOther               = "allowOther"
    static let kMCQuestionAnswerChoices             = "enumeration"
    static let kMCQuestionOptionType                = "type"
    static let kMCQuestionOptionValue               = "value"
    static let kMCQuestionOptionLabel               = "label"
    static let kMCQuestionOptionExclusive           = "exclusive"
    
    static let kTextQuestionMultipleLines           = "multipleLines"
    static let kTextQuestionMaxLength               = "maxLength"
    static let kTextQuestionDataType                = "dataType"
    
    static let kCustomSelectorType                  = "type"
    static let kCustomSelectorTypePicture           = "picture"
    static let kCustomSelectorTypeMusic             = "music"
    static let kCustomSelectorTypeContact           = "contact"
    
    static let kQuizSection                         = "quiz"
    static let kQuizSteps                           = "questions"
    static let kQuizStepIdentifier                  = "identifier"
    static let kQuizStepType                        = "type"
    static let kQuizStepTitle                       = "prompt"
    static let kQuizStepText                        = "text"
    
    static let kQuizStepExpectedAnswer              = "expectedAnswer"
    static let kQuizStepPositiveFeedback            = "positiveFeedback"
    static let kQuizStepNegativeFeedback            = "negativeFeedback"
    static let kQuizCorrectAnswerImage              = "correctIcon"
    static let kQuizIncorrectAnswerImage            = "incorrectIcon"
    
    static let kQuizCompletionTitle                 = "failureTitle"
    static let kQuizCompletionMessage               = "failureMessage"
    
    static let kQuizStepTypeInstruction             = "instruction"
    static let kQuizStepTypeBoolean                 = "boolean"
    
    // MARK: Insights Tab localized Strings
    
    static let kInsightsQuoteDict                   = "elements"
    static let kInsightsQuoteTitle                  = "prefix"
    static let kInsightsQuoteText                   = "detail"
    
    static let kInsightsPlanDict                    = "elements"
    static let kInsightsPlanTitle                   = "prefix"
    static let kInsightsPlanText                    = "detail"
    
    //MARK: Stock media localized Strings
    
    static let kMusicDict                           = "music"
    static let kMusicTitle                          = "audioFile"
    
    static let kImageDict                           = "images"
    static let kImageTitle                          = "imageFile"
    
    // MARK: Generate Consent Sections
    
    // Parts of code for this method taken from Appcore's APCConsentTask.
    // Copyright Apple 2016.
    
    /*
    static func consentDocumentSectionsFromJSON(json: [Dictionary<String, String>]) -> [ORKConsentSection] {
        
        var steps: [ORKConsentSection] = [ORKConsentSection]()
        
        for section in json {
            let sectionType = section[kSectionType]
            if (sectionType == nil || sectionType == "") {
                fatalError("Section Type is missing")
            }
            let type: ORKConsentSectionType = consentSectionTypeFromValue(value: sectionType!)
            
            // This is the check for the Duke NOPP step.
            // The NOPP step is implemented as an ORK Question step in the task and is
            //      currently not a part of the consent sections as an ORKConsentSection.
            if (type == .custom) {
                if section[kSectionRequiresAcceptance] != nil {
                    continue
                }
            }
            
            let step = ORKConsentSection(type: type)
            
            if let title = section[kSectionTitle] {
                step.title = title
            }
            
            if let summary = section[kSectionSummary] {
                step.summary = summary
            }
            
            if let content = section[kSectionContent] {
                step.content = content
            }
            if let learnMore = section[kSectionLearnMoreButtonTitle] {
                step.customLearnMoreButtonTitle = learnMore
            }
            
            if let htmlContent = section[kSectionHtmlContent] {
                if let filePath = Bundle.main.path(forResource: htmlContent, ofType: "html") {
                    do {
                        let htmlContent = try NSString(contentsOfFile: filePath, usedEncoding: nil)
                        step.htmlContent = htmlContent as String
                        
                    } catch {
                        fatalError("\(error)")
                    }
                }
            }
            
            // if images do not show, the animation will appear over the text of the consent steps
            if let image = section[kSectionImage] {
                step.customImage = UIImage(named: image)
            }
            
            if let animationUrl = section[kSectionAnimationUrl] {
                print("looking for \(animationUrl) (\(animationUrl.stringByDeletingPathExtension!), \(animationUrl.pathExtension!))")
                
                // See if scaled animation exists first
                var scaleFactorAnimation = animationUrl.stringByDeletingPathExtension!
                if UIScreen.mainScreen().scale >= 3 {
                    scaleFactorAnimation = "\(scaleFactorAnimation)@3x"
                } else {
                    scaleFactorAnimation = "\(scaleFactorAnimation)@2x"
                }
                
                var url = Bundle.main.url(forResource: scaleFactorAnimation, withExtension: animationUrl.pathExtension!)
                do {
                    if let url = url {
                        print("trying url-1 = \(url.absoluteString)")
                        try url.checkPromisedItemIsReachableAndReturnError(nil)
                    } else {
                        throw NSError(domain: "", code: 0, userInfo: nil)
                    }
                } catch {
                    do {
                        url = Bundle.mainBundle().URLForResource(animationUrl.stringByDeletingPathExtension!, withExtension: animationUrl.pathExtension!)
                        print("trying url-2 = \(url?.absoluteString)")
                        url?.checkPromisedItemIsReachableAndReturnError(nil)
                    } catch {
                        fatalError("Unable to load custom animation named \(animationUrl)")
                    }
                }
                step.customAnimationURL = url
            }
            
            steps.append(step)
        }
        return steps
    }
    */
    
    static func consentQuizStepsFromJSONDict(jsonDictionary: Dictionary<String, AnyObject>) -> [ORKStep] {
        var steps: [ORKStep] = [ORKStep]()
        
        let quiz = jsonDictionary[kQuizSection] as! [String: AnyObject]
        
        let questions = quiz[kQuizSteps] as! [Dictionary<String,AnyObject>]
        for question in questions {
            let identifier: String = question[kQuizStepIdentifier] as! String
            let stepType: String = question[kQuizStepType] as! String
            
            if stepType == kQuizStepTypeInstruction {
                let step: ORKInstructionStep = ORKInstructionStep.init(identifier: identifier)
                if let title: String = question[kQuizStepTitle] as? String {
                    step.title = title
                }
                
                if let text: String = question[kQuizStepText] as? String {
                    step.text = text
                }
                steps.append(step)
            }
            
            if stepType == kQuizStepTypeBoolean {
                
                let step: DRKQuizStep = DRKQuizStep.init(identifier: identifier)
                
                if let title: String = question[kQuizStepTitle] as? String {
                    step.quizQuestionText = title
                }
                
                if let expectedAnswer: String = question[kQuizStepExpectedAnswer] as? String {
                    if (expectedAnswer == "true") {
                        step.expectedAnswer = true
                        
                    } else if (expectedAnswer == "false") {
                        step.expectedAnswer = false
                    }
                }
                
                if let positiveFeedback: String = question[kQuizStepPositiveFeedback] as? String {
                    step.positiveFeedbackText = positiveFeedback
                }
                
                if let negativeFeedback: String = question[kQuizStepNegativeFeedback] as? String {
                    step.negativeFeedbackText = negativeFeedback
                }
                
                steps.append(step)
            }
        }
        // FIXME: Quiz always displays failure title and message at the end
        let step: ORKInstructionStep = ORKInstructionStep.init(identifier: "quiz_completed_step")
        if let completionTitle: String = quiz["failureTitle"] as? String {
            step.title = completionTitle
        }
        if let completionMessage: String = quiz[kQuizCompletionMessage] as? String {
            step.text = completionMessage
        }
        if let completionImage: String = quiz["correctIcon"] as? String {
            step.image = UIImage.init(named: completionImage)
        }
        steps.append(step)
        
        return steps
    }
    
    
    // The code for this method was taken from AppCore's APCConsentTask.
    // Copyrighted by Apple in 2016.
    
    static func consentSectionTypeFromValue(value: String) -> ORKConsentSectionType {
        if value == kSectionTypeValueOverview { return .overview }
        else if value == kSectionTypeValuePrivacy { return .privacy }
        else if value == kSectionTypeValueDataGathering { return .dataGathering }
        else if value == kSectionTypeValueDataUse { return .dataUse }
        else if value == kSectionTypeValueTimeCommitment { return .timeCommitment }
        else if value == kSectionTypeValueStudySurvey { return .studySurvey }
        else if value == kSectionTypeValueStudyTasks { return .studyTasks }
        else if value == kSectionTypeValueWithdrawing { return .withdrawing }
        else if value == kSectionTypeValueCustom { return .custom }
        else if value == kSectionTypeValueOnlyInDocument { return .onlyInDocument }
        else { fatalError("Section Type invalid") }
    }
    
    // MARK: Generate Survey Tasks
    
    static func surveySectionsFromJSONObject(json: [Dictionary<String,AnyObject>]) -> [(ORKStep, ORKStepNavigationRule?)] {
        
        var steps: [(ORKStep, ORKStepNavigationRule?)] = [(ORKStep, ORKStepNavigationRule?)]()
        
        for element in json {
            var navRule: ORKStepNavigationRule? = nil
            let identifier: String = element[kStepIdentifier] as! String
            let stepType: String = element[kStepType] as! String
            
            if let constraints = element[kStepConstraints] as? Dictionary<String,AnyObject> {
                
                if let navRules = constraints[kStepNavRules] as? [Dictionary<String,AnyObject>] {
                    
                    if stepType == kStepTypeInstructionStep {
                        for navRuleConstraints in navRules {
                            let destinationStep = navRuleConstraints[kStepNavSkipTo] as! String
                            
                            if navRuleConstraints[kStepNavOperator] as! String == "de" {
                                navRule = ORKDirectStepNavigationRule.init(destinationStepIdentifier: destinationStep)
                            }
                        }
                    } else if stepType == kStepTypeQuestionStep {
                        let questionType = constraints["type"] as? String
                        
                        var resultPredicates = [NSPredicate]()
                        var destinationSteps = [String]()
                        var defaultStep: String?
                        
                        for navRuleConstraints in navRules {
                            let destinationStep = navRuleConstraints[kStepNavSkipTo] as! String
                            destinationSteps.append(destinationStep)
                            
                            let resultSelector = ORKResultSelector.init(resultIdentifier: identifier)
                            
                            let resultValue = navRuleConstraints["value"] as? Int
                            
                            switch questionType! {
                                
                            case "SliderConstraints":
                                let navOperator = navRuleConstraints[kStepNavOperator] as! String
                                if navOperator == "de" {
                                    defaultStep = navRuleConstraints["skipTo"] as? String
                                    
                                } else if navOperator == "ge" {
                                    let resultPredicate = ORKResultPredicate.predicateForScaleQuestionResult(with: resultSelector, minimumExpectedAnswerValue: Double(resultValue!))
                                    resultPredicates.append(resultPredicate)
                                    
                                } else if navOperator == "le" {
                                    let resultPredicate = ORKResultPredicate.predicateForScaleQuestionResult(with: resultSelector, maximumExpectedAnswerValue: Double(resultValue!))
                                    resultPredicates.append(resultPredicate)
                                    
                                } else if navOperator == "eq" {
                                    let resultPredicate = ORKResultPredicate.predicateForScaleQuestionResult(with: resultSelector, expectedAnswer: Int(resultValue!))
                                    resultPredicates.append(resultPredicate)
                                    
                                }  // TODO: Implement one for operator "ne"
                                break
                                
                            case "MultiValueConstraints":
                                let navOperator = navRuleConstraints[kStepNavOperator] as! String
                                if navOperator == "de" {
                                    defaultStep = navRuleConstraints["skipTo"] as? String
                                    
                                } else if navOperator == "eq" {
                                    let resultPredicate = ORKResultPredicate.predicateForChoiceQuestionResult(with: resultSelector, expectedAnswerValue: Int(resultValue!) as NSCoding & NSCopying & NSObjectProtocol)
                                    resultPredicates.append(resultPredicate)
                                } else if navOperator == "sum_gt" {
                                    print("sum_gt")
                                    let resultPredicate = ORKResultPredicate.predicateForNumericQuestionResult(with: resultSelector, minimumExpectedAnswerValue: Double(resultValue! + 1), maximumExpectedAnswerValue: Double(99))
                                    resultPredicates.append(resultPredicate)
                                }
                                
                                break
                                
                            default:
                                break
                            }
                        }
                        navRule = ORKPredicateStepNavigationRule(resultPredicates: resultPredicates,
                                                                 destinationStepIdentifiers: destinationSteps,
                                                                 defaultStepIdentifier: defaultStep,
                                                                 validateArrays: false)
                    }
                }
            }
            
            if stepType == kStepTypeInstructionStep {
                let step: ORKInstructionStep = ORKInstructionStep.init(identifier: identifier)
                
                if let title: String = element[kStepTitle] as? String {
                    step.title = title
                }
                
                if let text: String = element[kStepText] as? String {
                    step.text = text
                }
                
                if let image: String = element[kStepImage] as? String {
                    step.image = UIImage.init(named: image)
                }
                
                steps.append((step, navRule))
                
            } else if stepType == kStepTypeQuestionStep {
                let step: ORKQuestionStep = ORKQuestionStep.init(identifier: identifier)
                
                if let title: String = element[kStepTitle] as? String {
                    step.title = title
                }
                if let text: String = element[kStepText] as? String {
                    step.text = text
                }
                
                // Assume step is required unless specified in file
                step.isOptional = false
                if let optional = element[kStepOptional] as? String {
                    if optional == "true" {
                        step.isOptional = true
                    }
                }
                
                let questionDict: Dictionary<String,AnyObject> = element[kStepQuestionFormat] as! Dictionary<String,AnyObject>
                
                step.answerFormat = surveyQuestionFormatFromDict(dict: questionDict)
                steps.append((step, navRule))
                //            } else if type == kStepTypeCompletionStep {
                //                let step = surveyCompletionStepFromDict(element)
                
            } else {
                fatalError("Step type \(stepType) does not conform to any available ORKSteps")
            }
        }
        return steps
    }
    
    static func surveyQuestionFormatFromDict(dict: Dictionary<String,AnyObject>) -> ORKAnswerFormat {
        
        let questionType = dict[kQuestionType] as! String
        
        var answerFormat: ORKAnswerFormat?
        
        if questionType == kQuestionTypeIntegerScale {
            
            let maxValue = dict[kScaleQuestionMaxValue] as! Int
            let minValue = dict[kScaleQuestionMinValue] as! Int
            let maxValueDescription = dict[kScaleQuestionMaxValueDescription] as! String
            let minValueDescription = dict[kScaleQuestionMinValueDescription] as! String
            
            let defaultValue = dict[kScaleQuestionDefaultValue] as! Int
            let step = dict[kScaleQuestionStepInterval] as! Int
            
            answerFormat = ORKScaleAnswerFormat.init(
                maximumValue: maxValue,
                minimumValue: minValue,
                defaultValue: defaultValue,
                step: step,
                vertical: kScaleQuestionIsVertical,
                maximumValueDescription: maxValueDescription,
                minimumValueDescription: minValueDescription
            )
            
        } else if questionType == kQuestionTypeInteger {
            var min: Int?
            var max: Int?
            
            if let maxValue = dict[kScaleQuestionMaxValue] as? Int {
                max = maxValue
            }
            
            if let minValue = dict[kScaleQuestionMinValue] as? Int {
                min = minValue
            }
            
            answerFormat = ORKNumericAnswerFormat.init(style: .integer, unit: nil, minimum: min as NSNumber?, maximum: max as NSNumber?)
            
            
        } else if questionType == kQuestionTypeBoolean {
            answerFormat = ORKBooleanAnswerFormat.init()
            
        } else if questionType == kQuestionTypeMultipleChoice {
            
            var answerStyle: ORKChoiceAnswerStyle?
            var answerChoices: [ORKTextChoice] = [ORKTextChoice]()
            //var choicesAreExclusive: Bool?
            
            if let doesAllowMultiple = dict[kMCQuestionAllowsMultiple] as? String {
                if doesAllowMultiple == "true" {
                    answerStyle = .multipleChoice
                } else {
                    answerStyle = .singleChoice
                }
            }
            
            if let doesAllowOther = dict[kMCQuestionAllowsOther] as? String {
                if doesAllowOther == "true" {
                    //choicesAreExclusive = false
                }
            }
            
            for answerChoice in dict[kMCQuestionAnswerChoices] as! [Dictionary<String,AnyObject>] {
                
                let label = answerChoice[kMCQuestionOptionLabel] as! String
                let value = answerChoice[kMCQuestionOptionValue] as! NSNumber
                if let exclusive = answerChoice[kMCQuestionOptionExclusive] {
                    if exclusive as! String == "true" {
                        let textChoice = ORKTextChoice.init(text: label, detailText: nil, value: value, exclusive: true)
                        answerChoices.append(textChoice)
                    } else {
                        let textChoice = ORKTextChoice.init(text: label, detailText: nil, value: value, exclusive: false)
                        answerChoices.append(textChoice)
                    }
                } else {
                    let textChoice = ORKTextChoice.init(text: label, value: value)
                    answerChoices.append(textChoice)
                }
            }
            answerFormat = ORKTextChoiceAnswerFormat.init(style: answerStyle!, textChoices: answerChoices)
            
        } else if questionType == kQuestionTypeDate {
            
            // TODO: This question should be a form step that asks for month and day.
            
            answerFormat = ORKDateAnswerFormat.init(style: .date)
            
        } else if questionType == kQuestionTypeText {
            
            answerFormat = ORKTextAnswerFormat.init(maximumLength: 0) //no maximum length
            
            if let maximumLength = dict[kTextQuestionMaxLength] as? String {
                (answerFormat as! ORKTextAnswerFormat).maximumLength = Int(maximumLength)!
            }
            
            if let allowMultipleLines = dict[kTextQuestionMultipleLines] as? String {
                if allowMultipleLines == "false" {
                    (answerFormat as! ORKTextAnswerFormat).multipleLines = false
                }
            }
            
        }
            // TODO: Add any other types of questions we might add
        else {
            fatalError("Question type \(questionType) does not conform to any ORKAnswerFormat")
        }
        
        return answerFormat!
        
    }
    
    /**
    // TODO: Implement Completion Step method if future versions choose to utilize ORKCompletionSteps.
    static func surveyCompletionStepFromDict(dict: Dictionary<String,String>) -> ORKCompletionStep {
        let identifier = dict[kStepIdentifier]!
        let step = ORKCompletionStep.init(identifier: identifier)
        
        
        
        return step
        
    }
    */
    
    /*
    static func insightsCalloutOneFromJSONFile(fileName: String) -> [(String, String)] {
        let filePath: String? = Bundle.main.path(forResource: fileName, ofType:"json")
        
        guard !(filePath ?? "").isEmpty else {
            fatalError("path is required")
        }
        guard FileManager.default.fileExists(atPath: filePath!) else {
            fatalError("unable to find \(filePath)")
        }
        
        var insightsQuotes = [(String, String)]()
        
        let jsonData = try! NSData(contentsOfFile: filePath!, options: NSData.ReadingOptions.uncached)
        
        do {
            let object = try JSONSerialization.jsonObject(with: jsonData as Data, options: .allowFragments)
            if let jsonResults = object as? [String: AnyObject] {
                let jsonQuotes = jsonResults[kInsightsQuoteDict] as? [Dictionary<String,String>]
                for quote in jsonQuotes! {
                    let quoteTitle: String = quote[kInsightsQuoteTitle]!
                    let quoteText: String = quote[kInsightsQuoteText]!
                    
                    insightsQuotes.append((quoteTitle, quoteText))
                }
            }
        } catch {
            fatalError("Unable to parse JSON file \(fileName) for Insights Callout One")
        }
        
        return insightsQuotes
    }
    
    static func insightsCalloutTwoFromJSONFile(fileName: String) -> [(String, String)] {
        let filePath: String? = Bundle.main.path(forResource: fileName, ofType:"json")
        
        guard !(filePath ?? "").isEmpty else {
            fatalError("path is required")
        }
        guard FileManager.default.fileExists(atPath: filePath!) else {
            fatalError("unable to find \(filePath)")
        }
        
        var insightsPlans = [(String, String)]()
        
        let jsonData = try! NSData(contentsOfFile: filePath!, options: NSData.ReadingOptions.uncached)
        
        do {
            let object = try JSONSerialization.jsonObject(with: jsonData as Data, options: .allowFragments)
            if let jsonResults = object as? [String: AnyObject] {
                let jsonPlans = jsonResults[kInsightsPlanDict] as? [Dictionary<String,String>]
                for plan in jsonPlans! {
                    let planTitle: String = plan[kInsightsPlanTitle]!
                    let planText: String = plan[kInsightsPlanText]!
                    
                    insightsPlans.append((planTitle, planText))
                }
            }
        } catch {
            fatalError("Unable to parse JSON file \(fileName) for Insights Callout Two")
        }
        
        return insightsPlans
    }
    */
}

/*
extension String {
    var ns: NSString {
        return self as NSString
    }
    
    var pathExtension: String? {
        return ns.pathExtension
    }
    
    var lastPathComponent: String? {
        return ns.lastPathComponent
    }
    
    var stringByDeletingLastPathComponent: String? {
        return ns.stringByDeletingLastPathComponent
    }
    
    func stringByAppendingPathComponent(path: String) -> String {
        return ns.stringByAppendingPathComponent(path)
    }
    
    var stringByDeletingPathExtension: String? {
        return ns.stringByDeletingPathExtension
    }
    
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
}
*/
