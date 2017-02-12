import Foundation
import XcodeKit

class AlignSourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) {
        
        // [BS] Oct 30, 2016
        // Credit for this extension goes to https://github.com/tid-kijyun/XcodeSourceEditorExtension-Alignment
        // I have simply modified the code to make it more readable and more accurate.
        
        guard let selection = invocation.buffer.selections.firstObject as? XCSourceTextRange else {
            let userInfo = [NSLocalizedDescriptionKey: "This extension only works with a selection."]
            let error = NSError(domain: "\(#file) -> \(#function)", code: #line, userInfo: userInfo)
            completionHandler(error)
            return
        }
        
        var regex: NSRegularExpression?
        do {
            regex = try NSRegularExpression(pattern: "[^+^%^*^^^<^>^&^|^?^=^-](\\s*)(=)[^=]", options: .caseInsensitive)
        } catch _ {
            completionHandler(NSError(domain: "SampleExtension", code: -1, userInfo: [NSLocalizedDescriptionKey: ""]))
            return
        }
        
        let alignPosition = invocation.buffer.lines.enumerated().map { i, line -> Int in
            guard
                i >= selection.start.line && i <= selection.end.line,
                let line = line as? String,
                let result = regex?.firstMatch(in: line, options: .reportProgress, range: NSRange(location: 0, length: line.characters.count)) else {
                    return 0
            }
            return result.rangeAt(1).location
        }.max()
        
        guard let position = alignPosition else {
            completionHandler(nil)
            return
        }
        
        for index in selection.start.line ... selection.end.line {
            guard
                let line = invocation.buffer.lines[index] as? String,
                let result = regex?.firstMatch(in: line, options: .reportProgress, range: NSRange(location: 0, length: line.characters.count))
                else {
                    continue
            }
            
            let range = result.rangeAt(2)
            if range.location != NSNotFound {
                let repeatCount = position - range.location + 1
                if repeatCount != 0 {
                    let whiteSpaces = String(repeating: " ", count: abs(repeatCount))
                    if repeatCount > 0 {
                        invocation.buffer.lines.replaceObject(at: index, with: line.replacingOccurrences(of: "=", with: "\(whiteSpaces)="))
                    } else {
                        invocation.buffer.lines.replaceObject(at: index, with: line.replacingOccurrences(of: "\(whiteSpaces)=", with: "="))
                    }
                }
            }
        }
        
        completionHandler(nil)
    }
    
}
