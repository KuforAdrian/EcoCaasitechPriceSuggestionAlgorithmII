import 'dart:io';

class Trash {
  int quantity;
  int category;
  int amount;

  // Quantity of trash and price for each category of trash
  static Map<int, int> trashMeasurement = {
    1: 50,
    2: 75,
    3: 100
  };

  Trash(this.quantity, this.category, this.amount); // Constructor

  // Check if client's amount is enough for the trash pickup
  bool checkAmount() {
    double actualPrice =
        ((trashMeasurement[category])! * this.quantity) * 0.75;
    return this.amount >= actualPrice;
  }

  // Suggest three alternative prices greater than or equal to 75% of the actual price
  List<int> suggestPrices() {
    double actualPrice =
        ((trashMeasurement[category])! * this.quantity) * 0.75;
    int suggested1 = (actualPrice * 1.1).ceil();
    int suggested2 = (actualPrice * 1.2).ceil();
    int suggested3 = (actualPrice * 1.3).ceil();
    return [suggested1, suggested2, suggested3];
  }
}

void main() {
  bool continueAdding = true;

  while (continueAdding) {
    print("Enter 1 for bucket");
    print("Enter 2 for trash bag");
    print("Enter 3 for wheelbarrow");

    print("Enter the item you want your trash to be measured in: ");
    int trashItem = int.parse(stdin.readLineSync()!);

    print(
        "Enter the quantity of the trash in terms of the item you just said: ");
    int trashQuantity = int.parse(stdin.readLineSync()!);

    int price = Trash.trashMeasurement[trashItem]! * trashQuantity;
    print("The price for your trash pickup is $price FCFA");

    print("How much do you want to pay for the trash?: ");
    int trashAmount = int.parse(stdin.readLineSync()!);

    Trash trash = Trash(trashQuantity, trashItem, trashAmount);

    if (trash.checkAmount()) {
      print("EcoCaasitech agent is on the way to pick up your trash");
    } else {
      print("You have to pay more");

      // Suggest alternative prices
      List<int> suggestedPrices = trash.suggestPrices();
      print("We suggest the following prices: $suggestedPrices FCFA");

      // Ask if the user is willing to pick a price from the list
      print("Are you willing to pick a price from the list? (yes/no): ");
      String pickPriceInput = stdin.readLineSync()!.toLowerCase();
      
      if (pickPriceInput == "yes") {
        print("Choose one of the suggested prices: ");
        int chosenPrice = int.parse(stdin.readLineSync()!);

        // Check if the chosen price is greater than or equal to 75% of the actual price
        if (chosenPrice >= (price * 0.75).ceil()) {
          print("EcoCaasitech agent is on the way to pick up your trash");
        } else {
          print("You didn't choose a valid price. Program ends.");
          break;
        }
      } else {
        print("Program ends.");
        break;
      }
    }

    print("Do you want to add more trash items? (yes/no): ");
    String continueInput = stdin.readLineSync()!.toLowerCase();
    continueAdding = continueInput == "yes";
  }
}
