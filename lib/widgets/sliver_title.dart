import 'package:flutter/material.dart';

Widget sliverTitle(String title) {
  return SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.only(
        left: 15.0,
        right: 15,
        bottom: 10,
        top: 30,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
