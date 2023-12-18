// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskModelAdapter extends TypeAdapter<TaskModel> {
  @override
  final int typeId = 3;

  @override
  TaskModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskModel(
      title: fields[0] as String,
      description: fields[1] as String,
      dueDate: fields[2] as DateTime,
      state: fields[3] as TaskState,
    );
  }

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.dueDate)
      ..writeByte(3)
      ..write(obj.state);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TaskStateAdapter extends TypeAdapter<TaskState> {
  @override
  final int typeId = 4;

  @override
  TaskState read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TaskState.upcoming;
      case 1:
        return TaskState.completed;
      case 2:
        return TaskState.overdue;
      default:
        return TaskState.upcoming;
    }
  }

  @override
  void write(BinaryWriter writer, TaskState obj) {
    switch (obj) {
      case TaskState.upcoming:
        writer.writeByte(0);
        break;
      case TaskState.completed:
        writer.writeByte(1);
        break;
      case TaskState.overdue:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
