import 'package:flutter/material.dart';

/// A [Widget] that provides that handles creation and disposal of a [ChangeNotifier].
class Provider<T extends ChangeNotifier> extends StatefulWidget {
  /// Creates a [Provider] that handles data management for an [InheritedNotifier].
  const Provider(
      {Key? key,
      required T Function() create,
      this.lazy = true,
      required this.child})
      : _create = create,
        _value = null,
        super(key: key);

  /// Creates a [Provider] from an existing [ChangeNotifer], allowing the passing
  /// of data between [BuildContext]s.
  const Provider.value({Key? key, required T value, required this.child})
      : lazy = false,
        _create = null,
        _value = value,
        super(key: key);

  /// The child widget of the [Provider]. All dependents of the [Provider]
  /// should be below this in the [Widget] tree.
  final Widget child;

  final T Function()? _create;

  final T? _value;

  /// Denotes whether the [ChangeNotifier] should be instantiated lazily (default).
  /// If lazily loaded, the [ChangeNotifier] will not be created until it is accessed
  /// for the first time. Set to false to create the [ChangeNotifier] as soon as
  /// the [Provider] is created.
  final bool lazy;

  @override
  State<Provider<T>> createState() => _ProviderState<T>();
}

class _ProviderState<T extends ChangeNotifier> extends State<Provider<T>> {
  T? notifier;

  // lazily load
  T load() {
    if (notifier == null) {
      notifier = widget._create!();
      Future.delayed(Duration.zero, () => setState(() {}));
    }
    return notifier!;
  }

  @override
  void dispose() {
    if (widget._value == null) notifier?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Create [ChangeNotifier] on first build if not lazy and a value is not provided.
    if (!widget.lazy) notifier ??= widget._value ?? widget._create!();
    return _InheritedNotifier<T>(
        notifier: notifier, load: load, child: widget.child);
  }
}

class _InheritedNotifier<T extends ChangeNotifier>
    extends InheritedNotifier<T> {
  const _InheritedNotifier(
      {Key? key,
      required T? notifier,
      required this.load,
      required Widget child})
      : super(key: key, notifier: notifier, child: child);

  final T Function() load;
}

/// An extension on [BuildContext] that provides easy access to data stored in an [InheritedNotifier].
extension ReadContext on BuildContext {
  /// Reads the state of the [ChangeNotifier], without subscribing to updates.
  /// [Widget]s accessing the data this way will NOT rebuild when the data changes.
  T read<T extends ChangeNotifier>() {
    final inheritedNotifier =
        findAncestorWidgetOfExactType<_InheritedNotifier<T>>();
    assert(
        inheritedNotifier != null,
        'ChangeNotifier not found in context. '
        'Ensure that the ChangeNotifier is created by a Provider above this BuildContext.\n'
        'The most common cause of is using a BuildContext at the Provider level rather than below it.\n'
        'If you need to use the ChangeNotifier directly in the child parameter of the Provider, consider'
        'wrapping the child in a Builder.');

    // Lazily load [ChangeNotifier] on first access if needed.
    return inheritedNotifier!.notifier ?? inheritedNotifier.load();
  }

  /// Watches the state of the [ChangeNotifer], subscribing to updates.
  /// [Widget]s accessing the data this way will rebuild when the data changes.
  T watch<T extends ChangeNotifier>() {
    final inheritedNotifier =
        dependOnInheritedWidgetOfExactType<_InheritedNotifier<T>>();
    assert(
        inheritedNotifier != null,
        'ChangeNotifier not found in context. '
        'Ensure that the [ChangeNotifier] is created by a [Provider] above this [BuildContext].\n'
        'The most common cause of is using a [BuildContext] at the [Provider] level rather than below it.\n'
        'If you need to use the [ChangeNotifier] directly in the child parameter of the [Provider], consider'
        'wrapping the child in a [Builder].');

    // Lazily load [ChangeNotifier] on first access if needed.
    return inheritedNotifier!.notifier ?? inheritedNotifier.load();
  }
}
