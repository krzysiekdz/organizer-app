// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TodoTask {

 String get task; bool get isDone;
/// Create a copy of TodoTask
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodoTaskCopyWith<TodoTask> get copyWith => _$TodoTaskCopyWithImpl<TodoTask>(this as TodoTask, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoTask&&(identical(other.task, task) || other.task == task)&&(identical(other.isDone, isDone) || other.isDone == isDone));
}


@override
int get hashCode => Object.hash(runtimeType,task,isDone);

@override
String toString() {
  return 'TodoTask(task: $task, isDone: $isDone)';
}


}

/// @nodoc
abstract mixin class $TodoTaskCopyWith<$Res>  {
  factory $TodoTaskCopyWith(TodoTask value, $Res Function(TodoTask) _then) = _$TodoTaskCopyWithImpl;
@useResult
$Res call({
 String task, bool isDone
});




}
/// @nodoc
class _$TodoTaskCopyWithImpl<$Res>
    implements $TodoTaskCopyWith<$Res> {
  _$TodoTaskCopyWithImpl(this._self, this._then);

  final TodoTask _self;
  final $Res Function(TodoTask) _then;

/// Create a copy of TodoTask
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? task = null,Object? isDone = null,}) {
  return _then(_self.copyWith(
task: null == task ? _self.task : task // ignore: cast_nullable_to_non_nullable
as String,isDone: null == isDone ? _self.isDone : isDone // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TodoTask].
extension TodoTaskPatterns on TodoTask {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodoTask value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodoTask() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodoTask value)  $default,){
final _that = this;
switch (_that) {
case _TodoTask():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodoTask value)?  $default,){
final _that = this;
switch (_that) {
case _TodoTask() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String task,  bool isDone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodoTask() when $default != null:
return $default(_that.task,_that.isDone);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String task,  bool isDone)  $default,) {final _that = this;
switch (_that) {
case _TodoTask():
return $default(_that.task,_that.isDone);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String task,  bool isDone)?  $default,) {final _that = this;
switch (_that) {
case _TodoTask() when $default != null:
return $default(_that.task,_that.isDone);case _:
  return null;

}
}

}

/// @nodoc


class _TodoTask extends TodoTask {
  const _TodoTask({required this.task, required this.isDone}): super._();
  

@override final  String task;
@override final  bool isDone;

/// Create a copy of TodoTask
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodoTaskCopyWith<_TodoTask> get copyWith => __$TodoTaskCopyWithImpl<_TodoTask>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodoTask&&(identical(other.task, task) || other.task == task)&&(identical(other.isDone, isDone) || other.isDone == isDone));
}


@override
int get hashCode => Object.hash(runtimeType,task,isDone);

@override
String toString() {
  return 'TodoTask(task: $task, isDone: $isDone)';
}


}

/// @nodoc
abstract mixin class _$TodoTaskCopyWith<$Res> implements $TodoTaskCopyWith<$Res> {
  factory _$TodoTaskCopyWith(_TodoTask value, $Res Function(_TodoTask) _then) = __$TodoTaskCopyWithImpl;
@override @useResult
$Res call({
 String task, bool isDone
});




}
/// @nodoc
class __$TodoTaskCopyWithImpl<$Res>
    implements _$TodoTaskCopyWith<$Res> {
  __$TodoTaskCopyWithImpl(this._self, this._then);

  final _TodoTask _self;
  final $Res Function(_TodoTask) _then;

/// Create a copy of TodoTask
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? task = null,Object? isDone = null,}) {
  return _then(_TodoTask(
task: null == task ? _self.task : task // ignore: cast_nullable_to_non_nullable
as String,isDone: null == isDone ? _self.isDone : isDone // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
