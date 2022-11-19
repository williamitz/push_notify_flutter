// SHA1: 62:35:DC:ED:71:F0:1E:70:2B:B1:B0:DA:FC:71:AD:20:26:DF:27:EE
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotifyService {
  
  static final FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<Map<String, dynamic>> _msgStreamCtrl = StreamController.broadcast();

  static Future<void> initializeApp() async {

    //push notifications
    await Firebase.initializeApp();

    token = await FirebaseMessaging.instance.getToken();

    print('token ==== $token');

    // este token ya lo podemos guardar en base de datos, será único para cada dispositivo

    //local notifications


    // handlers
    FirebaseMessaging.onBackgroundMessage( _backgroundHandler );
    FirebaseMessaging.onMessage.listen( _onMessageHandler );
    FirebaseMessaging.onMessageOpenedApp.listen( _onMessageOpenHandler );

  } 

  static Future<void> _backgroundHandler( RemoteMessage message ) async {

    // print('background Handler ===== ${ message.messageId }');
    print(message.data);
    _msgStreamCtrl.sink.add( message.data );

  }

  static Future<void> _onMessageHandler( RemoteMessage message ) async {

    // print('onMessage Handler ===== ${ message.messageId }');
    // _msgStreamCtrl.sink.add( message.notification?.title ?? 'No title' );
    _msgStreamCtrl.sink.add( message.data );

  }

  static Future<void> _onMessageOpenHandler( RemoteMessage message ) async {

    // print('onMessageOpen Handler ===== ${ message.messageId }');
    // _msgStreamCtrl.sink.add( message.notification?.title ?? 'No title' );
    _msgStreamCtrl.sink.add( message.data );

  }

  static Stream<Map<String, dynamic>> get msgStreamCtrl {
    return _msgStreamCtrl.stream;
  }

  static closeStream() {
    _msgStreamCtrl.close();
  }

}