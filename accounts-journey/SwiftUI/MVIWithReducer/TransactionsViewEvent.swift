enum TransactionsViewEvent{
    case viewAppeared
    case refresh
    case processTransactionsResponse(Result<[TransactionDTO], TransactionClientError>)
    case newTransaction
}
