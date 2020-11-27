import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class TransactionDatabase {
  //Singleton instance
  static final TransactionDatabase _singleton = TransactionDatabase._();

  //singleton accessor
  static TransactionDatabase get instance => _singleton; // this will be the way to access this class

  // Completer is used for transforming synchronous code into asynchronous code.
  Completer<Database> _dbOpenCompleter;

  TransactionDatabase._();

  // Database object accessor
  Future<Database> get database async {
    // If completer is null, TransactionDatabaseClass is newly instantiated, so database is not yet opened
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      // Calling _openDatabase will also complete the completer with database instance
      _openDatabase();
    }
    // If the database is already opened, awaiting the future will happen instantly.
    // Otherwise, awaiting the returned future will take some time - until complete() is called
    // on the Completer in _openDatabase() below.
    return _dbOpenCompleter.future;
  }

  Future _openDatabase() async {
    // Get a platform-specific directory where persistent app data can be stored
    final appDocumentDir = await getApplicationDocumentsDirectory();
    // Path with the form: /platform-specific-directory/transactionDatabase.db
    final dbPath = join(appDocumentDir.path, 'transactionDatabase.db');

    final database = await databaseFactoryIo.openDatabase(dbPath);
    // Any code awaiting the Completer's future will now start executing
    _dbOpenCompleter.complete(database);
  }

  Future closeDatabase() async {
    Database db = await _dbOpenCompleter.future;
    await db.close();
    // // for deleting database
    // var res = await databaseFactoryIo.deleteDatabase(db.path);
    // print(res);
    //_dbOpenCompleter = null;
    // await database;
  }
}
