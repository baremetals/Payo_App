class APIPath {
  static String transfer(String uid, String transferId) =>
      'users/$uid/transfers/$transferId';
  static String transfers(String uid) => 'users/$uid/transfers';
  static String notification(String uid, String notificationId) => 'users/$uid/notifications/$notificationId';
  static String notifications(String uid) => 'users/$uid/notifications';
}
