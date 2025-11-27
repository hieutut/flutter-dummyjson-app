// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CartItemTableTable extends CartItemTable
    with TableInfo<$CartItemTableTable, CartItemTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CartItemTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Product, String> product =
      GeneratedColumn<String>(
        'product',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Product>($CartItemTableTable.$converterproduct);
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    check: () => ComparableExpr(quantity).isBiggerOrEqual(const Constant(1)),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [id, product, quantity];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cart_item_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CartItemTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CartItemTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CartItemTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      product: $CartItemTableTable.$converterproduct.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}product'],
        )!,
      ),
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
    );
  }

  @override
  $CartItemTableTable createAlias(String alias) {
    return $CartItemTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Product, String, Map<String, Object?>>
  $converterproduct = const ProductConverter();
}

class CartItemTableData extends DataClass
    implements Insertable<CartItemTableData> {
  final int id;
  final Product product;
  final int quantity;
  const CartItemTableData({
    required this.id,
    required this.product,
    required this.quantity,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['product'] = Variable<String>(
        $CartItemTableTable.$converterproduct.toSql(product),
      );
    }
    map['quantity'] = Variable<int>(quantity);
    return map;
  }

  CartItemTableCompanion toCompanion(bool nullToAbsent) {
    return CartItemTableCompanion(
      id: Value(id),
      product: Value(product),
      quantity: Value(quantity),
    );
  }

  factory CartItemTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CartItemTableData(
      id: serializer.fromJson<int>(json['id']),
      product: $CartItemTableTable.$converterproduct.fromJson(
        serializer.fromJson<Map<String, Object?>>(json['product']),
      ),
      quantity: serializer.fromJson<int>(json['quantity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'product': serializer.toJson<Map<String, Object?>>(
        $CartItemTableTable.$converterproduct.toJson(product),
      ),
      'quantity': serializer.toJson<int>(quantity),
    };
  }

  CartItemTableData copyWith({int? id, Product? product, int? quantity}) =>
      CartItemTableData(
        id: id ?? this.id,
        product: product ?? this.product,
        quantity: quantity ?? this.quantity,
      );
  CartItemTableData copyWithCompanion(CartItemTableCompanion data) {
    return CartItemTableData(
      id: data.id.present ? data.id.value : this.id,
      product: data.product.present ? data.product.value : this.product,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CartItemTableData(')
          ..write('id: $id, ')
          ..write('product: $product, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, product, quantity);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CartItemTableData &&
          other.id == this.id &&
          other.product == this.product &&
          other.quantity == this.quantity);
}

class CartItemTableCompanion extends UpdateCompanion<CartItemTableData> {
  final Value<int> id;
  final Value<Product> product;
  final Value<int> quantity;
  const CartItemTableCompanion({
    this.id = const Value.absent(),
    this.product = const Value.absent(),
    this.quantity = const Value.absent(),
  });
  CartItemTableCompanion.insert({
    this.id = const Value.absent(),
    required Product product,
    this.quantity = const Value.absent(),
  }) : product = Value(product);
  static Insertable<CartItemTableData> custom({
    Expression<int>? id,
    Expression<String>? product,
    Expression<int>? quantity,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (product != null) 'product': product,
      if (quantity != null) 'quantity': quantity,
    });
  }

  CartItemTableCompanion copyWith({
    Value<int>? id,
    Value<Product>? product,
    Value<int>? quantity,
  }) {
    return CartItemTableCompanion(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (product.present) {
      map['product'] = Variable<String>(
        $CartItemTableTable.$converterproduct.toSql(product.value),
      );
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CartItemTableCompanion(')
          ..write('id: $id, ')
          ..write('product: $product, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDB extends GeneratedDatabase {
  _$AppDB(QueryExecutor e) : super(e);
  $AppDBManager get managers => $AppDBManager(this);
  late final $CartItemTableTable cartItemTable = $CartItemTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [cartItemTable];
}

typedef $$CartItemTableTableCreateCompanionBuilder =
    CartItemTableCompanion Function({
      Value<int> id,
      required Product product,
      Value<int> quantity,
    });
typedef $$CartItemTableTableUpdateCompanionBuilder =
    CartItemTableCompanion Function({
      Value<int> id,
      Value<Product> product,
      Value<int> quantity,
    });

class $$CartItemTableTableFilterComposer
    extends Composer<_$AppDB, $CartItemTableTable> {
  $$CartItemTableTableFilterComposer({
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

  ColumnWithTypeConverterFilters<Product, Product, String> get product =>
      $composableBuilder(
        column: $table.product,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CartItemTableTableOrderingComposer
    extends Composer<_$AppDB, $CartItemTableTable> {
  $$CartItemTableTableOrderingComposer({
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

  ColumnOrderings<String> get product => $composableBuilder(
    column: $table.product,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CartItemTableTableAnnotationComposer
    extends Composer<_$AppDB, $CartItemTableTable> {
  $$CartItemTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Product, String> get product =>
      $composableBuilder(column: $table.product, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);
}

class $$CartItemTableTableTableManager
    extends
        RootTableManager<
          _$AppDB,
          $CartItemTableTable,
          CartItemTableData,
          $$CartItemTableTableFilterComposer,
          $$CartItemTableTableOrderingComposer,
          $$CartItemTableTableAnnotationComposer,
          $$CartItemTableTableCreateCompanionBuilder,
          $$CartItemTableTableUpdateCompanionBuilder,
          (
            CartItemTableData,
            BaseReferences<_$AppDB, $CartItemTableTable, CartItemTableData>,
          ),
          CartItemTableData,
          PrefetchHooks Function()
        > {
  $$CartItemTableTableTableManager(_$AppDB db, $CartItemTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CartItemTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CartItemTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CartItemTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<Product> product = const Value.absent(),
                Value<int> quantity = const Value.absent(),
              }) => CartItemTableCompanion(
                id: id,
                product: product,
                quantity: quantity,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required Product product,
                Value<int> quantity = const Value.absent(),
              }) => CartItemTableCompanion.insert(
                id: id,
                product: product,
                quantity: quantity,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CartItemTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDB,
      $CartItemTableTable,
      CartItemTableData,
      $$CartItemTableTableFilterComposer,
      $$CartItemTableTableOrderingComposer,
      $$CartItemTableTableAnnotationComposer,
      $$CartItemTableTableCreateCompanionBuilder,
      $$CartItemTableTableUpdateCompanionBuilder,
      (
        CartItemTableData,
        BaseReferences<_$AppDB, $CartItemTableTable, CartItemTableData>,
      ),
      CartItemTableData,
      PrefetchHooks Function()
    >;

class $AppDBManager {
  final _$AppDB _db;
  $AppDBManager(this._db);
  $$CartItemTableTableTableManager get cartItemTable =>
      $$CartItemTableTableTableManager(_db, _db.cartItemTable);
}
