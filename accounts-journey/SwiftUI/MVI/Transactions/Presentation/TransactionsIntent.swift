public protocol TransactionsIntent {}

public struct ViewAppearedIntent: TransactionsIntent { public init() {}}
public struct RefreshIntent: TransactionsIntent { public init() {} }
public struct NewTransactionIntent: TransactionsIntent {public init() {} }
