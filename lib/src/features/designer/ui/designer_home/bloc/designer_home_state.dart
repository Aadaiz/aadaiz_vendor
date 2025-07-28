part of 'designer_home_bloc.dart';

@immutable
sealed class DesignerHomeState {}

final class DesignerHomeInitial extends DesignerHomeState {}

class LoadingState extends DesignerHomeState{}
class AppointmentLoaded extends DesignerHomeState{
  final List<DesignerAppointment> appointments;
  final bool hasReachedMax;
  AppointmentLoaded(this.appointments, {this.hasReachedMax = false});
}


class AppointmentError extends DesignerHomeState{
  final String error;

  AppointmentError(this.error);
}
