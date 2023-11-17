//
//  File.swift
//  
//
//  Created by 王小涛 on 2023/11/16.
//

import Foundation

public protocol URLResponseCaching {
    func removeCachedResponse(for request: URLRequest)
    func storeCachedResponse(_ cachedResponse: CachedURLResponse, for request: URLRequest)
    func cachedResponse(for request: URLRequest) -> CachedURLResponse?
}

extension URLCache: URLResponseCaching {}
