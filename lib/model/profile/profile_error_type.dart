import 'package:flutter/material.dart';
import 'package:totalfit/exception/idle_exception.dart';
import 'package:totalfit/exception/tf_exception.dart';

class ProfileError {
  final TfException e;

  const ProfileError({@required this.e});
}

class EmptyProfileError extends ProfileError {
  EmptyProfileError() : super(e: IdleException());
}

class ViewItemError extends ProfileError {
  const ViewItemError({@required error}) : super(e: error);
}

class DeleteItemError extends ProfileError {
  const DeleteItemError({@required error}) : super(e: error);
}

class ShareItemError extends ProfileError {
  const ShareItemError({@required error}) : super(e: error);
}

class PaginationError extends ProfileError {
  const PaginationError({@required error}) : super(e: error);
}
