//
//  File.swift
//  
//
//  Created by Jerrywang on 2023/4/1.
//

import Foundation

public struct Pin: Equatable {
    public struct Bit: Identifiable, Equatable {
        let index: Int
        public private(set) var character: Character?
        
        public var id: Int { index }
        
        init(
            index: Int
        ) {
            self.index = index
            self.character = nil
        }
        
        mutating func update(character: Character) {
            self.character = character
        }
        
        mutating func reset() {
            self.character = nil
        }
    }
    
    public enum Length: Int, Equatable {
        case four = 4
        case six = 6
        case eight = 8
    }
    
    public private(set) var bits: [Bit] = []
    
    let length: Length
    
    public init(length: Length) {
        self.length = length
        self.bits = initialBits(with: length)
    }
    
    public var value: String {
        get {
            bits.map(\.character).filterNil().map(String.init).reduce("", +)
        }
        set {
            reset()
            let characters = newValue.map { $0 }
            characters.forEach { input($0) }
        }
    }
    
    public var isDone: Bool {
        bits.filter { $0.character != nil }.count == length.rawValue
    }
    
    private func initialBits(with length: Length) -> [Bit] {
        (0..<length.rawValue).map(Bit.init(index:))
    }
    
    private var currentCount: Int {
        bits.map(\.character).compactMap { $0 }.count
    }
    
    mutating func input(_ character: Character) {
        guard currentCount < bits.count else { return }
        bits[currentCount].update(character: character)
    }
    
    mutating func reset() {
        bits = initialBits(with: length)
    }
}
