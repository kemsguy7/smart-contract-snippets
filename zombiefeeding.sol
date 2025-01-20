pragma solidity >=0.5.0 <0.6.0;

import "./zombiefactory.sol";

contract KittyInterface {
    function getKitty(address _myAddress) public view retuns (uint);
}

contract ZombieFeeding is ZombieFactory {

  function feedAndMultiply(uint _zombieId, uint _targetDna) public {
    //verify that msg.sender is equal to this zombie's owner
    require(msg.sender == zombieToOwner[_zombieId]);
    Zombie storage myZombie = zombies[_zombieId];
    //make sure the target dna isn't longer than 16 digits
    _targetDna = _targetDna % dnaModulus;
    // set the average to a new uint variable
    uint newDna = (myZombie.dna + _targetDna) / 2;
    //call the _create
    _createZombie("NoName", newDna)
  }

}
