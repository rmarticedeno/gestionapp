part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoadInProgress extends ProfileState {}

class ProfileLoadedSuccess extends ProfileState {
  final UserData profile;

  ProfileLoadedSuccess({
    this.profile,
  });

  @override
  List<Object> get props => [profile];
}

class ProfileLoadedFailure extends ProfileState {
  final String error;

  ProfileLoadedFailure({
    this.error,
  });

  @override
  List<Object> get props => [error];
}
