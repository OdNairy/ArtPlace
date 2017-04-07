//
//  String+extension.swift
//  ArtPlace
//
//  Created by Ira on 4/6/17.
//  Copyright © 2017 Ira. All rights reserved.
//

import Foundation

//MARK: - Class to String
extension String {
    
    static func classToString(_ classObj: AnyClass) -> String {
        return NSStringFromClass(classObj).components(separatedBy: ".").last! as String
    }
    
}

