import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gstore/common/bloc/snackbar_bloc/snackbar_event.dart';
import 'package:my_gstore/common/bloc/snackbar_bloc/snackbar_state.dart';

class SnackBarBloc extends Bloc<SnackbarEvent, SnackBarState> {
  final duration = Duration(seconds: 3);

  SnackBarBloc() : super(InitialSnackbarState());

  @override
  Stream<SnackBarState> mapEventToState(SnackbarEvent event) async* {
    if (event is ShowSnackbarEvent) {
      yield ShowSnackBarState(
          mess: event.content,
          type: event.type,
          duration: event.duration ?? duration);
    }
  }
}
