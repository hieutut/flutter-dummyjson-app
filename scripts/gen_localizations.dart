// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, non_constant_identifier_names, unused_element

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';

void main(List<String> arguments) async {
  late _LocalizationGeneratorConfig config;
  try {
    final File configFile = File(arguments[0]);
    final String configContent = await configFile.readAsString();
    config = _LocalizationGeneratorConfig.fromJson(jsonDecode(configContent));
  } catch (e) {
    print('🔥 Error when reading config file: $e');
    print('=> Using default config');
    config = _LocalizationGeneratorConfig();
  }

  print('***[${config.outputClassName}] STARTED ***');

  print('- Config: ${_StringUtil.prettyJsonStr(config.toJson())}');

  final generator = _LocalizationGenerator(config);
  await generator.generate();

  print(
    '***[${config.outputClassName}] GENERATED ${generator.keyCount} keys for ${generator.languageCount} languages ***',
  );
}

class _LocalizationGenerator {
  final _LocalizationGeneratorConfig config;

  late final Directory _projectDir;
  late final String _inputFilePath;

  _LocalizationGenerator(this.config) {
    _projectDir = Directory.current;
    _inputFilePath = join(_projectDir.path, config.inputFile);
    print('- Input file path: $_inputFilePath');
  }

  static const String _LIB_FOLDER = 'lib';
  static const String _GENERATED_FILE_EXTENSION = '.gen.dart';

  int get keyCount => _keyCount;
  int _keyCount = 0;

  int get languageCount => _languageCount;
  int _languageCount = 0;

  Future<void> generate() async {
    _keyCount = 0;
    _languageCount = 0;

    final String content = await _genLocalizationFromFile(File(_inputFilePath));

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
    await outputFile.writeAsString(
      _OutputFileTemplate.fileContent(
        className: config.outputClassName,
        classContent: content,
        keyCount: keyCount,
        languageCount: languageCount,
      ),
    );
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

  Future<String> _genLocalizationFromFile(File file) async {
    final StringBuffer content = StringBuffer();
    // String content = '';

    final String inputFileContentRaw = await file.readAsString();
    final List<String> lines = const LineSplitter().convert(inputFileContentRaw);

    final List<String> listLang = lines.first.split(',').skip(1).toList();
    _languageCount = listLang.length;
    content
      ..writeln(_OutputFileTemplate.languageDefaultDeclaration(listLang.first))
      ..writeln(_OutputFileTemplate.languageDeclaration(listLang));
//     content += '''${_OutputFileTemplate.languageDefaultDeclaration(listLang.first)}
// ${_OutputFileTemplate.languageDeclaration(listLang)}''';
    // content += _OutputFileTemplate.languageDefaultDeclaration(listLang.first);
    // content += _OutputFileTemplate.languageDeclaration(listLang);

    for (int i = 1; i < lines.length; i++) {
      final String line = lines[i];
      final List<String> columns = line.split(',');
      final String key = columns.first;
      if (key.isEmpty) continue;
      content.writeln(_OutputFileTemplate.keyDeclaration(key));
      _keyCount++;
    }

    return content.toString();
  }
}

class _OutputFileTemplate {
  static final String _NEW_LINE = Platform.lineTerminator;

  static String fileContent({
    required String className,
    required String classContent,
    required int keyCount,
    required int languageCount,
  }) {
    return '''
// ignore_for_file: constant_identifier_names

// GENERATED CODE - DO NOT MODIFY BY HAND

class $className {
  const $className._();

  static const int KEY_COUNT = $keyCount;

  static const int LANGUAGE_COUNT = $languageCount;

$classContent}
''';
  }

  static String keyDeclaration(String name) {
    return "  static const String ${_Casing.snakeCase(name)} = '$name';$_NEW_LINE";
  }

  static String languageDefaultDeclaration(String lang) {
    return "  static const String LANGUAGE_DEFAULT = '$lang';$_NEW_LINE";
  }

  static String languageDeclaration(List<String> languages) {
    final StringBuffer buffer = StringBuffer()..writeln('  static const List<String> LANGUAGES = [');
    for (final lang in languages) {
      buffer.writeln("    '$lang',");
    }
    buffer.writeln('  ];');
    return buffer.toString();
  }
}

class _LocalizationGeneratorConfig {
  static const String _DEFAULT_INPUT_FILE = 'assets/localizations/localization.csv';
  static const String _DEFAULT_OUTPUT_CLASS_NAME = 'AppLocalization';
  static const String? _DEFAULT_OUTPUT_FILE_NAME = null;
  static const String _DEFAULT_OUTPUT_FOLDER = 'common/localization';

  _LocalizationGeneratorConfig({
    String? inputFile,
    String? outputClassName,
    String? outputFileName,
    String? outputFolder,
  })  : inputFile = _StringUtil.trimSlash(inputFile ?? _DEFAULT_INPUT_FILE),
        outputClassName = _Casing.pascalCase(outputClassName ?? _DEFAULT_OUTPUT_CLASS_NAME),
        outputFileName = outputFileName ?? _DEFAULT_OUTPUT_FILE_NAME,
        outputFolder = _StringUtil.trimSlash(outputFolder ?? _DEFAULT_OUTPUT_FOLDER);

  final String inputFile;
  final String outputClassName;
  final String? outputFileName;
  final String outputFolder;

  factory _LocalizationGeneratorConfig.fromJson(Map<String, dynamic> json) {
    return _LocalizationGeneratorConfig(
      inputFile: json['input_file'] as String?,
      outputClassName: json['output_class_name'] as String?,
      outputFileName: json['output_file_name'] as String?,
      outputFolder: json['output_folder'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'input_file': inputFile,
      'output_class_name': outputClassName,
      'output_file_name': outputFileName,
      'output_folder': outputFolder,
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
