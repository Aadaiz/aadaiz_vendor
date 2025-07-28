import 'package:aadaiz_seller/src/features/designer/models/designer_notification_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/designer_profile_model.dart';
import '../../../repository/designer_repository.dart';

part 'designer_profile_event.dart';
part 'designer_profile_state.dart';

class DesignerProfileBloc
    extends Bloc<DesignerProfileEvent, DesignerProfileState> {
  var repo = DesignerRepository();
  DesignerProfileBloc() : super(DesignerProfileInitial()) {
    on<FetchProfileEvent>(_onDesignerProfile);
  }
  Future<dynamic> _onDesignerProfile(
      FetchProfileEvent event, Emitter<DesignerProfileState> emit) async {
    emit(DesignerProfileLoadingState());
    try {
      DesignerProfileRes res = await repo.profile();
      if (res.data != null) {
        emit(DesignerProfileSuccessState(res.data));
      } else {
        emit(DesignerProfileErrorState());
      }
    } catch (e) {
      print('error $e');
    }
  }

}
