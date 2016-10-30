//
//  SortSourceEditorCommand.swift
//  Soothe
//
//  Created by Benoit Sarrazin on 2016-10-30.
//  Copyright © 2016 Berzerker IO. All rights reserved.
//

import Foundation
import XcodeKit

class SortSourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        guard let selection = invocation.buffer.selections.firstObject as? XCSourceTextRange else {
            let userInfo = [NSLocalizedDescriptionKey: "This extension only works with a selection."]
            let error = NSError(domain: "\(#file) -> \(#function)", code: #line, userInfo: userInfo)
            completionHandler(error)
            return
        }
        
        let allLines = invocation.buffer.lines.flatMap { $0 as? String }
        let lines = allLines[selection.start.line...selection.end.line].sorted()
        let range = NSMakeRange(selection.start.line, selection.end.line - selection.start.line + 1)
        invocation.buffer.lines.replaceObjects(in: range, withObjectsFrom: lines)
        completionHandler(nil)
    }
    
}
