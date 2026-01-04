void main() {
  String name = "arjiya";
  bool female = true;
  int age = 21;
  List<String> fruits = ["mango", "apple"];
  Map<String, dynamic> myData = {
    "name": name,
    "age": age,
    "female": female,
    "fruits": fruits,
  };
  fruits.addAll(["banana", "guava", "grapes"]);
  
  print(myData);
}
