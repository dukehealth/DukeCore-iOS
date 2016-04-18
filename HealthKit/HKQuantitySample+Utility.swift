//
//  HKQuantitySample+Utility.swift
//  DukeCore-iOS
//
//  Created by Mike Revoir on 3/2/16.
//  Copyright © 2016 Duke Institute for Health Innovation. All rights reserved.
//

import Foundation
import HealthKit

extension HKQuantitySample {
    /**
     * Returns the count unit value for an `HKQuantitySample`.
     * This method assumes that the default unit type was used when constructing the sample.
     */
    func stepCount() -> Double {
        let unit = HKUnit.defaultCountUnit()
        return self.quantity.doubleValueForUnit(unit)
    }

    /**
     * Returns the energy unit value for an `HKQuantitySample`.
     * This method assumes that the default unit type was used when constructing the sample.
     */
    func kcalCount() -> Double {
        let unit = HKUnit.defaultEnergyUnit()
        return self.quantity.doubleValueForUnit(unit)
    }

    /**
     * Returns the length unit value for an `HKQuantitySample`.
     * This method assumes that the default unit type was used when constructing the sample.
     */
    func length() -> Double {
        let unit = HKUnit.defaultLengthUnit()
        return self.quantity.doubleValueForUnit(unit)
    }

    /**
     * Returns the time unit value for an `HKQuantitySample`.
     * This method assumes that the default unit type was used when constructing the sample.
     */
    func time() -> Double {
        let unit = HKUnit.defaultTimeUnit()
        return self.quantity.doubleValueForUnit(unit)
    }
}
