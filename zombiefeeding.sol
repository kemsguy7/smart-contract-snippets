pragma solidity >=0.5.0 <0.6.0;

import "./zombiefactory.sol";

contract ZombieFeeding is ZombieFactory {

  function feedAndMultiply(uint _zombieId, uint _targetDna) public {
      //verify that msg.sender is equal to this zombie's owner
      require(msg.sender == zombieToOwner[_zombieId]);
      //create a storage to store the Zombie's DNA
      Zombie storage myZombie  = zombies[_zombieId];
  }

}
