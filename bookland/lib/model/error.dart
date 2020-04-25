class Error{
  String error;

  Error({
    this.error,
  });

  factory Error.fromJson(Map<String, dynamic> json) {
    return Error(
        error: json['errors'],
    );
  }
}