part of 'picture_bloc.dart';

abstract class PictureEvent extends Equatable {
   const PictureEvent();
  List<Object?> get props =>[];
}


class GetPictureEvent extends PictureEvent{

}