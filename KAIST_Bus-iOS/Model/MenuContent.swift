//
//  MenuContent.swift
//  KAIST_Bus-iOS
//
//  Created by Mukhtar Kussaiynbekov on 11/5/20.
//
import SwiftyMenu

extension String: SwiftyMenuDisplayable {
    public var retrievableValue: Any {
        return self
    }
    
    public var displayableValue: String {
        return self
    }
}
