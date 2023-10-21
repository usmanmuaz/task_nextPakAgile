import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:next_pak_agile_task/firebase_options.dart';
import 'package:next_pak_agile_task/provider/expanded_tile_provider.dart';
import 'package:next_pak_agile_task/view/user_view.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("~~~~~~~~~ CONNECTING TO FIREBASE ~~~~~~~~~~~~");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => SelectedTileProvider(),
        builder: (context, child) {
          return ScreenUtilInit(
              designSize: const Size(375, 812),
              builder: (context, widget) => MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'NextPak Agile Solution Task',
                    theme: ThemeData(
                      colorScheme:
                          ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                      useMaterial3: true,
                    ),
                    home: const UserView(),
                  ));
        });
  }
}
