//
//  Extensions.swift
//  MergePublisher
//
//  Created by Sraavan Chevireddy on 03/02/23.
//

import Foundation

extension Collection {

    func unfoldSubSequences(limitedTo maxLength: Int) -> UnfoldSequence<SubSequence,Index> {
        sequence(state: startIndex) { start in
            guard start < endIndex else { return nil }
            let end = index(start, offsetBy: maxLength, limitedBy: endIndex) ?? endIndex
            defer { start = end }
            return self[start..<end]
        }
    }

    func every(n: Int) -> UnfoldSequence<Element,Index> {
        sequence(state: startIndex) { index in
            guard index < endIndex else { return nil }
            defer { let _ = formIndex(&index, offsetBy: n, limitedBy: endIndex) }
            return self[index]
        }
    }

    var pairs: [SubSequence] { .init(unfoldSubSequences(limitedTo: 2)) }
}

extension StringProtocol where Self: RangeReplaceableCollection {

    mutating func insert<S: StringProtocol>(separator: S, every n: Int) {
        for index in indices.every(n: n).dropFirst().reversed() {
            insert(contentsOf: separator, at: index)
        }
    }

    func inserting<S: StringProtocol>(separator: S, every n: Int) -> Self {
        .init(unfoldSubSequences(limitedTo: n).joined(separator: separator))
    }
}

extension String
{
   func group(by groupSize:Int=3, separator:String="-") -> String
   {
      if count <= groupSize   { return self }

      let splitSize  = min(max(2, count-2) , groupSize)
      let splitIndex = index(startIndex, offsetBy:splitSize)

      return substring(to:splitIndex)
           + separator
           + substring(from:splitIndex).group(by:groupSize, separator:separator)
   }
}
//