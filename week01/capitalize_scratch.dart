String capitalizeWords(String text) {
  return text
      .split(' ')
      .map((word) {
        if (word.isEmpty) {
          return word;
        }

        return word[0].toUpperCase() + word.substring(1);
      })
      .join(' ');
}

void main() {
  print(capitalizeWords('addis ababa'));
  print(capitalizeWords('hello  world'));
  print(capitalizeWords(''));
}
