import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/functions/rounding.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/models/res_invitors.dart';

List<Resinvitors> calInvitorsBills(
    double totalPrice, List<Resinvitors> resInvitors) {
  double priceForEach = 0;
  int noOfPeopleWillPay = 1;

  for (int i = 0; i < resInvitors.length; i++) {
    if (resInvitors[i].type == 1) {
      noOfPeopleWillPay += 1;
    }
  }

  priceForEach = totalPrice / noOfPeopleWillPay;

  for (int i = 0; i < resInvitors.length; i++) {
    switch (resInvitors[i].type) {
      case 1:
        resInvitors[i].cost = roundTwoDecimal(priceForEach);
        break;
      case 2:
        resInvitors[i].cost = 0;
        break;
    }
  }

  return resInvitors;
}

// List<Resinvitors> calInvitorsBills(double totalCost,
//     List<Resinvitors> resInvitors, TextEditingController extraSeats) {
//   int totalPeopleNo = resInvitors.length + 1; // 1 is me.
//   if (extraSeats.text != '') {
//     totalPeopleNo += int.parse(extraSeats.text);
//   }
//   double personCost = totalCost / totalPeopleNo;
//   int numberOfNoCostPeople = 0;
//   int numberOfDividePeople = 0;
//   int numberOfNormalPeople = 0;
//   for (int i = 0; i < resInvitors.length; i++) {
//     switch (resInvitors[i].type) {
//       case 0:
//         numberOfNormalPeople++;
//         break;
//       case 1:
//         numberOfDividePeople++;
//         break;
//       case 2:
//         numberOfNoCostPeople++;
//         break;
//     }
//   }
//   numberOfDividePeople += 1; //1 is me.
//   if (extraSeats.text != '') {
//     numberOfNoCostPeople += int.parse(extraSeats.text);
//   }

//   double billOfNoCostPeople = personCost * numberOfNoCostPeople;
//   //======
//   double costOfNormalPeople = personCost;
//   double costOfnoCostPeople = 0;
//   double costOfDividePeople =
//       personCost + (billOfNoCostPeople / numberOfDividePeople);

//   for (int i = 0; i < resInvitors.length; i++) {
//     switch (resInvitors[i].type) {
//       case 0:
//         resInvitors[i].cost = roundTwoDecimal(costOfNormalPeople);
//         break;
//       case 1:
//         resInvitors[i].cost = roundTwoDecimal(costOfDividePeople);
//         break;
//       case 2:
//         resInvitors[i].cost = roundTwoDecimal(costOfnoCostPeople);
//         break;
//     }
//   }

//   return resInvitors;
// }

calcCreatorCost(double totalPrice, List<Resinvitors> resInvitors) {
  double priceForEach = 0;
  int noOfPeopleWillPay = 1;

  for (int i = 0; i < resInvitors.length; i++) {
    if (resInvitors[i].type == 1) {
      noOfPeopleWillPay += 1;
    }
  }

  priceForEach = totalPrice / noOfPeopleWillPay;

  return priceForEach;
}

// calcDividePersonCost(double totalCost, List<Resinvitors> resInvitors,
//     TextEditingController extraSeats) {
//   int totalPeopleNo = resInvitors.length + 1; // 1 is me.
//   if (extraSeats.text != '') {
//     totalPeopleNo += int.parse(extraSeats.text);
//   }
//   double personCost = totalCost / totalPeopleNo;
//   int numberOfNoCostPeople = 0;
//   int numberOfDividePeople = 0;
//   int numberOfNormalPeople = 0;
//   for (int i = 0; i < resInvitors.length; i++) {
//     switch (resInvitors[i].type) {
//       case 0:
//         numberOfNormalPeople++;
//         break;
//       case 1:
//         numberOfDividePeople++;
//         break;
//       case 2:
//         numberOfNoCostPeople++;
//         break;
//     }
//   }
//   numberOfDividePeople += 1; //1 is me.
//   if (extraSeats.text != '') {
//     numberOfNoCostPeople += int.parse(extraSeats.text);
//   }

//   double billOfNoCostPeople = personCost * numberOfNoCostPeople;
//   //======

//   double costOfDividePeople =
//       personCost + (billOfNoCostPeople / numberOfDividePeople);

//   return costOfDividePeople;
// }
