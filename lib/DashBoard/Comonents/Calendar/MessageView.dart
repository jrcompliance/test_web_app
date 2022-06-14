import 'package:flutter/material.dart';
import 'package:stream_chat/stream_chat.dart';

class MessageView extends StatefulWidget {
  /// Message takes the latest list of messages and the current channel.
  const MessageView({
    Key? key,
    required this.messages,
    required this.channel,
  });

  /// List of messages sent in the given channel.
  final List<Message> messages;

  /// Current channel being observed.
  final Channel channel;

  @override
  _MessageViewState createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  late final TextEditingController _controller;
  late final ScrollController _scrollController;

  List<Message> get _messages => widget.messages;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// Convenience method for scrolling the list view when a new message is sent.
  void _updateList() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              reverse: true,
              itemBuilder: (BuildContext context, int index) {
                final item = _messages[index];
                if (item.user?.id == widget.channel.client) {
                  return Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(item.text ?? ''),
                    ),
                  );
                } else {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(item.text ?? ''),
                    ),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter your message',
                    ),
                  ),
                ),
                Material(
                  type: MaterialType.circle,
                  color: Colors.blue,
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    onTap: () async {
                      // We can send a new message by calling `sendMessage` on
                      // the current channel. After sending a message, the
                      // TextField is cleared and the list view is scrolled
                      // to show the new item.
                      if (_controller.value.text.isNotEmpty) {
                        await widget.channel.sendMessage(
                          Message(text: _controller.value.text),
                        );
                        _controller.clear();
                        _updateList();
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Center(
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
