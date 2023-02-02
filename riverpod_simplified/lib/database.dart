import 'package:flutter_riverpod/flutter_riverpod.dart';

final databaseProvider = Provider<FakeDatabase>((ref) => FakeDatabase());

class FakeDatabase {
  Future<String> getUserData() {
    return Future.delayed(const Duration(seconds: 3), () {
      return "Kola";
    });
  }

  late int fakeDatabase;

  Future<void> initDatabase() async {
    fakeDatabase = 0;
  }

  Future<int> increment() async {
    return Future.delayed(const Duration(seconds: 3), () {
      return fakeDatabase = fakeDatabase + 1;
    });
  }

  Future<int> decrement() async {
    return Future.delayed(const Duration(seconds: 3), () {
      return fakeDatabase = fakeDatabase - 1;
    });
  }
}
