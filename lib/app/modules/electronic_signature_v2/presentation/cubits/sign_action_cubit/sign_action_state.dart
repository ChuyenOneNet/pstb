import 'package:equatable/equatable.dart';

enum SignActionStatus { idle, signing, revoking, success, failure }

class SignActionState extends Equatable {
  final SignActionStatus status;
  final String? message;

  const SignActionState({this.status = SignActionStatus.idle, this.message});

  SignActionState copyWith({SignActionStatus? status, String? message}) =>
      SignActionState(status: status ?? this.status, message: message);

  @override
  List<Object?> get props => [status, message];
}
