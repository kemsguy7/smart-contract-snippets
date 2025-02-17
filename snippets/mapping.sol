// SPDX-License-Identifier: MIT
pragma solidity 0.8.28; 

contract Mapping {
    // Mapping from address to uint
    mapping(address => uint) public myMap;

    function get(address _addr) public view returns(uint) {
        return myMap[_addr];
    }

    function set(address _addr, uint i) public {
        // Update the value at this address 
        myMap[_addr] = i;
    }

    function remove(address _addr) public {
        delete myMap[_addr];
    }
}

contract NestedMapping{
    mapping(address => mapping(uint => bool)) public nested;
    //gettin values from a nested map

    function get(address _add1, uint _i) public view returns (bool) {

        return nested[_add1][_i];
    }


    function set (address _addr1,  uint _i, bool _bool) public {
        nested[_addr1][_i] = _bool;
    }    

    function remove (address _addr1, uint _i) public {
        delete nested[_addr1][_i];
    }
}

//solidity Bool Mapping 
contract Voting {
 mapping (bytes32 => uint8) public votesRecieved;
 mapping (bytes32 => bool) public candidateList; 


 function Voting(bytes32[] candidateNames) {
    for (uint i = 0; i < candidateNames.length; i++) {
        candidateList[candidateNames[i]] = true; 
      //  unchecked { i++; } 
    }
 }


 function totalVotesFor(bytes32 candidate) public view returns (uint8) {
    require(validCandidate(candidate));
    return votesRecieved[candidate];
 }

 function voteForCandidate(bytes32 candidate) public {
    require(validCandidate(candidate) == true );
    votesRecieved[candidate] += 1;
 }


 function validCandidate(bytes32 candidate) public returns (bool) {
    return candidateList[candidate];
 }


}




