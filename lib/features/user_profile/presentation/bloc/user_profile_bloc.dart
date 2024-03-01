import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_auth0_clean/features/authentication/domain/entities/user_entity.dart';
import 'package:flutter_web_auth0_clean/features/user_profile/domain/usecases/get_user_profile_usecase.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final GetUserProfileUseCase getUserProfileUseCase;
  
  UserProfileBloc({required this.getUserProfileUseCase})
      : super(UserProfileInitial()) {

    on<UserProfileLoad>((event, emit) async {
      final failureOrUserEntity = await getUserProfileUseCase();
      emit(failureOrUserEntity.fold((exception) {
        return const UserProfileLoadFailure(message: "User profile load error");
      }, (userEntity) => UserProfileLoaded(user: userEntity)));
    });

    on<UserProfileInit>((event, emit) {
      // Do nothing
    });
  }
}
