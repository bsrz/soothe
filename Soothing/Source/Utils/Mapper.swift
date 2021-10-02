public typealias FailableMapper<A, B> = Mapper<A, Result<B, Error>>

public struct Mapper<Input, Output> {

    // MARK: - Properties
    private let map: (Input) -> Output

    // MARK: - Initialization
    public init(_ map: @escaping (Input) -> Output) {
        self.map = map
    }
    public init<Success>(_ map: @escaping (Input) throws -> Success) where Output == Result<Success, Error> {
        self.map = { input in
            return Result<Success, Error>(catching: { try map(input) })
        }
    }

    // MARK: - Mapping
    public func map(_ input: Input) -> Output {
        return map(input)
    }
    public func map<Success>(_ input: Input) throws -> Success where Output == Result<Success, Error> {
        return try map(input).get()
    }
}
