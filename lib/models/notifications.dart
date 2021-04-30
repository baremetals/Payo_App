class Message {
  final String alert;
  // final String body;
  // final String message;
  final String date;

  Message({this.alert, this.date});

  factory Message.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String alert = data['alert'];
    // final String body = data['body'];
    // final String message = data['message'];
    final String date = data['date'];

    return Message(alert: alert, date: date);
  }
}
