//
//  HTMLAttributedString.swift
//  PodcastsFeed
//
//  Created by Nav on 28/04/23.
//

import Foundation
extension String {
    func htmlAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }

        return try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil
        )
    }
}
