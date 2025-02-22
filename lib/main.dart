import 'package:bank/application/application_business.dart';
import 'package:bank/application/application_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => PanFormBusiness(),
      child: MaterialApp(
        home: PANFormScreen(),
      ),
    ),
  );
}
