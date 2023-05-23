import 'package:easy_stepper/easy_stepper.dart';
import 'package:sfl/app/core/widgets/device_padding.dart';
import 'package:sfl/locator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'sort_option.dart';

class SortOptionsWidget extends StatelessWidget {
  final SortOption? lastSortMethod;
  final List<SortOption> optionsList;
  const SortOptionsWidget(
      {super.key, required this.optionsList, required this.lastSortMethod});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: DevicePadding(
        mobilePadding: EdgeInsets.symmetric(horizontal: 0.2.sw),
        tabletPadding: EdgeInsets.symmetric(horizontal: 0.2.sw),
        child: Card(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      lastSortMethod == null
                          ? language().strings.sort
                          : lastSortMethod!.getName(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    IconButton(
                        onPressed: () {
                          navigation().goBack(result: SortOption.empty);
                        },
                        icon: lastSortMethod == null
                            ? const Icon(Icons.sort)
                            : const Icon(Icons.close, color: Colors.red))
                  ],
                ),
                const Divider(
                  height: 1,
                  color: Colors.black,
                ),
                ..._buildOptions(optionsList)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Iterable<Widget> _buildOptions(List<SortOption> optionsList) {
    return optionsList.map((e) => Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: ListTile(
            title: Text(e.getName()),
            tileColor: e.id != lastSortMethod?.id ? null : Colors.grey[100],
            iconColor: e.id != lastSortMethod?.id ? Colors.grey : Colors.orange,
            trailing: e.icon,
            onTap: e.id == lastSortMethod?.id
                ? null
                : () {
                    e.onSelect();
                    navigation().goBack(result: e);
                  },
          ),
        ));
  }
}
