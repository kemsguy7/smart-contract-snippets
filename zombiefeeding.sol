pragma solidity >=0.5.0 <0.6.0;

import "./zombiefactory.sol";

contract KittyInterface {
   function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
);
}

contract ZombieFeeding is ZombieFactory {
 
  //change this to just a declaration
  KittyInterface kittyContract;

  function setKittyContractAddress(address _address) external onlyOwner {
    KittyInterface kittyContract = KittyInterface(_address);
  }

  // Initialize kittyContract here using `ckAddress` from above
  KittyInterface kittyContract = KittyInterface(ckAddress);

  function _triggerCooldown(Zombie storage _zombie) internal {
      _zombie.readyTime = uint32(now + cooldownTime);
  }


  //Tells us if enough time has passed since the last time a zombie fed. 
  function _isReady(Zombie storage _zombie) internal view returns (bool) {
      return (_zombie.readyTime <= now);
  }

  function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) public {
    //verify that msg.sender is equal to this zombie's owner
    require(msg.sender == zombieToOwner[_zombieId]);
    Zombie storage myZombie = zombies[_zombieId];
    //make sure the target dna isn't longer than 16 digits
    _targetDna = _targetDna % dnaModulus;
    // set the average to a new uint variable
    uint newDna = (myZombie.dna + _targetDna) / 2;
    if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) {
      newDna = newDna - newDna % 100 + 99;
    }
    //call the _create
    _createZombie("NoName", newDna);
  }

  function feedOnKitty(uint _zombieId, uint _kittyId) public {
      uint kittyDna;
      (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
      feedAndMultiply(_zombieId, kittyDna, "kitty");
  }

}
