import 'dart:convert';

import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, this.photoBase64, this.radius = 44});

  final String? photoBase64;
  final double radius;

  ImageProvider? _image() {
    final data = photoBase64;
    if (data == null || data.isEmpty) return null;
    try {
      return MemoryImage(base64Decode(data));
    } on FormatException {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final image = _image();
    return CircleAvatar(
      radius: radius,
      backgroundImage: image,
      child: image == null ? Icon(Icons.person, size: radius) : null,
    );
  }
}
