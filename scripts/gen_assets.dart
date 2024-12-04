// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, non_constant_identifier_names, unused_element

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';

void main(List<String> arguments) async {
  late _AssetGeneratorConfig config;
  try {
    final File configFile = File(arguments[0]);
    final String configContent = await configFile.readAsString();
    config = _AssetGeneratorConfig.fromJson(jsonDecode(configContent));
  } catch (e) {
    print('🔥 Error when reading config file: $e');
    print('=> Using default config');
    config = _AssetGeneratorConfig();
  }

  print('***[${config.outputClassName}] STARTED ***');

  print('- Config: ${_StringUtil.prettyJsonStr(config.toJson())}');

  final assetGenerator = _AssetGenerator(config);
  await assetGenerator.generate();

  print('***[${config.outputClassName}] GENERATED ${assetGenerator.total} files ***');
}

class _AssetGenerator {
  final _AssetGeneratorConfig config;

  late final Directory _projectDir;
  late final String _assetDirPath;

  _AssetGenerator(this.config) {
    _projectDir = Directory.current;
    _assetDirPath = join(_projectDir.path, config.assetFolder);
    print('- Asset folder: $_assetDirPath');
  }

  static const String _LIB_FOLDER = 'lib';
  static const String _GENERATED_FILE_EXTENSION = '.gen.dart';

  int get total => _total;
  int _total = 0;
  Map<String, bool> _mark = {};

  Future<void> generate() async {
    _total = 0;
    _mark = {};

    final String content = await _genAssetsOfDirectory(Directory(_assetDirPath));

    final Directory outputFolder = Directory(join(_projectDir.path, _LIB_FOLDER, config.outputFolder));
    await _deleteOldGeneratedFiles(outputFolder);
    final File outputFile = File(
      join(
        outputFolder.path,
        (config.outputFileName ?? _Casing.snakeCase(config.outputClassName)) + _GENERATED_FILE_EXTENSION,
      ),
    );
    if (await outputFile.exists() == false) {
      await outputFile.create(recursive: true);
    }
    await outputFile.writeAsString(_OutputFileTemplate.fileContent(config.outputClassName, content));
    print('- Output file: ${outputFile.path}');
  }

  Future<void> _deleteOldGeneratedFiles(Directory folder) async {
    final List<File> files = await folder.getFiles();
    for (File file in files) {
      if (file.path.endsWith(_GENERATED_FILE_EXTENSION)) {
        await file.delete();
      }
    }
  }

  Future<String> _genAssetsOfDirectory(Directory dir) async {
    final String dirName = dir.path.replaceFirst('$_assetDirPath/', '');
    if (config.isIgnoreFolder(dirName)) return '';

    String content = '';

    final List<File> files = await dir.getFiles();
    files.removeWhere((f) {
      final String filePath = f.path.replaceFirst('$_assetDirPath/', '');
      return config.isIgnoreFile(filePath);
    });
    if (files.isNotEmpty) {
      content += _OutputFileTemplate.commentAssetDirectory(dirName);
      files.sort((a, b) => a.path.compareTo(b.path));
      for (File file in files) {
        content += _genAssetDeclarationForFile(file);
      }
      _total += files.length;
    }

    final List<Directory> subDirectories = await dir.getSubDirectories();
    if (subDirectories.isNotEmpty) {
      subDirectories.sort((a, b) => a.path.compareTo(b.path));
      for (Directory subDir in subDirectories) {
        content += (await _genAssetsOfDirectory(subDir));
      }
    }

    return content;
  }

  String _genAssetDeclarationForFile(File file) {
    final String assetPath = file.path.replaceFirst('${_projectDir.path}/', '');
    final String assetFileType = assetPath.split('.').last;
    final String assetName = _getAssetNameFromFile(file);
    return _OutputFileTemplate.assetDeclaration(
      config.assetCaseType.casing(assetName + '_' + assetFileType),
      assetPath,
    );
  }

  String _getAssetNameFromFile(File file) {
    final String assetNameRaw = config.includeFolderInAssetName
        ? _StringUtil.removeExtension(file.path.replaceFirst('$_assetDirPath/', ''))
        : basenameWithoutExtension(file.path);
    String assetName = assetNameRaw;
    int count = 1;
    while (_mark[assetName] == true) {
      assetName = '${assetNameRaw}_$count';
      count++;
    }
    _mark[assetName] = true;
    return assetName;
  }
}

class _OutputFileTemplate {
  static final String _NEW_LINE = Platform.lineTerminator;

  static String fileContent(String className, String classContent) {
    return '''
// ignore_for_file: constant_identifier_names

// GENERATED CODE - DO NOT MODIFY BY HAND

class $className {
  $className._();
$classContent}
''';
  }

  static String commentAssetDirectory(String dirName) {
    return '$_NEW_LINE\t// Assets in $dirName$_NEW_LINE';
  }

  static String assetDeclaration(String name, String path) {
    return "\tstatic const String $name = '$path';$_NEW_LINE";
  }
}

class _AssetGeneratorConfig {
  static const String _DEFAULT_ASSET_FOLDER = 'assets';
  static const String _DEFAULT_OUTPUT_CLASS_NAME = 'Assets';
  static const String? _DEFAULT_OUTPUT_FILE_NAME = null;
  static const String _DEFAULT_OUTPUT_FOLDER = 'common/constants';
  static const _CaseType _DEFAULT_ASSET_CASE_TYPE = _CaseType.defaultCase;
  static const bool _DEFAULT_INCLUDE_FOLDER_IN_ASSET_NAME = false;
  static const List<String> _DEFAULT_IGNORE_FILE_TYPES = ['DS_Store'];
  static const List<String> _DEFAULT_IGNORE_ASSET_FOLDERS = [];
  static const List<String> _DEFAULT_IGNORE_ASSET_FILES = [];

  _AssetGeneratorConfig({
    String? assetFolder,
    String? outputClassName,
    String? outputFileName,
    String? outputFolder,
    _CaseType? assetCaseType,
    bool? includeFolderInAssetName,
    List<String>? ignoreFileExtensions,
    List<String>? ignoreAssetFolders,
    List<String>? ignoreAssetFiles,
  })  : assetFolder = _StringUtil.trimSlash(assetFolder ?? _DEFAULT_ASSET_FOLDER),
        outputClassName = _Casing.pascalCase(outputClassName ?? _DEFAULT_OUTPUT_CLASS_NAME),
        outputFileName = outputFileName ?? _DEFAULT_OUTPUT_FILE_NAME,
        outputFolder = _StringUtil.trimSlash(outputFolder ?? _DEFAULT_OUTPUT_FOLDER),
        assetCaseType = assetCaseType ?? _DEFAULT_ASSET_CASE_TYPE,
        includeFolderInAssetName = includeFolderInAssetName ?? _DEFAULT_INCLUDE_FOLDER_IN_ASSET_NAME,
        ignoreFileExtensions = (ignoreFileExtensions ?? _DEFAULT_IGNORE_FILE_TYPES)
            .map(_StringUtil.trimDot)
            .map(_StringUtil.upperCase)
            .toList(),
        ignoreAssetFolders = (ignoreAssetFolders ?? _DEFAULT_IGNORE_ASSET_FOLDERS).map(_StringUtil.trimSlash).toList(),
        ignoreAssetFiles = (ignoreAssetFiles ?? _DEFAULT_IGNORE_ASSET_FILES).map(_StringUtil.trimSlash).toList();

  final String assetFolder;
  final String outputClassName;
  final String? outputFileName;
  final String outputFolder;
  final _CaseType assetCaseType;
  final bool includeFolderInAssetName;
  final List<String> ignoreFileExtensions;
  final List<String> ignoreAssetFolders;
  final List<String> ignoreAssetFiles;

  bool isIgnoreFile(String path) {
    final String fileType = path.split('.').last.toUpperCase();
    return ignoreAssetFiles.contains(path) || ignoreFileExtensions.contains(fileType);
  }

  bool isIgnoreFolder(String path) {
    return ignoreAssetFolders.contains(path);
  }

  factory _AssetGeneratorConfig.fromJson(Map<String, dynamic> json) {
    return _AssetGeneratorConfig(
      assetFolder: json['asset_folder'] as String?,
      outputClassName: json['output_class_name'] as String?,
      outputFileName: json['output_file_name'] as String?,
      outputFolder: json['output_folder'] as String?,
      assetCaseType: _CaseType.fromString(json['asset_case_type'] as String?),
      includeFolderInAssetName: json['include_folder_in_asset_name'] as bool?,
      ignoreFileExtensions: json['ignore_file_extensions'] != null
          ? (json['ignore_file_extensions'] as List<dynamic>).map((e) => e as String).toList()
          : null,
      ignoreAssetFolders: json['ignore_asset_folders'] != null
          ? (json['ignore_asset_folders'] as List<dynamic>).map((e) => e as String).toList()
          : null,
      ignoreAssetFiles: json['ignore_asset_files'] != null
          ? (json['ignore_asset_files'] as List<dynamic>).map((e) => e as String).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'asset_folder': assetFolder,
      'output_class_name': outputClassName,
      'output_file_name': outputFileName,
      'output_folder': outputFolder,
      'asset_case_type': assetCaseType.name,
      'include_folder_in_asset_name': includeFolderInAssetName,
      'ignore_file_extensions': ignoreFileExtensions,
      'ignore_asset_folders': ignoreAssetFolders,
      'ignore_asset_files': ignoreAssetFiles,
    };
  }
}

enum _CaseType {
  /// snake_case
  snake,

  /// camelCase
  camel,

  /// CONSTANT_CASE
  constant;

  static const _CaseType defaultCase = _CaseType.snake;

  static _CaseType fromString(String? s) {
    return _CaseType.values.firstWhere(
      (e) => e.name == s,
      orElse: () => _CaseType.defaultCase,
    );
  }

  String casing(String s) {
    return switch (this) {
      _CaseType.snake => _Casing.snakeCase(s),
      _CaseType.camel => _Casing.camelCase(s),
      _CaseType.constant => _Casing.constantCase(s),
    };
  }
}

extension _DirectoryExt on Directory {
  Future<List<File>> getFiles() async {
    return (await getFilesAndSubDirectories(filter: (entity) => entity is File)).cast<File>();
  }

  Future<List<Directory>> getSubDirectories() async {
    return (await getFilesAndSubDirectories(filter: (entity) => entity is Directory)).cast<Directory>();
  }

  Future<List<FileSystemEntity>> getFilesAndSubDirectories({bool Function(FileSystemEntity entity)? filter}) {
    final List<FileSystemEntity> _list = [];
    final Completer<List<FileSystemEntity>> completer = Completer();
    list(recursive: false).listen(
      (e) {
        if (filter == null || filter(e) == true) _list.add(e);
      },
      onDone: () => completer.complete(_list),
    );
    return completer.future;
  }
}

class _StringUtil {
  static String upperCase(String s) {
    return s.toUpperCase();
  }

  static String trimSlash(String s) {
    return s.replaceAll(RegExp(r'^/+'), '').replaceAll(RegExp(r'/+$'), '');
  }

  static String trimDot(String s) {
    return s.replaceAll(RegExp(r'^[.]+'), '').replaceAll(RegExp(r'[.]+$'), '');
  }

  static String prettyJsonStr(Map<dynamic, dynamic> json) {
    final encoder = JsonEncoder.withIndent('  ', (data) => data.toString());
    return encoder.convert(json);
  }

  static String removeExtension(String s) {
    final int index = s.lastIndexOf('.');
    return index == -1 ? s : s.substring(0, index);
  }
}

class _Casing {
  static final RegExp _symbols = RegExp(r'[ ./_\-\\]');
  static final RegExp _camelPascalCase = RegExp(r'(?<=[a-z])(?=[A-Z])|(?<=[A-Z])(?=[A-Z][a-z])');
  static final RegExp _digitRegExp = RegExp(r'\d');
  static final RegExp _letterRegExp = RegExp(r'[a-zA-Z]');

  /// 'test string' -> 'testString'
  static String camelCase(String input) {
    final group = _getWordsGroup(input);

    final buffer = StringBuffer();

    for (int i = 0; i < group.length; i++) {
      var word = group[i];

      if (i == 0) {
        buffer.write(word.toLowerCase());
      } else {
        buffer.write(_uppercaseFirst(word.toLowerCase()));
      }
    }

    return buffer.toString();
  }

  /// 'test string' -> 'TestString'
  static String pascalCase(String input) {
    final group = _getWordsGroup(input).map(_uppercaseFirst);

    return group.join();
  }

  /// 'test string' -> 'test_string'
  static String snakeCase(String input) {
    return lowerCase(input, separator: "_");
  }

  /// 'test string' -> 'test-string'
  static String kebabCase(String input) {
    return lowerCase(input, separator: "-");
  }

  /// 'test string' -> 'test.string'
  static String dotCase(String input) {
    return lowerCase(input, separator: ".");
  }

  /// 'test string' -> 'TEST_STRING'
  static String constantCase(String input) {
    return upperCase(input, separator: "_");
  }

  /// 'test string' -> 'Test String'
  static String titleCase(String input, {String separator = " "}) {
    final group = _getWordsGroup(input).map(_uppercaseFirst);

    return group.join(separator);
  }

  static String lowerCase(String input, {String separator = " "}) {
    final group = _getWordsGroup(input);

    return group.join(separator);
  }

  static String upperCase(String input, {String separator = " "}) {
    final group = _getWordsGroup(input).map((x) => x.toUpperCase());

    return group.join(separator);
  }

  static String _uppercaseFirst(String word) {
    return word.replaceRange(0, 1, word[0].toUpperCase());
  }

  static List<String> _getWordsGroup(String input) {
    final buffer = StringBuffer();
    List<String> group = [];

    for (int i = 0; i < input.length; i++) {
      String currentChar = input[i];
      String? nextChar = i == input.length - 1 ? null : input[i + 1];

      if (_symbols.hasMatch(currentChar)) continue;

      bool isDigit = _digitRegExp.hasMatch(currentChar);
      bool isNextDigit = _digitRegExp.hasMatch(nextChar ?? "");
      bool isLetter = _letterRegExp.hasMatch(currentChar);
      bool isNextLetter = _letterRegExp.hasMatch(nextChar ?? "");

      if ((isDigit && isNextLetter) || (isLetter && isNextDigit)) {
        buffer.write(currentChar);
        group.add(buffer.toString());
        buffer.clear();
        continue;
      }

      bool isUppercase = currentChar.toUpperCase() == currentChar;
      bool isNextUppercase = nextChar?.toUpperCase() == nextChar;

      if (isUppercase && buffer.isNotEmpty && !isNextUppercase && !isDigit) {
        group.add(buffer.toString());
        buffer.clear();
      }

      buffer.write(currentChar);

      if (_isEndOfWord(nextChar)) {
        group.add(buffer.toString());
        buffer.clear();
      }
    }

    // Split CamelCase and PascalCase strings
    group = group.expand((word) {
      if (_camelPascalCase.hasMatch(word)) {
        return word.split(_camelPascalCase);
      }
      return [word];
    }).toList();

    return group.map((e) => e.toLowerCase()).toList();
  }

  static bool _isEndOfWord(String? nextChar) {
    return nextChar == null || _symbols.hasMatch(nextChar);
  }
}
