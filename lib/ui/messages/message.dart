import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drinklinkmerchant/provider/message_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class MessagePage extends HookWidget {
  final String caseId;
  final String customerID;
  const MessagePage(
      {super.key, required this.caseId, required this.customerID});

  @override
  Widget build(BuildContext context) {
    final bool isRefresh = context.select((MessageProvider p) => p.isRefresh);
    final messages = useState(context.select((MessageProvider p) => p.message));

    final messageID = useState<String>('');

    useEffect(() {
      Future.microtask(() async {
        final messProv = context.read<MessageProvider>();

        messProv.clearMessages();
        await getMessageID(context, messageID, messages);
      });
      return null;
    }, [caseId, isRefresh]);

    return Expanded(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(4, 10, 4, 0),
      child: Chat(
        messages: messages.value,
        // onAttachmentPressed: _handleAttachmentPressed,
        // onMessageTap: _handleMessageTap,
        // onPreviewDataFetched: _handlePreviewDataFetched,
        // onSendPressed: _handleSendPressed(messages),
        onSendPressed: (p0) => {handleSendPressed(context, p0, messages)},
        showUserAvatars: true,
        showUserNames: true,
        user: types.User(
          id: customerID,
        ),
      ),
    ));
  }

  handleSendPressed(BuildContext context, types.PartialText message,
      ValueNotifier<List<types.Message>> mymessages) {
    final textMessage = types.TextMessage(
      author: types.User(
        id: customerID,
      ),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: customerID,
      text: message.text,
    );
    _addMessage(context, textMessage, mymessages);
    sendMessage(context, textMessage.text);
  }

  void _addMessage(BuildContext context, types.TextMessage textMessage,
      ValueNotifier<List<types.Message>> mymessages) {
    context.read<MessageProvider>().addMessage(textMessage);
  }

  getMessageID(BuildContext context, ValueNotifier messageID,
      ValueNotifier<List<types.Message>> messages) async {
    final messProv = context.read<MessageProvider>();
    await FirebaseFirestore.instance
        .collection('caseMessages')
        .where('senderId', isEqualTo: caseId)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) async {
                debugPrint(doc.id);
                messageID.value = doc.id;
              })
            });
    if (messageID.value != '') {
      messProv.setMessageId(messageID.value);
      print('calling messages');
      getMessages(context, messageID, messages);
    }
  }

  Future<void> sendMessage(BuildContext context, String textMessage) {
    final messProv = context.read<MessageProvider>();
    final String messageId = messProv.messageId;
    print(messageId);
    CollectionReference students = FirebaseFirestore.instance
        .collection('caseMessages')
        .doc(messageId)
        .collection('message');
    return students.add({
      'date': DateTime.fromMicrosecondsSinceEpoch(
          DateTime.now().microsecondsSinceEpoch),
      'message': textMessage,
      'messageFrom': 'agent',
      'receiverId': messProv.customerId,
      'receiverName': messProv.customerName,
      'receiverImage': messProv.customerImage,
      'senderId': customerID,
      'senderName': messProv.agentName,
      'senderImage': messProv.agentImage,
      'type': 'text'
    }).then((value) {
      messProv.messRefresh();
      print('Message send');
    }).catchError((error) => print("Message couldn't be sent."));
  }

  getMessages(BuildContext context, ValueNotifier messageID,
      ValueNotifier<List<types.Message>> messages) async {
    // List<MessageModel> messages = [];

    await FirebaseFirestore.instance
        .collection('caseMessages')
        .doc(messageID.value)
        .collection('message')
        .orderBy('date')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) async {
                debugPrint(doc.id);
                messageID.value = doc.id;
                DateTime dtStart = (doc['date'] as Timestamp).toDate();
                print(doc['message']);
                final textMessage = types.TextMessage(
                  author: types.User(
                      id: doc['senderId'],
                      firstName: doc['senderName'],
                      imageUrl: doc['senderImage']),
                  createdAt: DateTime.now().millisecondsSinceEpoch,
                  id: doc['senderId'],
                  text: doc['message'],
                );

                _addMessage(context, textMessage, messages);
              })
            });
  }

  // Widget _buildReaderList(BuildContext context, ValueNotifier agentList) {
  //   return Expanded(
  //     child: GridView.builder(
  //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //             crossAxisCount: 4),
  //         itemCount: agentList.value.length,
  //         itemBuilder: (context, index) {
  //           return Padding(
  //             padding: const EdgeInsets.all(12.0),
  //             child: Container(
  //               width: 200,
  //               height: 330,
  //               decoration: BoxDecoration(
  //                 color: Colors.grey.shade200,
  //                 borderRadius: BorderRadius.circular(8),
  //               ),
  //               child: GestureDetector(
  //                 onTap: () {},
  //                 child: Padding(
  //                   padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       CircleAvatar(
  //                         radius: 60.0,
  //                         backgroundImage:
  //                             NetworkImage('${agentList.value[index].image}'),
  //                         backgroundColor: Colors.transparent,
  //                       ),
  //                       const SizedBox(
  //                         height: 8,
  //                       ),
  //                       Text(
  //                         '${agentList.value[index].firstName.toString().toUpperCase()} ${agentList.value[index].middleName.toString().toUpperCase()} ${agentList.value[index].lastName.toString().toUpperCase()}',
  //                         style: const TextStyle(fontWeight: FontWeight.w700),
  //                       ),
  //                       const SizedBox(
  //                         height: 4,
  //                       ),
  //                       Text('${agentList.value[index].email}'),
  //                       const SizedBox(
  //                         height: 4,
  //                       ),
  //                       Text('${agentList.value[index].address}'),
  //                       const SizedBox(
  //                         height: 4,
  //                       ),
  //                       Text('Employee ID: ${agentList.value[index].id}'),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           );
  //         }),
  //   );
  // }
}
