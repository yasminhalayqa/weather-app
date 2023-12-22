import 'package:flutter/material.dart';

const PRIMARY_COLOR = Color(0xFFf07867);

final enabledCTAButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(const Color(0xFFf07867)),
  padding: MaterialStateProperty.all(
    const EdgeInsets.symmetric(vertical: 16),
  ),
  foregroundColor: MaterialStateProperty.all(Colors.white),
);

final disabledCTAButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(Colors.black12),
  padding: MaterialStateProperty.all(
    const EdgeInsets.symmetric(vertical: 16),
  ),
  foregroundColor: MaterialStateProperty.all(Colors.white),
);
