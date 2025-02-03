pragma solidity >=0.5.0 <0.6.0;

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {

  modifier aboveLevel(uint _level, uint _zombieId) {
    require(zombies[_zombieId].level >= _level);
    _;
  }

  
  /* incentives for people to level up their Zombies
  - For zombies level 2 and higher , users will be able to change their name
  - For zombies lever 20 and higher, users will be able to give them custom DNA
  */

  //  function changeName(uint _zombieId, string calldata _newName)  external aboveLevel(2, _zombieId){
  //    require(msg.sender == zombieToOwner[_zombieId]);
  //    zombies[_zombieId].name = _newName;
  //  }

  //  function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId)  {
  //     require(msg.sender == zombieToOwner[_zombieId]);
  //      zombies[_zombieId].dna = _newDna;
  //  } 

  function changeName(uint _zombieId, string calldata _newName) external aboveLevel(2, _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    zombies[_zombieId].name = _newName;
  }

  function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    zombies[_zombieId].dna = _newDna;
  }


 function getZombiesByOwner(address _owner) external view returns(uint[] memory) {
   
    uint[] memory result = new uint[](ownerZombieCount[_owner]); //Declaring an array witt memory to save gas 
    return result;
  }

  function getZombiesByOwner(address _owner) external view returns(uint[] memory) {
    uint[] memory result = new uint[](ownerZombieCount[_owner]);
  
    //variable to keep track of our result array 
    uint counter = 0;

    for (uint i = 0; i < zombies.length; i++) {
      if(zombieToOwner[i] == _owner) {
        result[counter] = i;
        counter++;
      }
    }

    return result; // function returns all zombies owned by _owner without spending any gas
  }


}
