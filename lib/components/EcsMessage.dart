class EcsMessage {
  String message;
  bool hasExecuted;

  EcsMessage({
    required this.message,
    required this.hasExecuted,
  });

  EcsMessage.empty() : this(message: '', hasExecuted: true);
}
