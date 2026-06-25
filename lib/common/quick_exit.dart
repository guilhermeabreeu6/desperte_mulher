export 'quick_exit_stub.dart'
    if (dart.library.html) 'quick_exit_web.dart'
    if (dart.library.io) 'quick_exit_io.dart';
