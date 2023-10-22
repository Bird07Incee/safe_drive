// ignore_for_file: depend_on_referenced_packages

library commons;

/// Constants
export './src/constants/constants.dart';

/// Library.
export './generated/l10n.dart';
export 'package:flutter_localizations/flutter_localizations.dart';
export 'package:get/get.dart';
export 'package:get_it/get_it.dart';
export 'package:intl/intl.dart';
export 'package:go_router/go_router.dart';

/// Resource

/// DI
export './src/di/commons_module.dart';
/// Extensions
export './src/extensions/string_extension.dart';
export './src/extensions/value_notifier_extension.dart';
/// Storage
export './src/storage/encrypt_storage.dart';
export './src/storage/storage_utils.dart';
/// Base UI
export './src/ui/base_stateful.dart';
export './src/ui/base_view_model.dart';
/// Utils
export './src/utils/routes.dart';









