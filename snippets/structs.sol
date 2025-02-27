// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Structs {
  struct Car {
    string model;
    uint year;
    address owner;
  }

  Car public car;
  Car[] public cars;
  mapping(address => Car[]) public carsByOwner; //owner can have multiple cars

  function examples() external {
    Car memory toyota = Car('Toyota', 1990, msg.sender); //first way of initializing struct
    //  Car memory lambo = Car({year: 1980, model: "Lamborghini", owner: msg.sender}) ;//second method : Key- Value Pairs ; Parameter orders can be switched in Key value pair
    Car memory tesla; // Third method using variables, then accessing it with dot notation

    tesla.model = 'Tesla2';
    tesla.year = 2010;
    tesla.owner = msg.sender;

    cars.push(toyota); // can addd in items using this format to
    cars.push(Car('Ferrari', 2020, msg.sender)); //instead on using memorey variables, cars can be instantiated and pushed at the same time using this

    // Car memory _car = cars[0]; //get the first car staored in the cars array

    //To update an item  , you need to change the memory ro stoarage

    Car storage _car = cars[0];
    _car.year = 1990;
    delete _car.owner;

    delete cars[1]; // remove second car from the array
  }
}
