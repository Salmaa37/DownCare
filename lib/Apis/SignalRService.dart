import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_netcore/json_hub_protocol.dart';
import 'package:signalr_netcore/signalr_client.dart';

class SignalRService {
  static final SignalRService _instance = SignalRService._internal();
  late HubConnection _hubConnection;
  bool isConnected = false;
  Function(String)? onMessageReceived;
  factory SignalRService() => _instance;

  SignalRService._internal();

  Future<void> connect() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null || token.isEmpty) {
      print(" فشل في الاتصال: التوكن غير موجود!");
      return;
    }
    print(" التوكن المستخدم: $token");
    try {
      _hubConnection = HubConnectionBuilder()
          .withUrl("http://downcare.runasp.net/ChatHub", options: HttpConnectionOptions(
        transport: HttpTransportType.WebSockets,
        accessTokenFactory: () async => token,
      )).withHubProtocol(JsonHubProtocol()).build();
      await _hubConnection.start();
      isConnected = true;
      print(" تم الاتصال بنجاح" );
      _hubConnection.on("ReceiveMessage", (arguments) {
        if (arguments != null && arguments.isNotEmpty && onMessageReceived != null) {
          onMessageReceived!(arguments.first.toString());
        }
      });
    } catch (e) {
      print(" فشل في الاتصال: $e");
    }
  }



  Future<void> sendMessage(String userId, String message) async {
    if (_hubConnection.state != HubConnectionState.Connected) {
      print(" الاتصال غير متاح. يرجى إعادة المحاولة لاحقًا.");
      return;
    }
    if (userId.isEmpty || message.isEmpty) {
      print(" خطأ: لا يمكن إرسال رسالة فارغة أو بدون معرف المستخدم.");
      return;
    }
    try {
      await _hubConnection.invoke("SendMessage", args: [userId, message]);
      print(" تم إرسال الرسالة بنجاح إلى $userId: $message");
    } catch (e) {
      print(" SendMessage Error: ${e.toString()}");
    }
  }





  Future<void> joinGroup() async {
    if (!isConnected || _hubConnection.state != HubConnectionState.Connected) {
      print("الاتصال غير متاح. يرجى إعادة المحاولة لاحقًا.");
      return;
    }
    try {
      await _hubConnection.invoke("JoiGroup");

      print("تم الانضمام إلى الجروب بنجاح");
    } catch (e) {
      print("فشل الانضمام إلى الجروب: ${e.toString()}");
    }
  }









  void  listenForUserJoined() {
    _hubConnection.on("UserJoined", (arguments) {
      if (arguments != null && arguments.isNotEmpty && arguments[0] is Map<String, dynamic>) {
        final userData = arguments[0] as Map<String, dynamic>;
        final userId = userData["UserId"];
        final message = userData["Message"];
        print("$message (User ID: $userId)");
      } else {
        print("Invalid UserJoined event data.");
      }
    });
  }


  void disconnect() {
    if (isConnected) {
      _hubConnection.stop();
      isConnected = false;
      print("انقطع الاتصال ");
    }
  }



}
