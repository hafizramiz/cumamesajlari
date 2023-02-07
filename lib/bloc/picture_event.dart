part of 'picture_bloc.dart';

abstract class PictureEvent extends Equatable {
   const PictureEvent();
}


class GetPictureEvent extends PictureEvent{
  List<Object?> get props => [];
}
