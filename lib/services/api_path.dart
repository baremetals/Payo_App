class APIPath {
  static String transfer(String uid, String transferId) => 'users/$uid/transfers/$transferId';
  static String transfers(String uid) => 'users/$uid/transfers';

}
