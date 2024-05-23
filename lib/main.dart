import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mall_app/cubit.dart';
import 'package:mall_app/home_screen.dart';
import 'package:mall_app/states.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await SheetModel.init();
  await Supabase.initialize(
      url: 'https://hzcixrhcyabzywgpqsfj.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh6Y2l4cmhjeWFienl3Z3Bxc2ZqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDYzNTkyMzksImV4cCI6MjAyMTkzNTIzOX0.WqUJABzi4typbVyyER3fJTiUD13_LaOzlQv0tzakdEo'
  );
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..GetData(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return  MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,
            home: HomeScreen(),
          );
        },

      ),
    );
  }
}

