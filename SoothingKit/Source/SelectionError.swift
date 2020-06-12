public enum SelectionError: Error {
    case none
    case multi
}

extension SelectionError {
    public var localizedDescription: String {
        switch self {
        case .none: return "You must have at least 1 selection"
        case .multi: return "You must not have more than 1 selection"
        }
    }
}
