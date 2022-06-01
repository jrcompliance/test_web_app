class Message {
  final String message;
  final String senderUsername;
  final String sentAt;
  final String sentTo;

  Message(
      {required this.message,
      required this.senderUsername,
      required this.sentAt,
      required this.sentTo});

  factory Message.fromJson(Map<String, dynamic> message) {
    return Message(
      message: message['message'],
      senderUsername: message['senderUsername'],
      sentTo: message['sentTo'],
      sentAt: message['sentAt'],
    );
  }
}
