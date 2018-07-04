import 'dart:io';
import 'dart:convert';


main() {
    stdin.transform(ASCII.decoder).listen((value) {
    Map request = JSON.decode(value);

    if (request["problemNumber"] == 1) {
      Process.start('cat', []).then((Process process) {
        process.stdout
            .transform(UTF8.decoder)
            .listen((data) { print(data); });
      });
    };
  });
}
