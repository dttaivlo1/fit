/// An extension to capitalize first character of each word in a string
/// Taken from: 
/// https://stackoverflow.com/questions/29628989/how-to-capitalize-the-first-letter-of-a-string-in-dart
extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}