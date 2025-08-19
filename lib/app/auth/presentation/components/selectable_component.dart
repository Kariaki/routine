import 'package:flutter/cupertino.dart';
import 'package:routine/core/extensions/context_extension.dart';
import 'package:routine/core/extensions/num_extension.dart';
import 'option_pill_component.dart';

class SelectableComponent extends StatefulWidget {
  const SelectableComponent({super.key,required this.title,required this.onChanged,required this.options});

  final String title;
  final void Function(String?)onChanged;
  final List<String> options;
  @override
  State<SelectableComponent> createState() => _SelectableComponentState();
}

class _SelectableComponentState extends State<SelectableComponent> {
  String? selectedItem;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(widget.title,style: context.textTheme.headlineMedium,),
        10.height,
        Wrap(
          spacing: 8,
          alignment: WrapAlignment.start,
          runSpacing: 8,
          children: widget.options
              .map(
                (e) => OptionPillComponent(
              title: e,
              selected: selectedItem == e,
              onClick: () => setState(() {
                selectedItem = e;
                widget.onChanged(selectedItem);
              }),
            ),
          )
              .toList(),
        )
      ],
    );
  }
}
