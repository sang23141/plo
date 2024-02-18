import 'dart:developer';

void logToConsole(String message) {
    log(message);
  }

class LogUtilFunctions {
  static void repositoryFirebaseLog(String message, String functionName, String repositoryName) {
    logToConsole("$message in $functionName in $repositoryName");
  }
}