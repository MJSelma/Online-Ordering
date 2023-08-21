import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class CasesMessages extends StatefulWidget {
  String idx;
  String caseId;
  String objective;
  CasesMessages(
      {super.key,
      required this.idx,
      required this.caseId,
      required this.objective});

  @override
  State<CasesMessages> createState() => _CasesMessagesState();
}

class _CasesMessagesState extends State<CasesMessages> {
  final List<types.Message> _messages = [];
  final _user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  Future<void> _getMessages() async {
    FirebaseFirestore.instance
        .collection('cases')
        // .doc('GWbs43UG9oiZx60999Z5')
        .doc(widget.idx)
        .collection('messages')
        .orderBy('date', descending: false)
        .get()
        .then((QuerySnapshot snapshot) {
      for (var data in snapshot.docs) {
        final textMessage = types.TextMessage(
          // repliedMessage: data['message'],
          author: data['sender'] == 'dl1'
              ? _user
              : types.User(id: data['sender'], firstName: 'Customer'),
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: data['sender'],
          text: data['message'],
        );

        _addMessage(textMessage);
      }
    });
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleImageSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Photo'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleFileSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('File'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    if (result == null || result.files.isEmpty) {
      throw Exception('No files picked or file picker was canceled');
    }
    final file = result.files.first;
    final filePath = file.path;
    final mimeType = filePath != null ? lookupMimeType(filePath) : null;

    if (result.files.single.path != null) {
      final message = types.FileMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        mimeType: lookupMimeType(result.files.single.path!),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );

      _addMessage(message);
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });
        }
      }

      await OpenFilex.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);
  }

  void _loadMessages() async {
    _getMessages();
    // final response = await rootBundle.loadString('messages.json');
    // final messages = (jsonDecode(response) as List)
    //     .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
    //     .toList();

    // setState(() {
    //   _messages = messages;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 65,
            // color: const Color(0xffbef7700),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Case no. :${widget.caseId}'),
                  const SizedBox(
                    width: 20,
                  ),
                  Text('Objective. :${widget.objective}'),
                ],
              ),
            ),
          ),
          Expanded(
            child: Chat(
              messages: _messages,
              onAttachmentPressed: __handleAttachmentPressedx,
              onMessageTap: _handleMessageTap,
              onPreviewDataFetched: _handlePreviewDataFetched,
              onSendPressed: _handleSendPressed,
              showUserAvatars: true,
              showUserNames: true,
              user: _user,

              isTextMessageTextSelectable: true,
              theme: const DarkChatTheme(
                inputBackgroundColor: Color(0xffbef7700),
                backgroundColor: Colors.white,
                primaryColor: Color(0xffbef7700),
              ),
              // isAttachmentUploading: true,
              avatarBuilder: (userId) => Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(113.0),
                  image: const DecorationImage(
                    image: AssetImage('images/profile.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  __handleAttachmentPressedx() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _handleImageSelection();
              },
              child: const Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text('Photo'),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _handleFileSelection();
              },
              child: const Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text('File'),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text('Cancel'),
              ),
            ),
          ],
        );
      },
    );
  }
}
