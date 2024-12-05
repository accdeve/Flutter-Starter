part of 'achievment_cubit.dart';

@immutable
sealed class AchievmentState {}

final class AchievmentInitial extends AchievmentState {}

final class AchievmentLoading extends AchievmentState {}

final class AchievmentSuccess extends AchievmentState {
  final AchievmentResponse response;
  AchievmentSuccess({required this.response});
}

final class AchievmentFailure extends AchievmentState {
  final ErrorType type;
  final String message;
  AchievmentFailure({this.type = ErrorType.general, this.message = ""});
  AchievmentFailure.network(String message) : this(type: ErrorType.network, message: message);
  AchievmentFailure.general(String message) : this(type: ErrorType.network, message: message);
}

