// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_restaurant_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListRestaurantModelAdapter extends TypeAdapter<ListRestaurantModel> {
  @override
  final int typeId = 0;

  @override
  ListRestaurantModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListRestaurantModel(
      error: fields[0] as bool?,
      message: fields[1] as String?,
      count: fields[2] as int?,
      restaurants: (fields[3] as List?)?.cast<Restaurants>(),
    );
  }

  @override
  void write(BinaryWriter writer, ListRestaurantModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.error)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.count)
      ..writeByte(3)
      ..write(obj.restaurants);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListRestaurantModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RestaurantsAdapter extends TypeAdapter<Restaurants> {
  @override
  final int typeId = 1;

  @override
  Restaurants read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Restaurants(
      id: fields[0] as String?,
      name: fields[1] as String?,
      description: fields[2] as String?,
      pictureId: fields[3] as String?,
      city: fields[4] as String?,
      rating: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Restaurants obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.pictureId)
      ..writeByte(4)
      ..write(obj.city)
      ..writeByte(5)
      ..write(obj.rating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestaurantsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
