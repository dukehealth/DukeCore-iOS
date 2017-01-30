
import CareKit
import ResearchKit

/**
 An `Assessment` that is configured by a JSON task file.
 */
class SmartAssessment: Assessment {
    var identifier: String = ""
    var name: String?
    var summary: String?
    var learnMoreHtml: String?
    var taskFilename: String?
    
    func carePlanActivity(withStartDate startDate: DateComponents, schedule: OCKCareSchedule) -> OCKCarePlanActivity {
        let activity = OCKCarePlanActivity.assessment(
            withIdentifier: identifier,
            groupIdentifier: nil,
            title: name!,
            text: summary,
            tintColor: UIColor.dukeHealthBlue,
            resultResettable: true,
            schedule: schedule,
            userInfo: nil
        )
        return activity
    }
    
    func task() -> ORKTask {
        guard let taskFilename = taskFilename else {
            assertionFailure("taskfilename missing for \(identifier)")
            return ORKOrderedTask.init(identifier: identifier, steps: nil)
        }
        
        let filePath: String? = Bundle.main.path(forResource: taskFilename, ofType:"json")
        guard FileManager.default.fileExists(atPath: filePath!) else {
            fatalError("unable to find \(filePath)")
        }
        let jsonData = try! NSData(contentsOfFile: filePath!, options: NSData.ReadingOptions.uncached)
        var surveyStepsAndNavRules = [(ORKStep, ORKStepNavigationRule?)]()
        var surveySteps = [ORKStep]()
        var surveyNavRules = [(ORKStepNavigationRule, String)]()

        do {
            let object = try JSONSerialization.jsonObject(with: jsonData as Data, options: .allowFragments)
            if let jsonResults = object as? [String: AnyObject] {
                identifier = (jsonResults["identifier"] as? String)!
                let jsonElements = jsonResults["elements"] as? [Dictionary<String,AnyObject>]
                surveyStepsAndNavRules = DMJSONSerialization.surveySectionsFromJSONObject(json: jsonElements!)
            }
        } catch {
            fatalError("Unable to parse survey JSON in \(filePath)")
        }
        
        for surveyStepAndNavRules in surveyStepsAndNavRules {
            surveySteps.append(surveyStepAndNavRules.0)
            
            if let navRule = surveyStepAndNavRules.1 {
                let triggerStep = surveyStepAndNavRules.0.identifier
                surveyNavRules.append((navRule, triggerStep))
            }
        }

        let task = ORKNavigableOrderedTask(identifier: "task", steps: surveySteps)
        for navRule in surveyNavRules {
            task.setNavigationRule(navRule.0, forTriggerStepIdentifier: navRule.1)
        }
        return task
    }
}
