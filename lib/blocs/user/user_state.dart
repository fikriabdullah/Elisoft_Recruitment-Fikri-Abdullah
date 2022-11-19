part of 'user_cubit.dart';

@immutable
abstract class UserState extends Equatable{
  const UserState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UserInitial extends UserState{}

class UserLoading extends UserState{
  //constructor accept widget for indefinite spinner widget
}

class UserLoaded extends UserState{
  final UserModel userModel;
  const UserLoaded(this.userModel);
}

class UserError extends UserState{
  String? userErrorStringMessage;
  UserError(this.userErrorStringMessage);
}
