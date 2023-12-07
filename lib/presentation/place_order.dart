import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/providers/app_provider.dart';

class PlaceOrder extends ConsumerWidget {
  const PlaceOrder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backgroundColor = ref.watch(appStateProvider).backgroundColor;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
