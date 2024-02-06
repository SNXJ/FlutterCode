import 'package:logger/logger.dart';
import 'package:wd_store/utils/env_config.dart';

///lib/utils/log_util.dart
///日志输出工具类
class LogUtils {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
        methodCount: 2, // 显示的方法调用数量
        errorMethodCount: 8, // 如果提供了堆栈跟踪，则显示的方法调用数量
        lineLength: 120, // 输出的宽度
        colors: true, // 彩色日志消息
        printEmojis: true, // 每个日志消息打印一个表情符号
        printTime: true // 每个日志打印是否包含时间戳
    ),
    filter: DevelopmentFilter(), // 使用默认的LogFilter（-> 只在调试模式下记录日志）
    output: ConsoleOutput(), // 使用默认的LogOutput（-> 将所有内容发送到控制台）
    level: Level.verbose, // 使用默认的LogLevel（-> 只记录严重性>=详细的日志消息）
  );

  static bool _debugMode = !EnvConfig().inProd;

  static void init({
    bool isDebug = false,
  }) {
    _debugMode = isDebug;
  }

  static void e(Object object) {
    _logger.e(object);
  }

  static void d(Object object) {
    if (_debugMode) {
      _logger.d(object);
    }
  }

  static void i(Object object) {
    if (_debugMode) {
      _logger.i(object);
    }
  }

  static void w(Object object) {
    _logger.w(object);
  }
}
