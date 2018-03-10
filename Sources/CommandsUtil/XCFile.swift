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
    
    public static func target(in pwd: Folder) -> String? {
        for folder in pwd.subfolders {
            if let xcFile = xcFile(in: folder) {
                return xcFile
            }
        }
        
        if let xcFile = xcFile(in: pwd) {
            return xcFile
        }
        
        return nil
    }
    
    private static func xcFile(in folder: Folder) -> String? {
        if let rootXCWorkspace = folder.subfolders.first(where: filter(forTargetExtension: xcworkspace)) {
            return rootXCWorkspace.path
        }
        
        if let rootXCodeProj = folder.subfolders.first(where: filter(forTargetExtension: xcodeproj)) {
            return rootXCodeProj.path
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
