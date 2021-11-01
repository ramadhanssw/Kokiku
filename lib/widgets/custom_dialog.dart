import 'package:kokiku/common/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

customDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Coming Soon!'),
        content: const Text('This feature will be coming soon!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigation.back();
            },
            child: const Text('Ok'),
          ),
        ],
      );
    },
  );
}
