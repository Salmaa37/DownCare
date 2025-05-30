import 'package:downcare/Models/MessageModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_netcore/signalr_client.dart';
class SignalRService {
  late HubConnection _hubConnection;
  bool isConnected = false;
  Function(MessageModel messagemodel)? onMessageReceived;
  Function(int id)? onMessageDeleted;
  /// Connects
  Future<void> connect() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    if (token.isEmpty) {
      print(' التوكن غير موجود');
      return;
    }
    print(' $token');
    final serverUrl = 'http://downcare.runasp.net/ChatHub?token=$token';
    final options = HttpConnectionOptions(
      transport: HttpTransportType.WebSockets,
    );
    _hubConnection = HubConnectionBuilder()
        .withUrl(serverUrl, options: options)
        .build();

    _hubConnection.onclose((error) async {
      isConnected = false;
      print(' ${error?.toString()}');
      await Future.delayed(Duration(seconds: 5));
      await connect();
    });

    // Listener for group messages
    _hubConnection.on('ReceiveGroupMessage', (args) {
      try {
        print(" $args");

        if (args != null && args is List && args.isNotEmpty && args.first is Map) {
          final Map<String, dynamic> messageData = Map<String, dynamic>.from(args.first);

          final messageModel = MessageModel(
            messageId: messageData['messageId'] is int
                ? messageData['messageId']
                : int.tryParse(messageData['messageId']?.toString() ?? '0') ?? 0,
            message: messageData['message']?.toString() ?? '',
            userName: messageData['userName']?.toString() ?? 'Unknown',
            userImageURL: messageData['userImage']?.toString() ?? '',
            displayTime: messageData['displayTime']?.toString() ?? '',
            dateTime: messageData['dateTime']?.toString() ?? DateTime.now().toIso8601String(),
          );

          print(" ${messageModel.toString()}");
          onMessageReceived?.call(messageModel);
        }
      } catch (e, stack) {
        print('Stack: $stack');
      }
    });
    // Listener for user join event
    _hubConnection.on('UserJoined', (args) {
      try {
        final message = _safeParseArg(args);
        print(message);

        MessageModel systemMessage = MessageModel(
          messageId: 0,
          message: message,
          userName: 'System',
          userImageURL: '',
          displayTime: '',
          dateTime: '',
        );
        onMessageReceived?.call(systemMessage);
      } catch (e) {
        print(' $e');
      }
    });
    // Listener for user left event
    _hubConnection.on('UserLeft', (args) {
      try {
        final message = _safeParseArg(args);
        print(message);
        MessageModel systemMessage = MessageModel(
          messageId: 0,
          message: message,
          userName: 'System',
          userImageURL: '',
          displayTime: '',
          dateTime: '',
        );
        onMessageReceived?.call(systemMessage);
      } catch (e) {
        print(' $e');
      }
    });
    // Listener for delete message
    _hubConnection.on('MessageDeleted', (args) {
      print("جاء حدث الحذف: $args");
      try {
        if (args != null && args is List && args.isNotEmpty) {
          final data = args.first;
          final messageId = data is int
              ? data
              : int.tryParse(data.toString()) ?? 0;

          print("ID الرسالة المحذوفة: $messageId");
          if (messageId != 0) {
            onMessageDeleted?.call(messageId);
          }
        }
      } catch (e) {
        print("خطأ في MessageDeleted: $e");
      }
    });




    // Listener for doctor messages
    _hubConnection.on('ReceiveMessage', (args) {
      try {
        print(" $args");

        if (args != null && args is List && args.isNotEmpty && args.first is Map) {
          final Map<String, dynamic> messageData = Map<String, dynamic>.from(args.first);

          final messageModel = MessageModel(
            messageId: messageData['messageId'] is int
                ? messageData['messageId']
                : int.tryParse(messageData['messageId']?.toString() ?? '0') ?? 0,
            message: messageData['message']?.toString() ?? '',
            userName: messageData['userName']?.toString() ?? 'Unknown',
            userImageURL: messageData['userImage']?.toString() ?? '',
            displayTime: messageData['displayTime']?.toString() ?? '',
            dateTime: messageData['dateTime']?.toString() ?? DateTime.now().toIso8601String(),
          );

          print(" ${messageModel.toString()}");
          onMessageReceived?.call(messageModel);
        }
      } catch (e, stack) {
        print(' $e');
        print('Stack: $stack');
      }
    });


    try {

      await _hubConnection.start();
      isConnected = true;
      print(' تم الاتصال بنجاح');
    } catch (e) {
      print(' فشل في الاتصال: ${e.toString()}');
    }
  }

  Future<void> sendMessage(String message) async {
    if (!isConnected) {
      print(' غير متصل');
      return;
    }
    try {
      await _hubConnection.invoke('SendGroupMessage', args: [message]);
      print(' $message');
    } catch (e) {
      print(' ${e.toString()}');
    }
  }

  Future<void> sendDoctorMessage(String id, String message) async {
    if (!isConnected) {
      print(' غير متصل، ');
      return;
    }
    try {
      await _hubConnection.invoke('SendMessage', args: [id, message]);
      print(' تم إرسال الرسالة: $message');
    } catch (e) {
      print(' ${e.toString()}');
    }
  }


  Future<void> joinGroup() async {
    if (!isConnected) {
      print('غير متصل ');
      return;
    }
    try {
      final result = await _hubConnection.invoke('JoinGroup');
      print(' انضممت إلى الجروب : $result');
    } catch (e) {
      print(' فشل في الانضمام للجروب: ${e.toString()}');
    }
  }

  Future<void> disconnect() async {
    if (isConnected) {
      await _hubConnection.stop();
      isConnected = false;
      print(' تم غلق الاتصال');
    }
  }

  /// Helper function
  String _safeParseArg(List<Object?>? args) {
    return (args != null && args.isNotEmpty && args.first != null)
        ? args.first.toString()
        : '';
  }

  Future<void> leaveGroup() async {
    if (!isConnected) {
      print('️ غير متصل');
      return;
    }
    try {
      await _hubConnection.invoke('LeftGroup');
      print(' تم مغادرة الجروب');
    } catch (e) {
      print(' ${e.toString()}');
    }
  }
}
