//
//  Collection+Extension.swift
//  TestTaskStarLine
//
//  Created by Юрий Яковлев on 04.09.2024.
//

import Foundation

extension Collection where Index == Int {
    func items(at index: Index) -> (previous: Element, current: Element, next: Element) {
        let previous = self[index == 0 ? count - 1 : index - 1]
        let current = self[index]
        let next = self[(index + 1) % count]
        return (previous, current, next)
    }
}
