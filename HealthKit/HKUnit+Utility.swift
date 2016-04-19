//
//  HKUnit+Utility.swift
//  DukeCore-iOS
//
//  Created by Mike Revoir on 3/2/16.
//  Copyright © 2016 Duke Institute for Health Innovation. All rights reserved.
//

import Foundation
import HealthKit

extension HKUnit {
    /// The default unit for scalar (non-percent) values. The default is count.
    static func defaultCountUnit() -> HKUnit {
        return HKUnit.countUnit()
    }

    /// The default unit for measuring length. The default is meters.
    static func defaultLengthUnit() -> HKUnit {
        return HKUnit.meterUnit()
    }

    /// The default unit for measuring energy. The default is kilocalories.
    static func defaultEnergyUnit() -> HKUnit {
        return HKUnit.kilocalorieUnit()
    }

    /// The default unit for measuring time. The default is seconds.
    static func defaultTimeUnit() -> HKUnit {
        return HKUnit.secondUnit()
    }

    /// The default count/time unit. The default is count/second.
    static func defaultCountsPerTimeUnit() -> HKUnit {
        return HKUnit(fromString: "count/s")
    }

    /**
     * Returns the default unit for an `HKQuantity` type.
     * - parameters:
     *  - type: the quantity type
     */
    static func defaultUnitForType(type: String) -> HKUnit {
        var unit: HKUnit? = nil

        // Handle types only availalbe in specific platforms
        if #available(iOS 9.3, *) {
            switch type {
            case HKQuantityTypeIdentifierAppleExerciseTime:
                unit = defaultTimeUnit()
            default:
                break
            }
        }

        // Handle types available on all platforms
        if unit == nil {
            switch type {
            case HKQuantityTypeIdentifierActiveEnergyBurned:
                unit = defaultEnergyUnit()
            case HKQuantityTypeIdentifierDistanceCycling:
                unit = defaultLengthUnit()
            case HKQuantityTypeIdentifierDistanceWalkingRunning:
                unit = defaultLengthUnit()
            case HKQuantityTypeIdentifierHeartRate:
                unit = defaultCountsPerTimeUnit()
            case HKQuantityTypeIdentifierStepCount:
                unit = defaultCountUnit()
            default:
                fatalError("unknown type: \(type)")
            }
        }
        return unit!
    }
}