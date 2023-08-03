import 'package:flutter/foundation.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class MessageProvider with ChangeNotifier {
  bool refresh = false;
  List<types.Message> _message = [];
  String _messageId = '';

  String _customerId = '';
  String _customerName = '';
  String _customerImage = '';
  String _agentId = '';
  String _agentName = '';
  String _agentImage = '';

  String get customerId => _customerId;
  String get customerName => _customerName;
  String get customerImage => _customerImage;
  String get agentId => _agentId;
  String get agentName => _agentName;
  String get agentImage => _agentImage;

  void setMessageIDs(String cId, cName, cImage, aId, aName, aImage) {
    _customerId = cId;
    _customerName = cName;
    _customerImage = cImage;
    _agentId = agentId;
    _agentName = aName;
    _agentImage = aImage;
    notifyListeners();
  }

  List<types.Message> get message => _message;

  bool get isRefresh => refresh;

  String get messageId => _messageId;

  void setMessageId(String id) {
    _messageId = id;
    notifyListeners();
  }

  void addMessage(types.TextMessage mess) {
    // print(mess.text);
    _message.insert(0, mess);
    notifyListeners();
  }

    void clearMessages() {
    _message.clear();
    notifyListeners();
  }

  void messRefresh() {
    refresh = !refresh;
    notifyListeners();
  }
}
