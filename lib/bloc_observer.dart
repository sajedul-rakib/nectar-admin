import 'dart:developer';

import 'package:bloc/bloc.dart';

class AppBlocObserber extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log("on_create_bloc: ${bloc.runtimeType}");
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    // TODO: implement onEvent
    super.onEvent(bloc, event);
    log("on_event: ${bloc.runtimeType},event: $event");
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    // TODO: implement onChange
    super.onChange(bloc, change);
    log("on_change: ${bloc.runtimeType}, change: $change");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // TODO: implement onError
    super.onError(bloc, error, stackTrace);
    log("on_error ${bloc.runtimeType} error: $error stackTrace: $stackTrace");
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    // TODO: implement onTransition
    super.onTransition(bloc, transition);

    log("on_transition ${bloc.runtimeType} transition: $transition ");
  }

  @override
  void onClose(BlocBase bloc) {
    // TODO: implement onClose
    super.onClose(bloc);
    log("on_close ${bloc.runtimeType}");
  }
}
