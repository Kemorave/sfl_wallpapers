import 'package:easy_stepper/easy_stepper.dart';

class SortOption {
  static final SortOption empty =
      SortOption(icon: const Icon(Icons.abc), onSelect: () {}, getName: () => '...', id: '');
  final Function() onSelect;
  final Widget icon;
  final String id;
  final String Function() getName;

  SortOption(
      {required this.getName, required this.onSelect, required this.icon,required this.id});
}
