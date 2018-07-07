import 'dart:io';
import 'dart:convert';
import 'problem_object/src/array_read_swap.dart';

main() {
  final user_code = Directory.current.path + '/entry_point/user_code';
  final api = Directory.current.path + '/entry_point/api.json';
  final sandbox = Directory.current.path + '/sandboxes/lua/run.lua';

  print('lua ' + sandbox + ' ' + user_code + ' ' + api);

  Process.start('lua', [sandbox, user_code, api]).then((Process process) {
    print('opened process');
    var array = [5,4,3,2,1];
    void _return(data) {
      process.stdin.write(data.toString() + '/n');
      process.stdin.flush().then((dy) => print('flushed'));
    };

    process.stdout.transform(ASCII.decoder).listen((data) {
      final call = JSON.decode(data);

      print('the call is ${call['name']} ${call['params'].toString()}');
      print('the data is $data');

      if (call['name'] == 'length') {
        _return(array.length);
      }
      else if (call['name'] == 'read') {
        _return(array[call['params'][0]]);
      }
      else if (call['name'] == 'swap') {
        final tmp = array[call['params'][0]];
        array[call['params'][0]] = array[call['params'][1]];
        array[call['params'][1]] = tmp;
      }

      print('the array is ');
      print(array.toString());
    });
  });
}
