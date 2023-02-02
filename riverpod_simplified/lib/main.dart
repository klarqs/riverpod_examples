import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_simplified/providers.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riverpod Simplified"),
      ),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * .2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Consumer(
                  builder: (
                    BuildContext context,
                    WidgetRef ref,
                    Widget? child,
                  ) {
                    /// when method
                    // return ref.watch(userProvider).when(
                    //   data: (String value) {
                    //     return Text(value);
                    //   },
                    //   error: (Object error, StackTrace stackTrace) {
                    //     return const Text("Error");
                    //   },
                    //   loading: () {
                    //     return const CircularProgressIndicator();
                    //   },
                    // );

                    /// map method
                    // return ref.watch(userProvider).map(
                    //     data: (AsyncData<String> value) {
                    //   return Text(value.value);
                    // }, error: (AsyncError<String> value) {
                    //   return const Text("Error");
                    // }, loading: (AsyncLoading<String> value) {
                    //   return const CircularProgressIndicator();
                    // });

                    /// maybewhen method
                    return ref.watch(userProvider).maybeWhen(
                      data: (String value) {
                        return Text(value);
                      },
                      orElse: () {
                        return const CircularProgressIndicator();
                      },
                    );
                  },
                ),
                Consumer(builder: (
                  BuildContext context,
                  WidgetRef ref,
                  Widget? child,
                ) {
                  return Text("Basic: ${ref.watch(counterController)}");
                }),
                const Text("Fake Database Counter"),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        ref.read(counterController.notifier).add();
                      },
                      child: const Text("Add"),
                    ),
                    const SizedBox(height: 4),
                    ElevatedButton(
                      onPressed: () {
                        ref.read(counterController.notifier).subtract();
                      },
                      child: const Text("Subtract"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
