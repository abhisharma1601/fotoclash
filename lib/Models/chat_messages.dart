class ChatMessage {
  final String text;
  final bool isSender;

  ChatMessage({
    this.text = '',
    required this.isSender,
  });
}

List demeChatMessages = [
  ChatMessage(
    text: "Hi Sajol,",
    isSender: false,
  ),
  ChatMessage(
    text: "Hello, How are you?",
    isSender: true,
  ),
  ChatMessage(
    text: "This is just a test",
    isSender: false,
  ),
  ChatMessage(
    text: "halo",
    isSender: true,
  ),
  ChatMessage(
    text: "Error happend",
    isSender: true,
  ),
  ChatMessage(
    text: "This looks great man!!",
    isSender: false,
  ),
  ChatMessage(
    text: "Glad you like it",
    isSender: true,
  ),
];