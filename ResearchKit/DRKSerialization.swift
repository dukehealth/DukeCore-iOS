//
// DRKSerialization.swift
//  DukeCore-iOS
//
// Code from AppCore's APCConsentTask.
//
// Copyright (c) 2016, Apple. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
//
// 1.  Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer.
//
// 2.  Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation and/or
// other materials provided with the distribution.
//
// 3.  Neither the name of the copyright holder(s) nor the names of any contributors
// may be used to endorse or promote products derived from this software without
// specific prior written permission. No license is granted to the trademarks of
// the copyright holders even if such marks are included in this software.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//


import Foundation
import ResearchKit


/**
 `DRKSerialization` provides common serializers for apps using ResearchKit to load
 consent sections, surveys, etc from JSON files.
*/
class DRKSerialization {
    static let kSectionType            = "sectionType"
    static let kSectionTitle           = "sectionTitle"
    static let kSectionFormalTitle     = "sectionFormalTitle"
    static let kSectionSummary         = "sectionSummary"
    static let kSectionContent         = "sectionContent"
    static let kSectionHtmlContent     = "sectionHtmlContent"
    static let kSectionImage           = "sectionImage"
    static let kSectionAnimationUrl    = "sectionAnimationUrl"
    
    static let kSectionTypeValueOverview       = "overview"
    static let kSectionTypeValuePrivacy        = "privacy"
    static let kSectionTypeValueDataGathering  = "dataGathering"
    static let kSectionTypeValueDataUse        = "dataUse"
    static let kSectionTypeValueTimeCommitment = "timeCommitment"
    static let kSectionTypeValueStudySurvey    = "studySurvey"
    static let kSectionTypeValueStudyTasks     = "studyTasks"
    static let kSectionTypeValueWithdrawing    = "withdrawing"
    static let kSectionTypeValueCustom         = "custom"
    static let kSectionTypeValueOnlyInDocument = "onlyInDocument"
    
    static func consentSectionsFromJSONObject(json: [Dictionary<String, String>]) -> [ORKConsentSection] {
        
        var steps:[ORKConsentSection] = [ORKConsentSection]()
        
        for section in json {
            let typeName = section[kSectionType]
            if (typeName == nil || typeName == "") {
                fatalError("Sectyion Type is missing")
            }
            let type: ORKConsentSectionType = DRKSerialization.consentSectionTypeFromValue(typeName!)
            
            let title = section[kSectionTitle]
            let formalTitle = section[kSectionFormalTitle]
            let summary = section[kSectionSummary]
            let content = section[kSectionContent]
            let htmlContent = section[kSectionHtmlContent]
            let image = section[kSectionImage]
            let animationUrl = section[kSectionAnimationUrl]
            
            let step = ORKConsentSection(type: type)
            
            if let title = title {
                step.title = title
            }
            if let formalTitle = formalTitle {
                step.formalTitle = formalTitle
            }
            if let summary = summary {
                step.summary = summary
            }
            if let content = content {
                step.content = content
            }
            if let htmlContent = htmlContent {
                var pathExt = "html"
                let ext = htmlContent.pathExtension
                if ext != nil && ext != "" {
                    pathExt = ext!
                }
                let path = NSBundle.mainBundle().pathForResource(htmlContent.lastPathComponent, ofType: pathExt, inDirectory: htmlContent.stringByDeletingLastPathComponent)
                if (path == nil) {
                    fatalError("Unable to load html content named \(htmlContent)")
                }
                do {
                    let content = try String(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
                    step.htmlContent = content
                } catch {
                    fatalError("\(error)")
                }
            }
            if let image = image {
                step.customImage = UIImage(named: image)
                if (step.customImage == nil) {
                    fatalError("Unable to load custom image named \(image)")
                }
            }
            if let animationUrl = animationUrl {
                // try to load a scaled animatiom file first
                var nameWithScaleFactor = animationUrl
                if UIScreen.mainScreen().scale >= 3 {
                    nameWithScaleFactor += "@3x"
                } else {
                    nameWithScaleFactor += "@2x"
                }
                var url = NSBundle.mainBundle().URLForResource(nameWithScaleFactor, withExtension: "m4v")
                do {
                    try url?.checkPromisedItemIsReachableAndReturnError(nil)
                } catch _ {
                    do {
                        url = NSBundle.mainBundle().URLForResource(animationUrl, withExtension: "m4v")
                        try url?.checkPromisedItemIsReachableAndReturnError(nil)
                    } catch _ {
                        fatalError("Unable to load custom animation \(animationUrl)")
                    }
                }
                step.customAnimationURL = url
            }
            
            steps.append(step)
        }
        
        return steps
    }
    
    static func consentSectionTypeFromValue(value: String) -> ORKConsentSectionType {
        if value == kSectionTypeValueOverview { return .Overview }
        else if value == kSectionTypeValuePrivacy { return .Privacy }
        else if value == kSectionTypeValueDataGathering { return .DataGathering }
        else if value == kSectionTypeValueDataUse { return .DataUse }
        else if value == kSectionTypeValueTimeCommitment { return .TimeCommitment }
        else if value == kSectionTypeValueStudySurvey { return .StudySurvey }
        else if value == kSectionTypeValueStudyTasks { return .StudyTasks }
        else if value == kSectionTypeValueWithdrawing { return .Withdrawing }
        else if value == kSectionTypeValueCustom { return .Custom }
        else if value == kSectionTypeValueOnlyInDocument { return .OnlyInDocument }
        else { fatalError("Section Type invalid") }
    }
    
}

