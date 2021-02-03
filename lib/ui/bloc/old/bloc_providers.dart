//import 'package:flutter/material.dart';
//import 'package:shrtcode/ui/bloc/old/bloc.dart';
//
//
//class BlocProvider<T extends Bloc> extends StatefulWidget {
//  final Widget child;
//  final T bloc;
//
//  const BlocProvider({Key key, @required this.bloc, @required this.child})
//      : super(key: key);
//
//  static T of<T extends Bloc>(BuildContext context) {
////    final type = _providerType<_BlocProviderInherited<T>>();
//    _BlocProviderInherited<T> provider =  context.getElementForInheritedWidgetOfExactType<_BlocProviderInherited<T>>().widget;
//    return provider.bloc;
//  }
//
//  //static Type _providerType<T>() => T;
//
//  @override
//  State createState() => _BlocProviderState();
//}
//
//class _BlocProviderState<T extends Bloc> extends State<BlocProvider<T>> {
//
//  @override
//  void initState() {
//    super.initState();
//    widget.bloc?.init();
//  }
//
//  @override
//  void dispose() {
//    widget.bloc?.dispose();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new _BlocProviderInherited<T>(
//      bloc: widget.bloc,
//      child: widget.child,
//    );
//  }
//
//}
//
//class _BlocProviderInherited<T> extends InheritedWidget {
//  _BlocProviderInherited({
//    Key key,
//    @required Widget child,
//    @required this.bloc,
//  }) : super(key: key, child: child);
//  final T bloc;
//
//  @override
//  bool updateShouldNotify(_BlocProviderInherited oldWidget) => false;
//}