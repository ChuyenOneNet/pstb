enum OptionType { cancel, option, title }

class BottomSheetOptionModel {
  final OptionType type;
  final int id;
  final String label;

  BottomSheetOptionModel({
    required this.type,
    required this.label,
    required this.id,
  });
}
