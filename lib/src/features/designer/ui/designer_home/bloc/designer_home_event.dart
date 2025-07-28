part of 'designer_home_bloc.dart';

@immutable
sealed class DesignerHomeEvent {}

class FetchAppointments extends DesignerHomeEvent {
  final String type;
  FetchAppointments(this.type);
}


class LoadMoreAppointments extends DesignerHomeEvent {
  final String type;
  LoadMoreAppointments(this.type);
}
