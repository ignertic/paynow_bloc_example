import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paynow_bloc/paynow_bloc.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/theme.dart';
// import 'package:'

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
    final paynow = Paynow(
      integrationId: "11287",
      integrationKey: "a072bd58-c25e-48cb-8516-3d33b5b85f64",
      returnUrl: "supercode://paynow.app",
      resultUrl: "supercode://paynow.app"
    );
    return BlocProvider(
      create: (_) => PaynowBloc(
        paynow: paynow
      ),
      child: app,
    );
  }
}
