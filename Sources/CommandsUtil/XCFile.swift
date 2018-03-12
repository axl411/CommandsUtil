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
    
    public static func target(in pwd: Folder) -> File? {
        if let xcWorkspace = xcWorkspaceFile(in: pwd) {
            return xcWorkspace
        }

        if let xcodeProj = xcodeProjFile(in: pwd) {
            return xcodeProj
        }
        
        return nil
    }

    private static func xcWorkspaceFile(in folder: Folder) -> File? {
        return file(in: folder, fileExtension: xcworkspace)
    }

    private static func xcodeProjFile(in folder: Folder) -> File? {
        return file(in: folder, fileExtension: xcodeproj)
    }

    private static func file(in folder: Folder, fileExtension: String) -> File? {
        if let rootXCWorkspace = folder.files.first(where: filter(forTargetExtension: fileExtension)) {
            return rootXCWorkspace
        }

        for subFolder in folder.subfolders {
            if let subFolderXCWorkspace = subFolder.files.first(where: filter(forTargetExtension: fileExtension)) {
                return subFolderXCWorkspace
            }
        }

        return nil
    }
    
    private static func filter(forTargetExtension targetExtension: String) -> (File) -> Bool {
        return { (file: File) in
            guard let fileExtension = file.extension else { return false }
            return fileExtension == targetExtension
        }
    }
}
