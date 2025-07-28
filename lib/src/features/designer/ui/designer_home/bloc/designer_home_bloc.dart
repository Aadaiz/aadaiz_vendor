import 'package:aadaiz_seller/src/features/designer/repository/designer_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/designer_appointment_model.dart';

part 'designer_home_event.dart';
part 'designer_home_state.dart';

class DesignerHomeBloc extends Bloc<DesignerHomeEvent, DesignerHomeState> {
  var repo = DesignerRepository();
  DesignerHomeBloc() : super(DesignerHomeInitial())  {
    on<FetchAppointments>(_onFetchAppointments);
     on<LoadMoreAppointments>(_onLoadMoreAppointments);
  }
  List<DesignerAppointment>? appointments=[];
  int currentPage = 1;
  var totalPages;
  bool hasReachedMax=false;
  Future<dynamic> _onFetchAppointments(FetchAppointments event, Emitter<DesignerHomeState> emit) async{
    emit(LoadingState());
    try{
      DesignerAppointmentRes response = await repo.getAppointments(event.type, currentPage);
      appointments = response.data!.data;
      totalPages=response.data!.lastPage??1;
       hasReachedMax = response.data!.currentPage!=response.data!.lastPage?false:true;
      emit(AppointmentLoaded(appointments!, hasReachedMax: hasReachedMax));
    }catch(e){
     // emit(AppointmentError(error.toString()));
      print('error $e');
    }
    return true;
  }

  Future<dynamic> _onLoadMoreAppointments(LoadMoreAppointments event, Emitter<DesignerHomeState> emit) async{
 //   emit(LoadingState());
    try{
      currentPage++;
      DesignerAppointmentRes response = await repo.getAppointments(event.type, currentPage);
      final newItems = response.data!.data??[];
      appointments!.addAll(newItems);
      hasReachedMax = response.data!.currentPage!=response.data!.lastPage?false:true;
      emit(AppointmentLoaded(appointments!, hasReachedMax: hasReachedMax));
    }catch(e){
      // emit(AppointmentError(error.toString()));
      print('error $e');
    }
    return true;
  }
}
