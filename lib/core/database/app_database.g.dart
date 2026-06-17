// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AppSessionsTable extends AppSessions
    with TableInfo<$AppSessionsTable, SessionRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _loginMeta = const VerificationMeta('login');
  @override
  late final GeneratedColumn<String> login = GeneratedColumn<String>(
    'login',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authenticatedAtMeta = const VerificationMeta(
    'authenticatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> authenticatedAt =
      GeneratedColumn<DateTime>(
        'authenticated_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [id, userId, login, authenticatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<SessionRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('login')) {
      context.handle(
        _loginMeta,
        login.isAcceptableOrUnknown(data['login']!, _loginMeta),
      );
    } else if (isInserting) {
      context.missing(_loginMeta);
    }
    if (data.containsKey('authenticated_at')) {
      context.handle(
        _authenticatedAtMeta,
        authenticatedAt.isAcceptableOrUnknown(
          data['authenticated_at']!,
          _authenticatedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_authenticatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SessionRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      login: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}login'],
      )!,
      authenticatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}authenticated_at'],
      )!,
    );
  }

  @override
  $AppSessionsTable createAlias(String alias) {
    return $AppSessionsTable(attachedDatabase, alias);
  }
}

class SessionRecord extends DataClass implements Insertable<SessionRecord> {
  final int id;
  final String userId;
  final String login;
  final DateTime authenticatedAt;
  const SessionRecord({
    required this.id,
    required this.userId,
    required this.login,
    required this.authenticatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['login'] = Variable<String>(login);
    map['authenticated_at'] = Variable<DateTime>(authenticatedAt);
    return map;
  }

  AppSessionsCompanion toCompanion(bool nullToAbsent) {
    return AppSessionsCompanion(
      id: Value(id),
      userId: Value(userId),
      login: Value(login),
      authenticatedAt: Value(authenticatedAt),
    );
  }

  factory SessionRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionRecord(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      login: serializer.fromJson<String>(json['login']),
      authenticatedAt: serializer.fromJson<DateTime>(json['authenticatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'login': serializer.toJson<String>(login),
      'authenticatedAt': serializer.toJson<DateTime>(authenticatedAt),
    };
  }

  SessionRecord copyWith({
    int? id,
    String? userId,
    String? login,
    DateTime? authenticatedAt,
  }) => SessionRecord(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    login: login ?? this.login,
    authenticatedAt: authenticatedAt ?? this.authenticatedAt,
  );
  SessionRecord copyWithCompanion(AppSessionsCompanion data) {
    return SessionRecord(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      login: data.login.present ? data.login.value : this.login,
      authenticatedAt: data.authenticatedAt.present
          ? data.authenticatedAt.value
          : this.authenticatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionRecord(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('login: $login, ')
          ..write('authenticatedAt: $authenticatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, login, authenticatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionRecord &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.login == this.login &&
          other.authenticatedAt == this.authenticatedAt);
}

class AppSessionsCompanion extends UpdateCompanion<SessionRecord> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> login;
  final Value<DateTime> authenticatedAt;
  const AppSessionsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.login = const Value.absent(),
    this.authenticatedAt = const Value.absent(),
  });
  AppSessionsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String login,
    required DateTime authenticatedAt,
  }) : userId = Value(userId),
       login = Value(login),
       authenticatedAt = Value(authenticatedAt);
  static Insertable<SessionRecord> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? login,
    Expression<DateTime>? authenticatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (login != null) 'login': login,
      if (authenticatedAt != null) 'authenticated_at': authenticatedAt,
    });
  }

  AppSessionsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String>? login,
    Value<DateTime>? authenticatedAt,
  }) {
    return AppSessionsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      login: login ?? this.login,
      authenticatedAt: authenticatedAt ?? this.authenticatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (login.present) {
      map['login'] = Variable<String>(login.value);
    }
    if (authenticatedAt.present) {
      map['authenticated_at'] = Variable<DateTime>(authenticatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSessionsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('login: $login, ')
          ..write('authenticatedAt: $authenticatedAt')
          ..write(')'))
        .toString();
  }
}

class $ChecklistProgressTable extends ChecklistProgress
    with TableInfo<$ChecklistProgressTable, ChecklistProgressRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChecklistProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _documentIdMeta = const VerificationMeta(
    'documentId',
  );
  @override
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
    'document_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _checkedMeta = const VerificationMeta(
    'checked',
  );
  @override
  late final GeneratedColumn<bool> checked = GeneratedColumn<bool>(
    'checked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("checked" IN (0, 1))',
    ),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [documentId, checked, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'checklist_progress';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChecklistProgressRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('document_id')) {
      context.handle(
        _documentIdMeta,
        documentId.isAcceptableOrUnknown(data['document_id']!, _documentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_documentIdMeta);
    }
    if (data.containsKey('checked')) {
      context.handle(
        _checkedMeta,
        checked.isAcceptableOrUnknown(data['checked']!, _checkedMeta),
      );
    } else if (isInserting) {
      context.missing(_checkedMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {documentId};
  @override
  ChecklistProgressRecord map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChecklistProgressRecord(
      documentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_id'],
      )!,
      checked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}checked'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ChecklistProgressTable createAlias(String alias) {
    return $ChecklistProgressTable(attachedDatabase, alias);
  }
}

class ChecklistProgressRecord extends DataClass
    implements Insertable<ChecklistProgressRecord> {
  final String documentId;
  final bool checked;
  final DateTime updatedAt;
  const ChecklistProgressRecord({
    required this.documentId,
    required this.checked,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['document_id'] = Variable<String>(documentId);
    map['checked'] = Variable<bool>(checked);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ChecklistProgressCompanion toCompanion(bool nullToAbsent) {
    return ChecklistProgressCompanion(
      documentId: Value(documentId),
      checked: Value(checked),
      updatedAt: Value(updatedAt),
    );
  }

  factory ChecklistProgressRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChecklistProgressRecord(
      documentId: serializer.fromJson<String>(json['documentId']),
      checked: serializer.fromJson<bool>(json['checked']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'documentId': serializer.toJson<String>(documentId),
      'checked': serializer.toJson<bool>(checked),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ChecklistProgressRecord copyWith({
    String? documentId,
    bool? checked,
    DateTime? updatedAt,
  }) => ChecklistProgressRecord(
    documentId: documentId ?? this.documentId,
    checked: checked ?? this.checked,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ChecklistProgressRecord copyWithCompanion(ChecklistProgressCompanion data) {
    return ChecklistProgressRecord(
      documentId: data.documentId.present
          ? data.documentId.value
          : this.documentId,
      checked: data.checked.present ? data.checked.value : this.checked,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChecklistProgressRecord(')
          ..write('documentId: $documentId, ')
          ..write('checked: $checked, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(documentId, checked, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChecklistProgressRecord &&
          other.documentId == this.documentId &&
          other.checked == this.checked &&
          other.updatedAt == this.updatedAt);
}

class ChecklistProgressCompanion
    extends UpdateCompanion<ChecklistProgressRecord> {
  final Value<String> documentId;
  final Value<bool> checked;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ChecklistProgressCompanion({
    this.documentId = const Value.absent(),
    this.checked = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChecklistProgressCompanion.insert({
    required String documentId,
    required bool checked,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : documentId = Value(documentId),
       checked = Value(checked),
       updatedAt = Value(updatedAt);
  static Insertable<ChecklistProgressRecord> custom({
    Expression<String>? documentId,
    Expression<bool>? checked,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (documentId != null) 'document_id': documentId,
      if (checked != null) 'checked': checked,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChecklistProgressCompanion copyWith({
    Value<String>? documentId,
    Value<bool>? checked,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ChecklistProgressCompanion(
      documentId: documentId ?? this.documentId,
      checked: checked ?? this.checked,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (checked.present) {
      map['checked'] = Variable<bool>(checked.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChecklistProgressCompanion(')
          ..write('documentId: $documentId, ')
          ..write('checked: $checked, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SavedSantinhosTable extends SavedSantinhos
    with TableInfo<$SavedSantinhosTable, SavedSantinhoRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavedSantinhosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _santinhoIdMeta = const VerificationMeta(
    'santinhoId',
  );
  @override
  late final GeneratedColumn<String> santinhoId = GeneratedColumn<String>(
    'santinho_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _savedAtMeta = const VerificationMeta(
    'savedAt',
  );
  @override
  late final GeneratedColumn<DateTime> savedAt = GeneratedColumn<DateTime>(
    'saved_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [santinhoId, savedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'saved_santinhos';
  @override
  VerificationContext validateIntegrity(
    Insertable<SavedSantinhoRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('santinho_id')) {
      context.handle(
        _santinhoIdMeta,
        santinhoId.isAcceptableOrUnknown(data['santinho_id']!, _santinhoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_santinhoIdMeta);
    }
    if (data.containsKey('saved_at')) {
      context.handle(
        _savedAtMeta,
        savedAt.isAcceptableOrUnknown(data['saved_at']!, _savedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_savedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {santinhoId};
  @override
  SavedSantinhoRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavedSantinhoRecord(
      santinhoId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}santinho_id'],
      )!,
      savedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}saved_at'],
      )!,
    );
  }

  @override
  $SavedSantinhosTable createAlias(String alias) {
    return $SavedSantinhosTable(attachedDatabase, alias);
  }
}

class SavedSantinhoRecord extends DataClass
    implements Insertable<SavedSantinhoRecord> {
  final String santinhoId;
  final DateTime savedAt;
  const SavedSantinhoRecord({required this.santinhoId, required this.savedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['santinho_id'] = Variable<String>(santinhoId);
    map['saved_at'] = Variable<DateTime>(savedAt);
    return map;
  }

  SavedSantinhosCompanion toCompanion(bool nullToAbsent) {
    return SavedSantinhosCompanion(
      santinhoId: Value(santinhoId),
      savedAt: Value(savedAt),
    );
  }

  factory SavedSantinhoRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavedSantinhoRecord(
      santinhoId: serializer.fromJson<String>(json['santinhoId']),
      savedAt: serializer.fromJson<DateTime>(json['savedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'santinhoId': serializer.toJson<String>(santinhoId),
      'savedAt': serializer.toJson<DateTime>(savedAt),
    };
  }

  SavedSantinhoRecord copyWith({String? santinhoId, DateTime? savedAt}) =>
      SavedSantinhoRecord(
        santinhoId: santinhoId ?? this.santinhoId,
        savedAt: savedAt ?? this.savedAt,
      );
  SavedSantinhoRecord copyWithCompanion(SavedSantinhosCompanion data) {
    return SavedSantinhoRecord(
      santinhoId: data.santinhoId.present
          ? data.santinhoId.value
          : this.santinhoId,
      savedAt: data.savedAt.present ? data.savedAt.value : this.savedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SavedSantinhoRecord(')
          ..write('santinhoId: $santinhoId, ')
          ..write('savedAt: $savedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(santinhoId, savedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavedSantinhoRecord &&
          other.santinhoId == this.santinhoId &&
          other.savedAt == this.savedAt);
}

class SavedSantinhosCompanion extends UpdateCompanion<SavedSantinhoRecord> {
  final Value<String> santinhoId;
  final Value<DateTime> savedAt;
  final Value<int> rowid;
  const SavedSantinhosCompanion({
    this.santinhoId = const Value.absent(),
    this.savedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SavedSantinhosCompanion.insert({
    required String santinhoId,
    required DateTime savedAt,
    this.rowid = const Value.absent(),
  }) : santinhoId = Value(santinhoId),
       savedAt = Value(savedAt);
  static Insertable<SavedSantinhoRecord> custom({
    Expression<String>? santinhoId,
    Expression<DateTime>? savedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (santinhoId != null) 'santinho_id': santinhoId,
      if (savedAt != null) 'saved_at': savedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SavedSantinhosCompanion copyWith({
    Value<String>? santinhoId,
    Value<DateTime>? savedAt,
    Value<int>? rowid,
  }) {
    return SavedSantinhosCompanion(
      santinhoId: santinhoId ?? this.santinhoId,
      savedAt: savedAt ?? this.savedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (santinhoId.present) {
      map['santinho_id'] = Variable<String>(santinhoId.value);
    }
    if (savedAt.present) {
      map['saved_at'] = Variable<DateTime>(savedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavedSantinhosCompanion(')
          ..write('santinhoId: $santinhoId, ')
          ..write('savedAt: $savedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppPreferencesTable extends AppPreferences
    with TableInfo<$AppPreferencesTable, AppPreferenceRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppPreferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_preferences';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppPreferenceRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppPreferenceRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppPreferenceRecord(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AppPreferencesTable createAlias(String alias) {
    return $AppPreferencesTable(attachedDatabase, alias);
  }
}

class AppPreferenceRecord extends DataClass
    implements Insertable<AppPreferenceRecord> {
  final String key;
  final String value;
  final DateTime updatedAt;
  const AppPreferenceRecord({
    required this.key,
    required this.value,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppPreferencesCompanion toCompanion(bool nullToAbsent) {
    return AppPreferencesCompanion(
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppPreferenceRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppPreferenceRecord(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppPreferenceRecord copyWith({
    String? key,
    String? value,
    DateTime? updatedAt,
  }) => AppPreferenceRecord(
    key: key ?? this.key,
    value: value ?? this.value,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AppPreferenceRecord copyWithCompanion(AppPreferencesCompanion data) {
    return AppPreferenceRecord(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppPreferenceRecord(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppPreferenceRecord &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class AppPreferencesCompanion extends UpdateCompanion<AppPreferenceRecord> {
  final Value<String> key;
  final Value<String> value;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AppPreferencesCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppPreferencesCompanion.insert({
    required String key,
    required String value,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value),
       updatedAt = Value(updatedAt);
  static Insertable<AppPreferenceRecord> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppPreferencesCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return AppPreferencesCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppPreferencesCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AppSessionsTable appSessions = $AppSessionsTable(this);
  late final $ChecklistProgressTable checklistProgress =
      $ChecklistProgressTable(this);
  late final $SavedSantinhosTable savedSantinhos = $SavedSantinhosTable(this);
  late final $AppPreferencesTable appPreferences = $AppPreferencesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    appSessions,
    checklistProgress,
    savedSantinhos,
    appPreferences,
  ];
}

typedef $$AppSessionsTableCreateCompanionBuilder =
    AppSessionsCompanion Function({
      Value<int> id,
      required String userId,
      required String login,
      required DateTime authenticatedAt,
    });
typedef $$AppSessionsTableUpdateCompanionBuilder =
    AppSessionsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<String> login,
      Value<DateTime> authenticatedAt,
    });

class $$AppSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSessionsTable> {
  $$AppSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get login => $composableBuilder(
    column: $table.login,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get authenticatedAt => $composableBuilder(
    column: $table.authenticatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSessionsTable> {
  $$AppSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get login => $composableBuilder(
    column: $table.login,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get authenticatedAt => $composableBuilder(
    column: $table.authenticatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSessionsTable> {
  $$AppSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get login =>
      $composableBuilder(column: $table.login, builder: (column) => column);

  GeneratedColumn<DateTime> get authenticatedAt => $composableBuilder(
    column: $table.authenticatedAt,
    builder: (column) => column,
  );
}

class $$AppSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSessionsTable,
          SessionRecord,
          $$AppSessionsTableFilterComposer,
          $$AppSessionsTableOrderingComposer,
          $$AppSessionsTableAnnotationComposer,
          $$AppSessionsTableCreateCompanionBuilder,
          $$AppSessionsTableUpdateCompanionBuilder,
          (
            SessionRecord,
            BaseReferences<_$AppDatabase, $AppSessionsTable, SessionRecord>,
          ),
          SessionRecord,
          PrefetchHooks Function()
        > {
  $$AppSessionsTableTableManager(_$AppDatabase db, $AppSessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> login = const Value.absent(),
                Value<DateTime> authenticatedAt = const Value.absent(),
              }) => AppSessionsCompanion(
                id: id,
                userId: userId,
                login: login,
                authenticatedAt: authenticatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required String login,
                required DateTime authenticatedAt,
              }) => AppSessionsCompanion.insert(
                id: id,
                userId: userId,
                login: login,
                authenticatedAt: authenticatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSessionsTable,
      SessionRecord,
      $$AppSessionsTableFilterComposer,
      $$AppSessionsTableOrderingComposer,
      $$AppSessionsTableAnnotationComposer,
      $$AppSessionsTableCreateCompanionBuilder,
      $$AppSessionsTableUpdateCompanionBuilder,
      (
        SessionRecord,
        BaseReferences<_$AppDatabase, $AppSessionsTable, SessionRecord>,
      ),
      SessionRecord,
      PrefetchHooks Function()
    >;
typedef $$ChecklistProgressTableCreateCompanionBuilder =
    ChecklistProgressCompanion Function({
      required String documentId,
      required bool checked,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ChecklistProgressTableUpdateCompanionBuilder =
    ChecklistProgressCompanion Function({
      Value<String> documentId,
      Value<bool> checked,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$ChecklistProgressTableFilterComposer
    extends Composer<_$AppDatabase, $ChecklistProgressTable> {
  $$ChecklistProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get documentId => $composableBuilder(
    column: $table.documentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get checked => $composableBuilder(
    column: $table.checked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ChecklistProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $ChecklistProgressTable> {
  $$ChecklistProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get documentId => $composableBuilder(
    column: $table.documentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get checked => $composableBuilder(
    column: $table.checked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ChecklistProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChecklistProgressTable> {
  $$ChecklistProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get documentId => $composableBuilder(
    column: $table.documentId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get checked =>
      $composableBuilder(column: $table.checked, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ChecklistProgressTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChecklistProgressTable,
          ChecklistProgressRecord,
          $$ChecklistProgressTableFilterComposer,
          $$ChecklistProgressTableOrderingComposer,
          $$ChecklistProgressTableAnnotationComposer,
          $$ChecklistProgressTableCreateCompanionBuilder,
          $$ChecklistProgressTableUpdateCompanionBuilder,
          (
            ChecklistProgressRecord,
            BaseReferences<
              _$AppDatabase,
              $ChecklistProgressTable,
              ChecklistProgressRecord
            >,
          ),
          ChecklistProgressRecord,
          PrefetchHooks Function()
        > {
  $$ChecklistProgressTableTableManager(
    _$AppDatabase db,
    $ChecklistProgressTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChecklistProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChecklistProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChecklistProgressTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> documentId = const Value.absent(),
                Value<bool> checked = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChecklistProgressCompanion(
                documentId: documentId,
                checked: checked,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String documentId,
                required bool checked,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ChecklistProgressCompanion.insert(
                documentId: documentId,
                checked: checked,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ChecklistProgressTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChecklistProgressTable,
      ChecklistProgressRecord,
      $$ChecklistProgressTableFilterComposer,
      $$ChecklistProgressTableOrderingComposer,
      $$ChecklistProgressTableAnnotationComposer,
      $$ChecklistProgressTableCreateCompanionBuilder,
      $$ChecklistProgressTableUpdateCompanionBuilder,
      (
        ChecklistProgressRecord,
        BaseReferences<
          _$AppDatabase,
          $ChecklistProgressTable,
          ChecklistProgressRecord
        >,
      ),
      ChecklistProgressRecord,
      PrefetchHooks Function()
    >;
typedef $$SavedSantinhosTableCreateCompanionBuilder =
    SavedSantinhosCompanion Function({
      required String santinhoId,
      required DateTime savedAt,
      Value<int> rowid,
    });
typedef $$SavedSantinhosTableUpdateCompanionBuilder =
    SavedSantinhosCompanion Function({
      Value<String> santinhoId,
      Value<DateTime> savedAt,
      Value<int> rowid,
    });

class $$SavedSantinhosTableFilterComposer
    extends Composer<_$AppDatabase, $SavedSantinhosTable> {
  $$SavedSantinhosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get santinhoId => $composableBuilder(
    column: $table.santinhoId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get savedAt => $composableBuilder(
    column: $table.savedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SavedSantinhosTableOrderingComposer
    extends Composer<_$AppDatabase, $SavedSantinhosTable> {
  $$SavedSantinhosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get santinhoId => $composableBuilder(
    column: $table.santinhoId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get savedAt => $composableBuilder(
    column: $table.savedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SavedSantinhosTableAnnotationComposer
    extends Composer<_$AppDatabase, $SavedSantinhosTable> {
  $$SavedSantinhosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get santinhoId => $composableBuilder(
    column: $table.santinhoId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get savedAt =>
      $composableBuilder(column: $table.savedAt, builder: (column) => column);
}

class $$SavedSantinhosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SavedSantinhosTable,
          SavedSantinhoRecord,
          $$SavedSantinhosTableFilterComposer,
          $$SavedSantinhosTableOrderingComposer,
          $$SavedSantinhosTableAnnotationComposer,
          $$SavedSantinhosTableCreateCompanionBuilder,
          $$SavedSantinhosTableUpdateCompanionBuilder,
          (
            SavedSantinhoRecord,
            BaseReferences<
              _$AppDatabase,
              $SavedSantinhosTable,
              SavedSantinhoRecord
            >,
          ),
          SavedSantinhoRecord,
          PrefetchHooks Function()
        > {
  $$SavedSantinhosTableTableManager(
    _$AppDatabase db,
    $SavedSantinhosTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SavedSantinhosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SavedSantinhosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SavedSantinhosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> santinhoId = const Value.absent(),
                Value<DateTime> savedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SavedSantinhosCompanion(
                santinhoId: santinhoId,
                savedAt: savedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String santinhoId,
                required DateTime savedAt,
                Value<int> rowid = const Value.absent(),
              }) => SavedSantinhosCompanion.insert(
                santinhoId: santinhoId,
                savedAt: savedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SavedSantinhosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SavedSantinhosTable,
      SavedSantinhoRecord,
      $$SavedSantinhosTableFilterComposer,
      $$SavedSantinhosTableOrderingComposer,
      $$SavedSantinhosTableAnnotationComposer,
      $$SavedSantinhosTableCreateCompanionBuilder,
      $$SavedSantinhosTableUpdateCompanionBuilder,
      (
        SavedSantinhoRecord,
        BaseReferences<
          _$AppDatabase,
          $SavedSantinhosTable,
          SavedSantinhoRecord
        >,
      ),
      SavedSantinhoRecord,
      PrefetchHooks Function()
    >;
typedef $$AppPreferencesTableCreateCompanionBuilder =
    AppPreferencesCompanion Function({
      required String key,
      required String value,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$AppPreferencesTableUpdateCompanionBuilder =
    AppPreferencesCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$AppPreferencesTableFilterComposer
    extends Composer<_$AppDatabase, $AppPreferencesTable> {
  $$AppPreferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppPreferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $AppPreferencesTable> {
  $$AppPreferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppPreferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppPreferencesTable> {
  $$AppPreferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AppPreferencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppPreferencesTable,
          AppPreferenceRecord,
          $$AppPreferencesTableFilterComposer,
          $$AppPreferencesTableOrderingComposer,
          $$AppPreferencesTableAnnotationComposer,
          $$AppPreferencesTableCreateCompanionBuilder,
          $$AppPreferencesTableUpdateCompanionBuilder,
          (
            AppPreferenceRecord,
            BaseReferences<
              _$AppDatabase,
              $AppPreferencesTable,
              AppPreferenceRecord
            >,
          ),
          AppPreferenceRecord,
          PrefetchHooks Function()
        > {
  $$AppPreferencesTableTableManager(
    _$AppDatabase db,
    $AppPreferencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppPreferencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppPreferencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppPreferencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppPreferencesCompanion(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => AppPreferencesCompanion.insert(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppPreferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppPreferencesTable,
      AppPreferenceRecord,
      $$AppPreferencesTableFilterComposer,
      $$AppPreferencesTableOrderingComposer,
      $$AppPreferencesTableAnnotationComposer,
      $$AppPreferencesTableCreateCompanionBuilder,
      $$AppPreferencesTableUpdateCompanionBuilder,
      (
        AppPreferenceRecord,
        BaseReferences<
          _$AppDatabase,
          $AppPreferencesTable,
          AppPreferenceRecord
        >,
      ),
      AppPreferenceRecord,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AppSessionsTableTableManager get appSessions =>
      $$AppSessionsTableTableManager(_db, _db.appSessions);
  $$ChecklistProgressTableTableManager get checklistProgress =>
      $$ChecklistProgressTableTableManager(_db, _db.checklistProgress);
  $$SavedSantinhosTableTableManager get savedSantinhos =>
      $$SavedSantinhosTableTableManager(_db, _db.savedSantinhos);
  $$AppPreferencesTableTableManager get appPreferences =>
      $$AppPreferencesTableTableManager(_db, _db.appPreferences);
}
