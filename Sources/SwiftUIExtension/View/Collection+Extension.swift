//
//  File.swift
//  
//
//  Created by Jerrywang on 2023/4/1.
//

import Foundation

extension Collection {
    public func filterNil<Wrapped>() -> [Wrapped]
    where Element == Optional<Wrapped>
    {
        compactMap { $0 }
    }
}
