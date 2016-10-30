//
//  SourceEditorExtension.swift
//  Soothing
//
//  Created by Benoit Sarrazin on 2016-10-30.
//  Copyright © 2016 Berzerker IO. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorExtension: NSObject, XCSourceEditorExtension {
    
    
    func extensionDidFinishLaunching() {
        print(#function)
        // If your extension needs to do any work at launch, implement this optional method.
    }
    
    
    /*
    var commandDefinitions: [[XCSourceEditorCommandDefinitionKey: Any]] {
        // If your extension needs to return a collection of command definitions that differs from those in its Info.plist, implement this optional property getter.
        return []
    }
    */
    
}
