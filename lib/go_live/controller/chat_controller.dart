import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../common/widgets.dart';
import '../../utils/const_utils.dart';
import '../model/chat_model.dart';

class ChatController extends GetxController {
  final chatController = TextEditingController();

  static const String appKey = "61881763#1060324";
  var userId = "".obs;
  static const String agoraToken =
      "007eJxTYHi9tT7mduUabakdTH2pmmuLel1cn6dYFG8o/nNAV/9TzD0FBktD87QUS8M001QjQxPL1NREy2RTS6NkAyOTJEtjE3PTDRvuJDcEMjLwSB1iYGRgBWJGBhBfhSHVNNXSxMLQQNfSItFU19AwNUU3Kc0gWdfE1Mw4DWiOgaWpIQCh1yd/";

  ScrollController scrollController = ScrollController();
  final List<String> _logText = [];
  var chatList = <ChatModel>[].obs;

  @override
  void onInit() {
     initAgoraChatSDK();
    signInToAgora();
    addChatListener();
    super.onInit();
  }

  void initAgoraChatSDK() async {
    ChatOptions options = ChatOptions(
      appKey: appKey,
      autoLogin: false,
    );
    await ChatClient.getInstance.init(options);
  }

  void addChatListener() {
    ChatClient.getInstance.chatManager.addEventHandler(
      "UNIQUE_HANDLER_ID",
      ChatEventHandler(onMessagesReceived: onMessagesReceived),
    );
  }

  void onMessagesReceived(List<ChatMessage> messages) {
    for (var msg in messages) {
      switch (msg.body.type) {
        case MessageType.TXT:
          {
            ChatTextMessageBody body = msg.body as ChatTextMessageBody;
            _addLogToConsole(
              "receive text message: ${body.content}, from: ${msg.from}",
            );
          }
          break;
        case MessageType.IMAGE:
          {
            _addLogToConsole(
              "receive image message, from: ${msg.from}",
            );
          }
          break;
        case MessageType.VIDEO:
          {
            _addLogToConsole(
              "receive video message, from: ${msg.from}",
            );
          }
          break;
        case MessageType.LOCATION:
          {
            _addLogToConsole(
              "receive location message, from: ${msg.from}",
            );
          }
          break;
        case MessageType.VOICE:
          {
            _addLogToConsole(
              "receive voice message, from: ${msg.from}",
            );
          }
          break;
        case MessageType.FILE:
          {
            _addLogToConsole(
              "receive image message, from: ${msg.from}",
            );
          }
          break;
        case MessageType.CUSTOM:
          {
            _addLogToConsole(
              "receive custom message, from: ${msg.from}",
            );
          }
          break;
        case MessageType.CMD:
          {
            // Receiving command messages does not trigger the `onMessagesReceived` event, but triggers the `onCmdMessagesReceived` event instead.
          }
          break;
      }
    }
  }

  void signInToAgora() async {
    try {
      userId.value = generateRandomNum(8, false);
      showDebugPrint("agora userId is-----------   ${userId.value}");

      await ChatClient.getInstance.loginWithAgoraToken(
       "101",
        agoraToken,
      );
      _addLogToConsole("login succeed, userId: ${userId.value}");
    } on ChatError catch (e) {
      _addLogToConsole("login failed, code: ${e.code}, desc: ${e.description}");
    }
  }

  void _signOut() async {
    try {
      await ChatClient.getInstance.logout(true);
      _addLogToConsole("sign out succeed");
    } on ChatError catch (e) {
      _addLogToConsole(
          "sign out failed, code: ${e.code}, desc: ${e.description}");
    }
  }

  void sendMessage() async {
    if (userId.value == null || chatController.value.text == null) {
      _addLogToConsole("single chat id or message content is null");
      return;
    }

    var msg = ChatMessage.createTxtSendMessage(
      targetId: "101",
      content: chatController.value.text!,
    );
    msg.setMessageStatusCallBack(MessageStatusCallBack(
      onSuccess: () {
        _addLogToConsole("send message: ${chatController.value.text}");
        ChatTextMessageBody body = msg.body as ChatTextMessageBody;
        chatList.value.add(ChatModel(name: msg.from, message:  body.content));
        chatList.refresh();
        chatController.clear();
      },
      onError: (e) {
        _addLogToConsole(
          "send message failed, code: ${e.code}, desc: ${e.description}",
        );
        showMessage("Message failed \n${e.description}");
      },
    ));
    ChatClient.getInstance.chatManager.sendMessage(msg);
  }

  void _addLogToConsole(String log) {
    _logText.add(_timeString + ": " + log);

    showDebugPrint("message agora -----------------------   $log");
    // scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  String get _timeString {
    return DateTime.now().toString().split(".").first;
  }
}
