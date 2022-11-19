import 'package:flutter/material.dart';
import 'package:notifications_app/screens/home_screen.dart';
import 'package:notifications_app/screens/message_screen.dart';
import 'package:notifications_app/services/push_notify_service.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotifyService.initializeApp();
  
  runApp(MyApp());


}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
  
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();

    PushNotifyService.msgStreamCtrl.listen( (message) {

      print('My App: ================= $message');

      navigatorKey.currentState?.pushNamed( 'message', arguments: message['product'] ?? 'No product' );

      final snackBar = SnackBar( content: Text( message['product'] ?? 'No product' ) );
      messengerKey.currentState?.showSnackBar(snackBar);


    } );
    
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: messengerKey,
      initialRoute: '',
      routes: {
        ''        : (_) => const HomeScreen(),
        'message' : (_) => const MessageScreen()
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          elevation: 0
        )
      ),
      
    );
  }
}