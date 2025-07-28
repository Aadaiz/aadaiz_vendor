part of 'designer_profile_bloc.dart';

@immutable
sealed class DesignerProfileState {}

final class DesignerProfileInitial extends DesignerProfileState {}

class DesignerProfileLoadingState extends DesignerProfileState {}
class DesignerProfileErrorState extends DesignerProfileState {}
class DesignerProfileSuccessState extends DesignerProfileState {
  final DesignerProfile? designerProfile;
  DesignerProfileSuccessState(this.designerProfile);
}

class DesignerNotificationLoadingState extends DesignerProfileState {}
class DesignerNotificationSuccessState extends DesignerProfileState {}
class DesignerNotificationErrorState extends DesignerProfileState {}
