//
//  FileManager-DocumentsDirectory.swift
//  BucketList
//
//  Created by Enrico Sousa Gollner on 04/03/23.
//

import Foundation

extension FileManager{
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
