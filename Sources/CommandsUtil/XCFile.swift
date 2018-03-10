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
    
    private static func xcFile(in folder: Folder) -> File? {
        if let rootXCWorkspace = folder.files.first(where: filter(forTargetExtension: xcworkspace)) {
            return rootXCWorkspace
        }
        
        if let rootXCodeProj = folder.files.first(where: filter(forTargetExtension: xcodeproj)) {
            return rootXCodeProj
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
