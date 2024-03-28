class CheckLastText {
  bool checkLastWord(String text, String lastWord) {
    if (text.isEmpty || lastWord.isEmpty) {
      return false;
    }
    List<String> words = text.split(' ');
    String lastTextWord = words.isNotEmpty ? words.last : '';
    return lastTextWord == lastWord;
  }
}
