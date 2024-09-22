import 'package:flutter/material.dart';

class OrderByDialog extends StatefulWidget {
  final bool isDescending;
  final ValueChanged<bool> onValueChanged;

  const OrderByDialog({
    super.key,
    required this.isDescending,
    required this.onValueChanged,
  });

  @override
  State<OrderByDialog> createState() => _OrderByDialogState();
}

class _OrderByDialogState extends State<OrderByDialog> {
  late bool toggleValue;

  @override
  void initState() {
    super.initState();
    toggleValue = widget.isDescending;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Order by'),
      content: SwitchListTile(
        title: const Text('Descending'),
        value: toggleValue,
        onChanged: (_) {
          setState(() {
            toggleValue = !toggleValue;
            return widget.onValueChanged(toggleValue);
          });
        },
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Accept'),
        ),
      ],
    );
  }
}
