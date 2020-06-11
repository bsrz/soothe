import Foundation
import XcodeKit

class SourceEditorExtension: NSObject, XCSourceEditorExtension {

    // MARK: - Properties
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

    // MARK: - Lifecycle
    func extensionDidFinishLaunching() {
        print(#function)
    }
}
