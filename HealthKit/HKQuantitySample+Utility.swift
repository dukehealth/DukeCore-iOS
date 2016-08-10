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
    func countValue() -> Double {
        let unit = HKUnit.defaultCountUnit()
        return self.quantity.doubleValueForUnit(unit)
    }

    /**
     * Returns the energy unit value for an `HKQuantitySample`.
     * This method assumes that the default unit type was used when constructing the sample.
     */
    func energyValue() -> Double {
        let unit = HKUnit.defaultEnergyUnit()
        return self.quantity.doubleValueForUnit(unit)
    }

    /**
     * Returns the length unit value for an `HKQuantitySample`.
     * This method assumes that the default unit type was used when constructing the sample.
     */
    func lengthValue() -> Double {
        let unit = HKUnit.defaultLengthUnit()
        return self.quantity.doubleValueForUnit(unit)
    }
    
    /**
     * Returns the mass unit value for an `HKQuantitySample`.
     * This method assumes that the default unit type was used when constructing the sample.
     */
    func massValue() -> Double {
        let unit = HKUnit.defaultMassUnit()
        return self.quantity.doubleValueForUnit(unit)
    }
    
    /**
     * Returns the time unit value for an `HKQuantitySample`.
     * This method assumes that the default unit type was used when constructing the sample.
     */
    func timeValue() -> Double {
        let unit = HKUnit.defaultTimeUnit()
        return self.quantity.doubleValueForUnit(unit)
    }

    /**
     * Returns the count/time unit value for an `HKQuantitySample`.
     * This method assumes that the default unit type was used when constructing the sample.
     */
    func countsPerTimeValue() -> Double {
        let unit = HKUnit.defaultCountsPerTimeUnit()
        return self.quantity.doubleValueForUnit(unit)
    }
}
