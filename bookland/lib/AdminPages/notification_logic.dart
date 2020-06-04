import 'package:flutter/cupertino.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationLogic extends StatefulWidget {
  @override
  _NotificationLogicState createState() => new _NotificationLogicState();
}

class _NotificationLogicState extends State<NotificationLogic> {
  String notificationContent;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  @override
  void initState() {
    super.initState();
    configSignal();
  }

  void configSignal() async {
    await OneSignal.shared.init("0ecd191c-68ae-4386-ad78-9ca1d677a390");

    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

    OneSignal.shared.setNotificationReceivedHandler((notification) {
      setState(() {
        notificationContent =
            notification.jsonRepresentation().replaceAll('\\n', '\n');
      });
    });
  }
}
