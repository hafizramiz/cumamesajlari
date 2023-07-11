part of 'picture_bloc.dart';

abstract class PictureState extends Equatable {
  const PictureState();
}

class PictureInitial extends PictureState {

  List<Object?> get props => [];
}

class PictureLoadingState extends PictureState{
  List<Object?> get props => [];
  PictureLoadingState();
}

class PictureLoadedState extends PictureState{
  Picture picture;
  PictureLoadedState({required this.picture});
  List<Object?> get props => [picture];
}

class PictureErrorState extends PictureState{
  PictureErrorState();
  List<Object?> get props => [];
}
