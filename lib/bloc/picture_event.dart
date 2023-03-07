part of 'picture_bloc.dart';

abstract class PictureEvent extends Equatable {
   const PictureEvent();
}


class GetInitialPicturesEvent extends PictureEvent{
  final int limit;
  final int deneme=23;
  GetInitialPicturesEvent({required this.limit});
  List<Object?> get props => [limit,deneme];
}

class GetMorePicturesEvent extends PictureEvent{
  final int  getMore;
  GetMorePicturesEvent({required this.getMore});
  List<Object?> get props => [];
}