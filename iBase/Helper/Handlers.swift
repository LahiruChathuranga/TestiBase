//
//  Handlers.swift
//  iBase
//
//  Created by Lahiru Chathuranga on 6/20/19.
//  Copyright © 2019 ElegantMedia. All rights reserved.
//

import Foundation

public typealias actionHandler = (_ status: Bool, _ message: String) -> ()
public typealias completionHandler = (_ status: Bool, _ code: Int, _ message: String) -> ()


extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
