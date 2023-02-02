import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_simplified/database.dart';

// user state for the app
final userProvider = FutureProvider<String>((ref) async {
  // if (str == "Kola") {
  //   return "Good Kola";
  // }
  return ref.read(databaseProvider).getUserData();
});

// counter state notifier for the app
final counterController =
    StateNotifierProvider<CounterNotifier, int>((ref) => CounterNotifier());

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void add() {
    state = state + 1;
  }

  void subtract() {
    state = state - 1;
  }
}

// async state notifier provider for state that doesn't change in real time
final counterAsyncController =
    StateNotifierProvider<CounterAsyncNotifier, AsyncValue<int>>(
        (ref) => CounterAsyncNotifier(ref.read));

class CounterAsyncNotifier extends StateNotifier<AsyncValue<int>> {
  CounterAsyncNotifier(this.read) : super(const AsyncLoading()) {
    _init();
  }

  final dynamic read;

  Future<void> _init() async {
    await read(databaseProvider).initDatabase();
    state = const AsyncData(0);
  }

  Future<void> add() async {
    state = const AsyncLoading();
    int count = await read(databaseProvider).increment();
    state = AsyncData(count);
  }

  Future<void> subtract() async {
    state = const AsyncLoading();
    int count = await read(databaseProvider).decrement();
    state = AsyncData(count);
  }
}
