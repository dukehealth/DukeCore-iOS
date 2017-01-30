//
//  DRKQuizStep.swift
//  cancercoach
//
//  Created by Harrison Suh on 7/20/16.
//  Copyright © 2016 DIHI. All rights reserved.
//

import UIKit
import ResearchKit

class DRKQuizStep: ORKStep {
    
    // MARK: Properties
    
    var quizQuestionText:       String?
    var expectedAnswer:         Bool?
    
    var positiveFeedbackText:   String?
    var negativeFeedbackText:   String?
    
    // MARK: Initialization
    
    override init(identifier: String) {
        super.init(identifier: identifier)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    static func stepViewControllerClass() -> DRKQuizStepViewController.Type {
        return DRKQuizStepViewController.self
    }
 */
}
