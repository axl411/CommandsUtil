//
//  XCFileTests.swift
//  CommandsUtilPackageDescription
//
//  Created by 顾超 on 10/03/2018.
//

import XCTest
@testable import CommandsUtil
import Files
import Foundation

class XCFileTests: XCTestCase {
    static let workingDirName = "TextXCFile"
    lazy var workingDir: Folder = {
        let folder = try! Folder.temporary.createSubfolder(named: XCFileTests.workingDirName)
        print("\(String(describing: XCFileTests.self)): testing dir: \(folder.path)")
        return folder
    }()
    let example = "example"
    lazy var xcodeprojFileName = (example as NSString).appendingPathExtension(XCFile.xcodeproj)!
    lazy var xcworkspaceFileName = (example as NSString).appendingPathExtension(XCFile.xcworkspace)!
    
    override
    static func setUp() {
        do {
            let workingDir = try Folder(path: (Folder.temporary.path as NSString).appendingPathComponent(workingDirName))
            try workingDir.delete()
        }
        catch {
        
        }
    }
    
    func testXCFileFindXCodeProjInPWD() {
        _ = try! workingDir.createSubfolder(named: xcodeprojFileName)
        
        XCTAssertEqual(
            XCFile.target(in: workingDir)!.path,
            (workingDir.path as NSString).appendingPathComponent(xcodeprojFileName).appending("/")
        )
    }
    
    func testXCFileFindXCWorkspaceInPWD() {
        _ = try! workingDir.createSubfolder(named: xcodeprojFileName)
        _ = try! workingDir.createSubfolder(named: xcworkspaceFileName)
        
        XCTAssertEqual(
            XCFile.target(in: workingDir)!.path,
            (workingDir.path as NSString).appendingPathComponent(xcworkspaceFileName).appending("/")
        )
    }
    
    func testXCFileFindXCodeProjInSubfolder() {
        let subDir = try! workingDir.createSubfolder(named: "subDir")
        _ = try! subDir.createSubfolder(named: xcodeprojFileName)
        
        XCTAssertEqual(
            XCFile.target(in: workingDir)!.path,
            (subDir.path as NSString).appendingPathComponent(xcodeprojFileName).appending("/")
        )
    }
    
    func testXCFileFindXCWorkspaceInSubfolder() {
        let subDir = try! workingDir.createSubfolder(named: "subDir")
        _ = try! subDir.createSubfolder(named: xcodeprojFileName)
        _ = try! subDir.createSubfolder(named: xcworkspaceFileName)
        
        XCTAssertEqual(
            XCFile.target(in: workingDir)!.path,
            (subDir.path as NSString).appendingPathComponent(xcworkspaceFileName).appending("/")
        )
    }

    func testXCFileFindXCWorkspaceInPWDAndSubfolder() {
        _ = try! workingDir.createSubfolder(named: xcodeprojFileName)
        _ = try! workingDir.createSubfolder(named: xcworkspaceFileName)
        let subDir = try! workingDir.createSubfolder(named: "subDir")
        _ = try! subDir.createSubfolder(named: xcodeprojFileName)
        _ = try! subDir.createSubfolder(named: xcworkspaceFileName)

        XCTAssertEqual(
            XCFile.target(in: workingDir)!.path,
            (workingDir.path as NSString).appendingPathComponent(xcworkspaceFileName).appending("/")
        )
    }

    func testXCFileFindXCWorkspaceInPWDAndSubfolder2() {
        _ = try! workingDir.createSubfolder(named: xcodeprojFileName)
        let subDir = try! workingDir.createSubfolder(named: "subDir")
        _ = try! subDir.createSubfolder(named: xcodeprojFileName)
        _ = try! subDir.createSubfolder(named: xcworkspaceFileName)

        XCTAssertEqual(
            XCFile.target(in: workingDir)!.path,
            (subDir.path as NSString).appendingPathComponent(xcworkspaceFileName).appending("/")
        )
    }
    
    override
    func tearDown() {
        try! workingDir.delete()
    }
}
