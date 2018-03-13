//
//  XCFile.swift
//  CommandsUtilPackageDescription
//
//  Created by 顾超 on 10/03/2018.
//

import Foundation
import Files

public struct XCFile {
    public static let xcodeproj = "xcodeproj"
    public static let xcworkspace = "xcworkspace"
    public static let playground = "playground"
    
    public static func target(in pwd: Folder) -> Folder? {
        if let xcWorkspace = xcWorkspaceFile(in: pwd) {
            return xcWorkspace
        }

        if let xcodeProj = xcodeProjFile(in: pwd) {
            return xcodeProj
        }
        
        return nil
    }

    private static func xcWorkspaceFile(in folder: Folder) -> Folder? {
        return xcFile(in: folder, fileExtension: xcworkspace)
    }

    private static func xcodeProjFile(in folder: Folder) -> Folder? {
        return xcFile(in: folder, fileExtension: xcodeproj)
    }

    private static func xcFile(in folder: Folder, fileExtension: String) -> Folder? {
        if let xcFile = folder.subfolders.first(where: filter(forTargetExtension: fileExtension)) {
            return xcFile
        }

        for subFolder in folder.subfolders {
            guard subFolder.extension != xcodeproj
                && subFolder.extension != xcworkspace
                && subFolder.extension != playground
                else { continue }
            if let subFolderXCFile = subFolder.subfolders.first(where: filter(forTargetExtension: fileExtension)) {
                return subFolderXCFile
            }
        }

        return nil
    }
    
    private static func filter(forTargetExtension targetExtension: String) -> (Folder) -> Bool {
        return { (folder: Folder) in
            guard let fileExtension = folder.extension else { return false }
            return fileExtension == targetExtension
        }
    }
}
