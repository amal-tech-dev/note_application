// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CheckListModelAdapter extends TypeAdapter<CheckListModel> {
  @override
  final int typeId = 1;

  @override
  CheckListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CheckListModel(
      title: fields[0] as String,
      contentList: (fields[1] as List).cast<ContentModel>(),
      dateTime: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CheckListModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.contentList)
      ..writeByte(2)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ContentModelAdapter extends TypeAdapter<ContentModel> {
  @override
  final int typeId = 2;

  @override
  ContentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContentModel(
      item: fields[0] as String,
      isMarked: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ContentModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.item)
      ..writeByte(1)
      ..write(obj.isMarked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
