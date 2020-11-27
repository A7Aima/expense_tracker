import 'package:sembast/sembast.dart';
import '../database/transaction_database.dart';
import '../models/transaction.dart' as tx;

class TransactionDAO {
  static const String TRANSACTION_STORE_NAME = "transaction";

  final _transactionStore = intMapStoreFactory.store(TRANSACTION_STORE_NAME);

  Future<Database> get _db async => await TransactionDatabase.instance.database;
  Future<Database> get closeDb async =>
      await TransactionDatabase.instance.closeDatabase();

  Future insert(tx.Transaction transaction) async {
    await _transactionStore.add(await _db, transaction.toMap());
  }

  Future delete(tx.Transaction transaction) async {
    final finder = Finder(filter: Filter.byKey(transaction.id));
    await _transactionStore.delete(
      await _db,
      finder: finder,
    );
  }

  Future<List<tx.Transaction>> getAllSortedByTitle() async {
    // Finder object can also sort data.
    final finder = Finder(sortOrders: [
      SortOrder('title'),
    ]);

    final recordSnapshots = await _transactionStore.find(
      await _db,
      finder: finder,
    );

    return recordSnapshots.map((txr) {
      final transaction = tx.Transaction.fromMap(txr.value);
      transaction.id = txr.key;
      //print("transaction.title");
      return transaction;
    }).toList();
  }
}
