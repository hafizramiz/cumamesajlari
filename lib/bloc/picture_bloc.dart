import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../model/picture.dart';

part 'picture_event.dart';
part 'picture_state.dart';

class PictureBloc extends Bloc<PictureEvent, PictureState> {
  PictureBloc() : super(PictureInitial()) {
    on<PictureEvent>((event, emit) async{
    });
  }
}
