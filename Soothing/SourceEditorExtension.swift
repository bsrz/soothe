import Foundation
import XcodeKit

class SourceEditorExtension: NSObject, XCSourceEditorExtension {
    
    func extensionDidFinishLaunching() {
        print(#function)
        // If your extension needs to do any work at launch, implement this optional method.
    }
    
    var commandDefinitions: [[XCSourceEditorCommandDefinitionKey: Any]] {
        return [
            [
                .classNameKey: "Soothing.AlignSourceEditorCommand",
                .identifierKey: "Soothing.AlignSourceEditorCommand",
                .nameKey: "Align"
            ],
            [
                .classNameKey: "Soothing.InterpolateSourceEditorCommand",
                .identifierKey: "Soothing.InterpolateSourceEditorCommand",
                .nameKey: "Interpolate"
            ],
            [
                .classNameKey: "Soothing.SortSourceEditorCommand",
                .identifierKey: "Soothing.SortSourceEditorCommand",
                .nameKey: "Sort"
            ]
        ]
    }
    
}
