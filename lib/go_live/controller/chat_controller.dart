import 'dart:async';

import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stream_e_cart/constants/api_endpoints.dart';
import 'package:stream_e_cart/constants/app_colors.dart';
import 'package:stream_e_cart/constants/storage_constants.dart';
import 'package:stream_e_cart/constants/string_constants.dart';
import 'package:stream_e_cart/go_live/go_live_repo.dart';

import '../../common/widgets.dart';
import '../model/chat_model.dart';

class ChatController extends GetxController {
  final chatController = TextEditingController();
  final store = GetStorage();

  var userId = "".obs;
  var chatToken = "".obs;
  var agoraAppChatToken = "".obs;
  var agoraChatRoomId = "".obs;
  var chatUsername = "".obs;

  var scrollController = ScrollController().obs;
  final List<String> _logText = [];
  var chatList = <ChatModel>[].obs;

  @override
  void onInit() {
    getChatTokenApi(chatUsername.value);
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
            chatList
                .add(ChatModel(msg.from.toString(), body.content, colorYellow));
            chatList.refresh();
            Timer(
                const Duration(milliseconds: 500),
                () => scrollController.value
                    .jumpTo(scrollController.value.position.maxScrollExtent));
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

  void signInToAgora(String userId) async {
    try {
      await ChatClient.getInstance.loginWithAgoraToken(
        chatUsername.value,
        chatToken.value,
      );
      _addLogToConsole("login succeed, userId: $userId");
      joinChatRoom(agoraChatRoomId.value);
      // joinChatRoom("206800089579521");
    } on ChatError catch (e) {
      _addLogToConsole("login failed, code: ${e.code}, desc: ${e.description}");
      //  getAgoraRegisterApi(agoraAppChatToken.value, userId.value);
    }
  }

  /*void _signOut() async {
    try {
      await ChatClient.getInstance.logout(true);
      _addLogToConsole("sign out succeed");
    } on ChatError catch (e) {
      _addLogToConsole(
          "sign out failed, code: ${e.code}, desc: ${e.description}");
    }
  }*/

  void sendMessage() async {
    showDebugPrint("Room id-------->  ${agoraChatRoomId.value}");
    var firstAttempt = true;
    if (chatController.value.text == "") {
      _addLogToConsole("single chat id or message content is null");
      showMessage(typeAMessage);
      return;
    } else {
      var msg = ChatMessage.createTxtSendMessage(
          targetId: agoraChatRoomId.value,
          content: chatController.value.text,
          chatType: ChatType.ChatRoom);

      ChatClient.getInstance.chatManager.addMessageEvent(
          "UNIQUE_HANDLER_ID",
          ChatMessageEvent(
            onSuccess: (msgId, msg) {
              _addLogToConsole("send message: ${chatController.value.text}");
              ChatTextMessageBody body = msg.body as ChatTextMessageBody;
              chatList
                  .add(ChatModel(store.read(userName), body.content, colorRed));
              chatList.refresh();
              chatController.clear();
              Timer(
                  const Duration(milliseconds: 500),
                  () => scrollController.value
                      .jumpTo(scrollController.value.position.maxScrollExtent));
            },
            onProgress: (msgId, progress) {
              _addLogToConsole("send message succeed");
            },
            onError: (msgId, msg, error) {
              _addLogToConsole(
                "send message failed, code: ${error.code}, desc: ${error.description}",
              );
              if (error.code == 500 && firstAttempt) {
                sendMessage();
                firstAttempt = false;
              }
            },
          ));
      /*   msg.setMessageStatusCallBack.MessageStatusCallBack(
        onSuccess: () {
          _addLogToConsole("send message: ${chatController.value.text}");
          ChatTextMessageBody body = msg.body as ChatTextMessageBody;
          chatList.add(
              ChatModel(store.read(userName), body.content, colorRed));
          chatList.refresh();
          chatController.clear();
          Timer(const Duration(milliseconds: 500), () => scrollController.value.jumpTo(scrollController.value.position.maxScrollExtent));

        },
        onError: (e) {
          _addLogToConsole(
            "send message failed, code: ${e.code}, desc: ${e.description}",
          );
          if(e.code == 500 && firstAttempt){
            sendMessage();
            firstAttempt = false;
          }
          //showMessage("Message failed \n${e.description}");
        },
      );*/
      ChatClient.getInstance.chatManager.sendMessage(msg);
    }
  }

  void _addLogToConsole(String log) {
    _logText.add("$_timeString: $log");

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

        signInToAgora(value.username.toString());
        addChatListener();
      } else {
        return;
      }
    });
  }

  Future<void> joinChatRoom(String roomId) async {
    try {
      await ChatClient.getInstance.chatRoomManager.joinChatRoom(roomId);
    } on ChatError catch (e) {
      showDebugPrint("room join failure ---- $e");
    }
  }

  Future<void> leaveChatRoom(String roomId) async {
    try {
      await ChatClient.getInstance.chatRoomManager.leaveChatRoom(roomId);
    } on ChatError catch (e) {
      showDebugPrint("room leave failure ---- $e");
    }
  }

/* void getAgoraRegisterApi(String appToken, String userId) {
    GoLiveRepo().agoraRegisterUser(appToken, userId).then((value) async {
      if (value.applicationName != "") {
        try {
          await ChatClient.getInstance.loginWithAgoraToken(
           userId,
            chatToken.value,
          );
          _addLogToConsole("login succeed, userId: $userId");
        } on ChatError catch (e) {
          _addLogToConsole("login failed, code: ${e.code}, desc: ${e.description}");
        }
      } else {
        return;
      }
    });
  }*/
}
