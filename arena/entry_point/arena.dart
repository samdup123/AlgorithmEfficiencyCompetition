import 'dart:io';
import 'dart:convert';

main() {
  final user_code = Directory.current.path + '/user_code';
  final api = Directory.current.path + '/api.json';
  final sandbox = Directory.current.path + '/sandboxes/lua/run.lua';

  Process.start('lua', [sandbox, user_code, api]).then((Process process) {
    print('opened process');
    process.stdout.pipe(stdout);
  });
}

// import 'dart:io';
// import 'dart:convert';
//
// main() {
//   final file = Directory.current.path + '/file.lua';
//
//   Process.start('lua', [file]).then((Process process) {
//     print('opened process');
//     process.stdout.pipe(stdout);
//   });
// }
