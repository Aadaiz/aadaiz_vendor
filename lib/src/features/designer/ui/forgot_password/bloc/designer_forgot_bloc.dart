import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'designer_forgot_event.dart';
part 'designer_forgot_state.dart';

class DesignerForgotBloc extends Bloc<DesignerForgotEvent, DesignerForgotState> {
  DesignerForgotBloc() : super(DesignerForgotInitial()) {
    on<DesignerForgotEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
