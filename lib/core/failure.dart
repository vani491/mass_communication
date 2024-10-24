import 'package:equatable/equatable.dart';

/// Base class for all failures in the application.
/// We extend Equatable so that comparisons between Failure objects are easy.
abstract class Failure extends Equatable {
  const Failure();

  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}
