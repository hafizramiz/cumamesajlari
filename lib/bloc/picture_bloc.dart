import 'package:bloc/bloc.dart';
import 'package:cumamesajlari/repositroy/picture_repository.dart';
import 'package:equatable/equatable.dart';import '../getit.dart';


import '../model/picture.dart';


part 'picture_event.dart';
part 'picture_state.dart';

class PictureBloc extends Bloc<PictureEvent, PictureState> {
  PictureBloc() : super(PictureInitial()) {
    var _pictureRepository=getIt<PictureRepository>();
    on<PictureEvent>((PictureEvent event, emit) async{
      if (event is GetInitialPicturesEvent){
        print("Arayuzden yollanan event GetInitialPicturesEvent eventtir");
        print("GetInitialPicturesEvent eventinin class degiskeni: ${event.limit}");
        print("GetInitialPicturesEvent eventinin class degiskeni: ${event.props}");
        print("GetMorePicturesEvent sinifinin degiskeni: ${event.props}");

        try{
          emit (PictureLoadingState(loading: "Yukleniyor"));
          final Picture _picture=await _pictureRepository.getPicture();
          if(_picture.error==null){
            emit (PictureLoadedState(picture: _picture));
          }
          // else{
          //   emit (PictureErrorState());
          // }
        }catch(error){
          print("Hata olustu!");
        }
      } else{

        print("Arayuzden yollanan event GetMorePicturesEvent eventtir");
        emit (PictureErrorState(aciklama: "GetMorePicturesEvent yollandi"));
      }

    });
  }
}

