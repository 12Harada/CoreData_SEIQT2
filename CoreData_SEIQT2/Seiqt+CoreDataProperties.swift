//
//  Seiqt+CoreDataProperties.swift
//  CoreData_SEIQT2
//
//  Created by Harada Hiroaki on 2019/02/03.
//  Copyright © 2019 Harada Hiroaki. All rights reserved.
//
//

import Foundation
import CoreData


extension Seiqt {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Seiqt> {
        return NSFetchRequest<Seiqt>(entityName: "Seiqt")
    }

    @NSManaged public var shrky_no: String?
    @NSManaged public var seiq_gk: Int16
    @NSManaged public var rkn_hsse_ymd: NSDate?

}
