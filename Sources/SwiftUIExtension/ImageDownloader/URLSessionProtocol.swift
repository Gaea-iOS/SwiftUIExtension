//
//  File.swift
//  
//
//  Created by 王小涛 on 2023/11/16.
//

import Foundation

public protocol URLSessionProtocol {
    func dataTask(with request: URLRequest) -> URLSessionDataTask
    func dataTask(with url: URL) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}
