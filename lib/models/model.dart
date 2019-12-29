import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

part 'model.g.dart';

const tableNotes = SqfEntityTable(
    tableName: 'notes',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    modelName: null,
    fields: [
      SqfEntityField('title', DbType.text),
      SqfEntityField('data', DbType.text),
      SqfEntityField('syncId', DbType.text, defaultValue: null),
      SqfEntityField('favourite', DbType.bool, defaultValue: false),
      SqfEntityField('createdAt', DbType.datetime),
      SqfEntityField('updatedAt', DbType.datetime),
    ]);

const seqIdentity = SqfEntitySequence(
  sequenceName: 'identity'
);

@SqfEntityBuilder(myDbModel)
const myDbModel = SqfEntityModel(
  modelName: 'MyDbModel',
  databaseName: 'my_notes.db',
  databaseTables: [tableNotes],
  sequences: [seqIdentity],
  bundledDatabasePath: null
);