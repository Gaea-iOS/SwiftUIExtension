// Collection+Extension.swift
// Copyright (c) 2023 Nostudio
// Created by Jerry X T Wang on 2023/5/30.

import Foundation

public extension Collection {
    func filterNil<Wrapped>() -> [Wrapped]
        where Element == Wrapped?
    {
        compactMap { $0 }
    }
}
