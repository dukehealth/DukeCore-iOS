//
//  HKUnit+Utility.swift
//  apple
//
//  Created by Mike Revoir on 3/2/16.
//  Copyright © 2016 Duke Institute for Health Innovation. All rights reserved.
//

import Foundation
import HealthKit

extension HKUnit {
    static func defaultCountUnit() -> HKUnit {
        return HKUnit.countUnit()
    }
    static func defaultDistanceUnit() -> HKUnit {
        return HKUnit.meterUnit()
    }
    static func defaultEnergyUnit() -> HKUnit {
        return HKUnit.kilocalorieUnit()
    }
    static func defaultUnitForType(type: String) -> HKUnit {
        var unit: HKUnit?
        switch type {
        case HKQuantityTypeIdentifierActiveEnergyBurned:
            unit = defaultEnergyUnit()
            break
        case HKQuantityTypeIdentifierDistanceCycling:
            unit = defaultDistanceUnit()
            break
        case HKQuantityTypeIdentifierDistanceWalkingRunning:
            unit = defaultDistanceUnit()
            break
        case HKQuantityTypeIdentifierStepCount:
            unit = defaultCountUnit()
            break
        default:
            fatalError("unknown type: \(type)")
        }
        return unit!
    }
}