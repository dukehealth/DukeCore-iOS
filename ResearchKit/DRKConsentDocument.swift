//
//  DRKConsentDocument.swift
//  DukeCore-iOS
//
//  Created by Mike Revoir on 2/12/16.
//

import ResearchKit

extension ORKConsentDocument {
    convenience init(path: String) {
        guard !(path ?? "").isEmpty else {
            fatalError("path is required")
        }
        guard NSFileManager.defaultManager().fileExistsAtPath(path) else {
            fatalError("unable to find \(path)")
        }
        self.init()
        do {
            let jsonData = try NSData(contentsOfFile: path, options: [])
            let jsonResults = try NSJSONSerialization.JSONObjectWithData(jsonData, options: []) as? NSDictionary
            let json = jsonResults!["sections"] as! [Dictionary<String,String>]
            sections = DRKSerialization.consentSectionsFromJSONObject(json)
            
            if jsonResults!["documentProperties"]?["signatureRequired"] as? String == "true" {
                let signatoryTitle = jsonResults!["documentProperties"]!["signatoryTitle"] as? String
                let dateFormatString = jsonResults!["documentProperties"]!["signatureDateFormatString"] as? String
                
                addSignature(ORKConsentSignature(forPersonWithTitle: signatoryTitle, dateFormatString: dateFormatString, identifier: "drk_signature"))
            }
        } catch _ {
            fatalError("unable to parse JSON in \(path)")
        }
    }
}