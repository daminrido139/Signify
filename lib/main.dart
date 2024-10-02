import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signify/models/imageai.dart';

import 'package:signify/entry.dart';

void main() {
  // Gemini.init(
  //     apiKey: const String.fromEnvironment(
  //         'AIzaSyAfCKcnsK08BZ_ddwm2KPvuUdvzJ5lqBkA'),
  //     enableDebugging: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (create) => HomeProvider()),
      ],
      child: MaterialApp(
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(0.9)),
            child: child!,
          );
        },
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          brightness: Brightness.light,
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const EntryPage(),
      ),
    );
  }
}
