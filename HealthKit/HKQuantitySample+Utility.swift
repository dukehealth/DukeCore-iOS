//
//  HKQuantitySample+Utility.swift
//  apple
//
//  Created by Mike Revoir on 3/2/16.
//  Copyright © 2016 Duke Institute for Health Innovation. All rights reserved.
//

import Foundation
import HealthKit

extension HKQuantitySample {
    func stepCount() -> Double {
        let unit = HKUnit.defaultCountUnit()
        return self.quantity.doubleValueForUnit(unit)
    }
    
    func kcalCount() -> Double {
        let unit = HKUnit.defaultEnergyUnit()
        return self.quantity.doubleValueForUnit(unit)
    }
    
    func distance() -> Double {
        let unit = HKUnit.defaultDistanceUnit()
        return self.quantity.doubleValueForUnit(unit)
    }
}
