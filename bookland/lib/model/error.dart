class Error{
  List<dynamic> errors;

  Error({
    this.errors,
  });

  factory Error.fromJson(Map<String, dynamic> json) {
    return Error(
        errors: json['errors'],
    );
  }
}