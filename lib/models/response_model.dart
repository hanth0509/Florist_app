class ResponseModel{
  bool _isSuccess;
  String _message;
  //bien rieng tu nen k dung {} va required
  ResponseModel(this._isSuccess, this. _message);
  String get message => _message;
  bool get isSuccess=>_isSuccess;
}