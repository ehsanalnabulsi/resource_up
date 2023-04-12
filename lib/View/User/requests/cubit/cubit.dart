import 'package:flutter_bloc/flutter_bloc.dart';

import 'states.dart';

class UserRequestsCubit extends Cubit<UserRequestsStates> {
  UserRequestsCubit() : super(UserRequestsInitialState());
  static UserRequestsCubit get(context) => BlocProvider.of(context);
}
