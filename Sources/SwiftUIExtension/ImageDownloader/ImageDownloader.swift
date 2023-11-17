////
////  File.swift
////  
////
////  Created by 王小涛 on 2023/11/16.
////
//
//import Foundation
//import SwiftUI
//
//actor ImageDownloader {
//    private enum CacheEntry{
//        case inProgress(Task<Image, Error>)
//        case ready(Image)
//    }
//        
//    private var entries: [URL: CacheEntry] = [:]
//    
//    func image(from url: URL) async throws -> Image? {
//        if let cached = entries[url] {
//            switch cached {
//            case .inProgress(let task):
//                return try await task.value
//            case .ready(let image):
//                return image
//            }
//        }
//        
//        let task = Task {
//            try await downloadImage(from: url)
//        }
//        
//        entries[url] = .inProgress(task)
//        
//        do {
//            let image = try await task.value
//            entries[url] = .ready(image)
//            return image
//        } catch {
//            entries[url] = nil
//            throw error
//        }
//    }
//    
//    func downloadImage(from url: URL) async throws -> Image {
//        
//    }
//}
