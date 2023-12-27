// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TextModelAdapter extends TypeAdapter<TextModel> {
  @override
  final int typeId = 0;

  @override
  TextModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TextModel(
      title: fields[0] as String,
      content: fields[1] as String,
      colorIndex: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TextModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.colorIndex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TextModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
