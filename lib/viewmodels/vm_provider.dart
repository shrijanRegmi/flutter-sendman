import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VMProvider<T extends ChangeNotifier> extends StatefulWidget {
  final T vm;
  final Function(BuildContext, T) builder;
  final Function(T)? onInit;
  final Function(T)? onDispose;
  const VMProvider({
    Key? key,
    required this.vm,
    required this.builder,
    this.onInit,
    this.onDispose,
  }) : super(key: key);

  @override
  _VMProviderState<T> createState() => _VMProviderState<T>();
}

class _VMProviderState<T extends ChangeNotifier> extends State<VMProvider<T>> {
  @override
  void initState() {
    super.initState();
    if (widget.onInit != null) widget.onInit!(widget.vm);
  }

  @override
  void dispose() {
    if (widget.onDispose != null) widget.onDispose!(widget.vm);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => widget.vm,
      child: Consumer<T>(
        builder: (context, value, child) {
          return widget.builder(context, value);
        },
      ),
    );
  }
}
