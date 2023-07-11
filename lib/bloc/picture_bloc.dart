import 'package:bloc/bloc.dart';
import 'package:cumamesajlari/repositroy/picture_repository.dart';
import 'package:equatable/equatable.dart';import '../getit.dart';


import '../model/picture.dart';


part 'picture_event.dart';
part 'picture_state.dart';

class PictureBloc extends Bloc<PictureEvent, PictureState> {
  PictureBloc() : super(PictureInitial()) {
    var _pictureRepository=getIt<PictureRepository>();
    on<PictureEvent>((event, emit) async{
      try{
        emit (PictureLoadingState());
        final Picture _picture= _pictureRepository.getPicture();
        if(_picture.error==null){
          emit (PictureLoadedState(picture: _picture));
        }else{
          emit (PictureErrorState());
        }
      }catch(error){
        print("Hata olustu!");
      }
    });
  }
}

