public enum SelectionError: Error {
    case empty
    case multi
}

extension SelectionError {
    public var localizedDescription: String {
        switch self {
        case .empty: return "Your selection cannot be empty"
        case .multi: return "You must not have more than 1 selection"
        }
    }
}
