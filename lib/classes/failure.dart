// Simple class type to store information/cause of network failures
class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}
