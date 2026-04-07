extension StringExtensions on String{

  String toTitleCase(){
    if(isEmpty) return this;

    List<String> words = split(' ');
    words = words.map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      }
      return word;
    }).toList();
    return words.join(' ');
  }

  bool isValidEmail() => RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this);

  String reverse() => split('').reversed.join('');
}