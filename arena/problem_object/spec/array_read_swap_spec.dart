import "package:test/test.dart";
import "../src/array_read_swap.dart";

void main() {
  test("should be able to read at an index", () {
    var problem_object = new array_read_swap([1,2,3,4]);

    expect(problem_object.read(0), equals(1));
  });

  test("should be able to swap two indexes", () {
    var problem_object = new array_read_swap([1,2,3,4]);

    problem_object.swap(2,3);
    expect([1,2,4,3], equals(problem_object.array));
  });
}
