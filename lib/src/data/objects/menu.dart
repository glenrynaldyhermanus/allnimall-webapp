class Menu {
  final int index;
  final String name;
  final String path;
  final bool newPage;

  Menu(
      {required this.index,
      required this.name,
      required this.path,
      this.newPage = false});
}
