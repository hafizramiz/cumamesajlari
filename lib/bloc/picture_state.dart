part of 'picture_bloc.dart';

abstract class PictureState extends Equatable {
  const PictureState();
  List<Object> get props => [];
}

class PictureInitial extends PictureState {

}

class PictureLoadingState extends PictureState{}

class PictureLoaded extends PictureState{
  final Picture picture;
  const PictureLoaded({required this.picture});
}

class PictureErrorState extends PictureState{}
