import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stream_e_cart/constants/api_endpoints.dart';
import 'package:stream_e_cart/constants/storage_constants.dart';
import 'package:stream_e_cart/constants/string_constants.dart';
import 'package:stream_e_cart/go_live/go_live_repo.dart';

import '../../common/widgets.dart';
import '../../utils/const_utils.dart';
import '../model/chat_model.dart';

class ChatController extends GetxController {
  final chatController = TextEditingController();
  final store = GetStorage();

  var userId = "".obs;
  var chatToken = "".obs;
  var agoraAppChatToken = "".obs;

  ScrollController scrollController = ScrollController();
  final List<String> _logText = [];
  var chatList = <ChatModel>[].obs;

  @override
  void onInit() {
    getChatTokenApi(userId.value);
    initAgoraChatSDK();
    super.onInit();
  }

  void initAgoraChatSDK() async {
    ChatOptions options = ChatOptions(
      appKey: APIEndpoints.agoraAppKey,
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
    userId.value = store.read(agoraChatUserId);

    try {
      await ChatClient.getInstance.loginWithAgoraToken(
        userId.value,
        chatToken.value,
      );
      _addLogToConsole("login succeed, userId: ${userId.value}");
    } on ChatError catch (e) {
      _addLogToConsole("login failed, code: ${e.code}, desc: ${e.description}");
      getAgoraRegisterApi(agoraAppChatToken.value, userId.value);
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
    if (userId.value == null || chatController.value.text == null || chatController.value.text == "") {
      _addLogToConsole("single chat id or message content is null");
      showMessage(typeAMessage);
      return;
    } else {
      var msg = ChatMessage.createTxtSendMessage(
        targetId: userId.value,
        content: chatController.value.text,
      );
      msg.setMessageStatusCallBack(MessageStatusCallBack(
        onSuccess: () {
          _addLogToConsole("send message: ${chatController.value.text}");
          ChatTextMessageBody body = msg.body as ChatTextMessageBody;
          chatList.value.add(
              ChatModel(name: store.read(userName), message: body.content));
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
  }

  void _addLogToConsole(String log) {
    _logText.add(_timeString + ": " + log);

    showDebugPrint("message agora -----------------------   $log");
    // scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  String get _timeString {
    return DateTime.now().toString().split(".").first;
  }

  void getChatTokenApi(String userId) {
    GoLiveRepo().getChatToken(userId).then((value) async {
      if (value.userToken != "") {
        chatToken.value = value.userToken.toString();
        agoraAppChatToken.value = value.appToken.toString();

        signInToAgora();
        addChatListener();

      } else {
        return;
      }
    });
  }

 void getAgoraRegisterApi(String appToken, String userId) {
    GoLiveRepo().agoraRegisterUser(appToken, userId).then((value) async {
      if (value.applicationName != "") {
        try {
          await ChatClient.getInstance.loginWithAgoraToken(
           userId,
            chatToken.value,
          );
          _addLogToConsole("login succeed, userId: ${userId}");
        } on ChatError catch (e) {
          _addLogToConsole("login failed, code: ${e.code}, desc: ${e.description}");
        }
      } else {
        return;
      }
    });
  }

}
