// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'note.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Note {

 String get id; String get name; String? get folderId; String get userId; DateTime get createdAt;
/// Create a copy of Note
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoteCopyWith<Note> get copyWith => _$NoteCopyWithImpl<Note>(this as Note, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Note&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.folderId, folderId) || other.folderId == folderId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,folderId,userId,createdAt);

@override
String toString() {
  return 'Note(id: $id, name: $name, folderId: $folderId, userId: $userId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $NoteCopyWith<$Res>  {
  factory $NoteCopyWith(Note value, $Res Function(Note) _then) = _$NoteCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? folderId, String userId, DateTime createdAt
});




}
/// @nodoc
class _$NoteCopyWithImpl<$Res>
    implements $NoteCopyWith<$Res> {
  _$NoteCopyWithImpl(this._self, this._then);

  final Note _self;
  final $Res Function(Note) _then;

/// Create a copy of Note
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? folderId = freezed,Object? userId = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,folderId: freezed == folderId ? _self.folderId : folderId // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Note].
extension NotePatterns on Note {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TextNote value)?  text,TResult Function( TodoNote value)?  todo,TResult Function( ListNote value)?  list,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TextNote() when text != null:
return text(_that);case TodoNote() when todo != null:
return todo(_that);case ListNote() when list != null:
return list(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TextNote value)  text,required TResult Function( TodoNote value)  todo,required TResult Function( ListNote value)  list,}){
final _that = this;
switch (_that) {
case TextNote():
return text(_that);case TodoNote():
return todo(_that);case ListNote():
return list(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TextNote value)?  text,TResult? Function( TodoNote value)?  todo,TResult? Function( ListNote value)?  list,}){
final _that = this;
switch (_that) {
case TextNote() when text != null:
return text(_that);case TodoNote() when todo != null:
return todo(_that);case ListNote() when list != null:
return list(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String id,  String name,  String? folderId,  String userId,  DateTime createdAt,  String content)?  text,TResult Function( String id,  String name,  String? folderId,  String userId,  DateTime createdAt,  List<TodoTask> tasks)?  todo,TResult Function( String id,  String name,  String? folderId,  String userId,  DateTime createdAt,  List<String> items)?  list,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TextNote() when text != null:
return text(_that.id,_that.name,_that.folderId,_that.userId,_that.createdAt,_that.content);case TodoNote() when todo != null:
return todo(_that.id,_that.name,_that.folderId,_that.userId,_that.createdAt,_that.tasks);case ListNote() when list != null:
return list(_that.id,_that.name,_that.folderId,_that.userId,_that.createdAt,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String id,  String name,  String? folderId,  String userId,  DateTime createdAt,  String content)  text,required TResult Function( String id,  String name,  String? folderId,  String userId,  DateTime createdAt,  List<TodoTask> tasks)  todo,required TResult Function( String id,  String name,  String? folderId,  String userId,  DateTime createdAt,  List<String> items)  list,}) {final _that = this;
switch (_that) {
case TextNote():
return text(_that.id,_that.name,_that.folderId,_that.userId,_that.createdAt,_that.content);case TodoNote():
return todo(_that.id,_that.name,_that.folderId,_that.userId,_that.createdAt,_that.tasks);case ListNote():
return list(_that.id,_that.name,_that.folderId,_that.userId,_that.createdAt,_that.items);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String id,  String name,  String? folderId,  String userId,  DateTime createdAt,  String content)?  text,TResult? Function( String id,  String name,  String? folderId,  String userId,  DateTime createdAt,  List<TodoTask> tasks)?  todo,TResult? Function( String id,  String name,  String? folderId,  String userId,  DateTime createdAt,  List<String> items)?  list,}) {final _that = this;
switch (_that) {
case TextNote() when text != null:
return text(_that.id,_that.name,_that.folderId,_that.userId,_that.createdAt,_that.content);case TodoNote() when todo != null:
return todo(_that.id,_that.name,_that.folderId,_that.userId,_that.createdAt,_that.tasks);case ListNote() when list != null:
return list(_that.id,_that.name,_that.folderId,_that.userId,_that.createdAt,_that.items);case _:
  return null;

}
}

}

/// @nodoc


class TextNote extends Note {
  const TextNote({required this.id, required this.name, this.folderId, required this.userId, required this.createdAt, required this.content}): super._();
  

@override final  String id;
@override final  String name;
@override final  String? folderId;
@override final  String userId;
@override final  DateTime createdAt;
 final  String content;

/// Create a copy of Note
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TextNoteCopyWith<TextNote> get copyWith => _$TextNoteCopyWithImpl<TextNote>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TextNote&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.folderId, folderId) || other.folderId == folderId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.content, content) || other.content == content));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,folderId,userId,createdAt,content);

@override
String toString() {
  return 'Note.text(id: $id, name: $name, folderId: $folderId, userId: $userId, createdAt: $createdAt, content: $content)';
}


}

/// @nodoc
abstract mixin class $TextNoteCopyWith<$Res> implements $NoteCopyWith<$Res> {
  factory $TextNoteCopyWith(TextNote value, $Res Function(TextNote) _then) = _$TextNoteCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? folderId, String userId, DateTime createdAt, String content
});




}
/// @nodoc
class _$TextNoteCopyWithImpl<$Res>
    implements $TextNoteCopyWith<$Res> {
  _$TextNoteCopyWithImpl(this._self, this._then);

  final TextNote _self;
  final $Res Function(TextNote) _then;

/// Create a copy of Note
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? folderId = freezed,Object? userId = null,Object? createdAt = null,Object? content = null,}) {
  return _then(TextNote(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,folderId: freezed == folderId ? _self.folderId : folderId // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class TodoNote extends Note {
  const TodoNote({required this.id, required this.name, this.folderId, required this.userId, required this.createdAt, required final  List<TodoTask> tasks}): _tasks = tasks,super._();
  

@override final  String id;
@override final  String name;
@override final  String? folderId;
@override final  String userId;
@override final  DateTime createdAt;
 final  List<TodoTask> _tasks;
 List<TodoTask> get tasks {
  if (_tasks is EqualUnmodifiableListView) return _tasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tasks);
}


/// Create a copy of Note
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodoNoteCopyWith<TodoNote> get copyWith => _$TodoNoteCopyWithImpl<TodoNote>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoNote&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.folderId, folderId) || other.folderId == folderId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._tasks, _tasks));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,folderId,userId,createdAt,const DeepCollectionEquality().hash(_tasks));

@override
String toString() {
  return 'Note.todo(id: $id, name: $name, folderId: $folderId, userId: $userId, createdAt: $createdAt, tasks: $tasks)';
}


}

/// @nodoc
abstract mixin class $TodoNoteCopyWith<$Res> implements $NoteCopyWith<$Res> {
  factory $TodoNoteCopyWith(TodoNote value, $Res Function(TodoNote) _then) = _$TodoNoteCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? folderId, String userId, DateTime createdAt, List<TodoTask> tasks
});




}
/// @nodoc
class _$TodoNoteCopyWithImpl<$Res>
    implements $TodoNoteCopyWith<$Res> {
  _$TodoNoteCopyWithImpl(this._self, this._then);

  final TodoNote _self;
  final $Res Function(TodoNote) _then;

/// Create a copy of Note
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? folderId = freezed,Object? userId = null,Object? createdAt = null,Object? tasks = null,}) {
  return _then(TodoNote(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,folderId: freezed == folderId ? _self.folderId : folderId // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,tasks: null == tasks ? _self._tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<TodoTask>,
  ));
}


}

/// @nodoc


class ListNote extends Note {
  const ListNote({required this.id, required this.name, this.folderId, required this.userId, required this.createdAt, required final  List<String> items}): _items = items,super._();
  

@override final  String id;
@override final  String name;
@override final  String? folderId;
@override final  String userId;
@override final  DateTime createdAt;
 final  List<String> _items;
 List<String> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of Note
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListNoteCopyWith<ListNote> get copyWith => _$ListNoteCopyWithImpl<ListNote>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListNote&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.folderId, folderId) || other.folderId == folderId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,folderId,userId,createdAt,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'Note.list(id: $id, name: $name, folderId: $folderId, userId: $userId, createdAt: $createdAt, items: $items)';
}


}

/// @nodoc
abstract mixin class $ListNoteCopyWith<$Res> implements $NoteCopyWith<$Res> {
  factory $ListNoteCopyWith(ListNote value, $Res Function(ListNote) _then) = _$ListNoteCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? folderId, String userId, DateTime createdAt, List<String> items
});




}
/// @nodoc
class _$ListNoteCopyWithImpl<$Res>
    implements $ListNoteCopyWith<$Res> {
  _$ListNoteCopyWithImpl(this._self, this._then);

  final ListNote _self;
  final $Res Function(ListNote) _then;

/// Create a copy of Note
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? folderId = freezed,Object? userId = null,Object? createdAt = null,Object? items = null,}) {
  return _then(ListNote(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,folderId: freezed == folderId ? _self.folderId : folderId // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
