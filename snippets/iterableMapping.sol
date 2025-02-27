contract iterableMapping {
  mapping(address => uint) public balances;
  mapping(address => bool) public inserted;
  address[] public keys;

  function set(address _key, uint _val) external {
    balances[_key] = _val;

    if (!inserted[_key]) {
      inserted[_key] = true; //add to the inserted mappping bool (set the address to true)
      keys.push(_key);
    }
  }

  function getSize() external view returns (uint) {
    return keys.length;
  }

  //return first item of the array
  function first() external view returns (uint) {
    return balances[keys[0]];
  }

  function last() external view returns (uint) {
    return balances[keys[keys.length - 1]];
  }

  function get(uint _i) external view returns (uint) {
    return balances[keys[_i]];
  }
}
