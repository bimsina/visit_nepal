import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

NetworkImage customImage(String? url) {
  return NetworkImage(
    !kIsWeb && url != null
        ? url
        : "https://images.pexels.com/photos/2104882/pexels-photo-2104882.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
  );
}
