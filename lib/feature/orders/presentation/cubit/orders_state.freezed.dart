// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark
/*
part of 'orders_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mechpro/feature/orders/presentation/cubit/orders_state.dart';

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrdersState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is OrdersState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OrdersState()';
  }
}

/// @nodoc
class $OrdersStateCopyWith<$Res> {
  $OrdersStateCopyWith(OrdersState _, $Res Function(OrdersState) __);
}

/// @nodoc

class _Initial implements OrdersState {
  const _Initial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OrdersState.initial()';
  }
}

/// @nodoc

class CreateOrderLoading implements OrdersState {
  const CreateOrderLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is CreateOrderLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OrdersState.createOrderLoading()';
  }
}

/// @nodoc

class CreateOrderSuccess implements OrdersState {
  const CreateOrderSuccess({required this.message});

  final String message;

  /// Create a copy of OrdersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CreateOrderSuccessCopyWith<CreateOrderSuccess> get copyWith =>
      _$CreateOrderSuccessCopyWithImpl<CreateOrderSuccess>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CreateOrderSuccess &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'OrdersState.createOrderSuccess(message: $message)';
  }
}

/// @nodoc
abstract mixin class $CreateOrderSuccessCopyWith<$Res>
    implements $OrdersStateCopyWith<$Res> {
  factory $CreateOrderSuccessCopyWith(
          CreateOrderSuccess value, $Res Function(CreateOrderSuccess) _then) =
      _$CreateOrderSuccessCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$CreateOrderSuccessCopyWithImpl<$Res>
    implements $CreateOrderSuccessCopyWith<$Res> {
  _$CreateOrderSuccessCopyWithImpl(this._self, this._then);

  final CreateOrderSuccess _self;
  final $Res Function(CreateOrderSuccess) _then;

  /// Create a copy of OrdersState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(CreateOrderSuccess(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class CreateOrderError implements OrdersState {
  const CreateOrderError({required this.message});

  final String message;

  /// Create a copy of OrdersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CreateOrderErrorCopyWith<CreateOrderError> get copyWith =>
      _$CreateOrderErrorCopyWithImpl<CreateOrderError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CreateOrderError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'OrdersState.createOrderError(message: $message)';
  }
}

/// @nodoc
abstract mixin class $CreateOrderErrorCopyWith<$Res>
    implements $OrdersStateCopyWith<$Res> {
  factory $CreateOrderErrorCopyWith(
          CreateOrderError value, $Res Function(CreateOrderError) _then) =
      _$CreateOrderErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$CreateOrderErrorCopyWithImpl<$Res>
    implements $CreateOrderErrorCopyWith<$Res> {
  _$CreateOrderErrorCopyWithImpl(this._self, this._then);

  final CreateOrderError _self;
  final $Res Function(CreateOrderError) _then;

  /// Create a copy of OrdersState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(CreateOrderError(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
*/