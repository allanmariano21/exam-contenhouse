/// This is the server service class.
/// This class simiulates server responses with delays and errors.
/// You are not supposed to edit anything in this class.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension Extension on BuildContext {
  Server get server => read<Server>();
}

class Server {
  Server() : _key = Random().nextInt(9999);

  final int _key;
  int _count = 0;

  Future<int> get accessKey =>
      Future.delayed(const Duration(milliseconds: 800)).then((_) => _key);

  Future<Map<String, dynamic>> get data {
    final Map<String, dynamic> response = Random().nextBool()
        ? {
            "status_code": 200,
            "image": "https://img.memegenerator.net/instances/75093441.jpg",
            "message":
                "Content House is your go-to for real estate marketing content in Australia.\n\nWe’ve been knocking around the industry for a while now, fine-tuning our content production processes since 2013. Content House isn’t just a full service solution for quality content though; it’s about the experience we give our customers. We know we’re in it for the long haul, so we build our partnerships to reflect that.\n\nThe core of Content House is its people; who we are and what we do go hand in hand. Our not so secret weapon is our use of the latest technology, which powers the business to provide the best marketing tools that the industry has ever seen.",
            "count": _count
          }
        : {
            "status_code": 503,
            "error_message": "Server is busy. Please try again later."
          };

    return Future<Map<String, dynamic>?>.delayed(
      const Duration(milliseconds: 800),
    ).then((_) => response);
  }

  Future<int> addToCount(int value) {
    return Future.delayed(const Duration(milliseconds: 250)).then(
      (_) => _count += value,
    );
  }
}
