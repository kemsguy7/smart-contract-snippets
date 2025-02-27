// SPD-License-Identifier : MIT
pragma solidity ^0.8.3;

// Data Locations - Storage, memory and calldata

contract DataLocations {
  struct MyStruct {
    uint foo;
    string text;
  }

  mapping(address => MyStruct) public myStructs;

  function examples(uint[] memory y, string memory s) external returns (uint[] memory) {
    myStructs[msg.sender] = MyStruct({ foo: 123, text: 'bar' });

    MyStruct storage myStruct = myStructs[msg.sender];
    myStruct.text = s; // write data to the struct

    MyStruct memory readOnly = myStructs[msg.sender];
    readOnly.foo = 456;

    uint[] memory memArr = new uint[](3); //only fixed-sized arrays can be declared in memory
    memArr[0] = 234;
    return memArr;
  }
}
