//SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract snippets{


function multipleReturns()  internal returns(uint a, uint b, uint c) {
    return (1, 2, 3);
}

function processMultipleReturns() external {
    uint a;
    uint b;
    uint c;
    // This is how you do multiple assignement:
    (a, b, c) = multipleReturns();
}

// Or if we only cared about one of the values: 
function getLastReturnValue() external {
    uint c;
    // We can just leave the othe fields black:
    (,,c) = multipleReturns();
}


//if a user overpaid for an item, this function will refund the difference
function refundOverpayment() external {
    uint itemFee = 0.001 ether;
    payable(msg.sender).transfer(msg.value - itemFee);
}

 /*******************  USING UNCHECKED FUNCTION  *******/
 // used to make loops more gas efficient - Loop Optimization

    uint256[] array;

    function optimizedLoop() external {
        uint256 length = array.length; 
        for(uint256 i = 0; i < length; i++) {
            doSomething(array[i]);
        }

        length = array.length;
        for(uint256 i = 0; i < length;) {
            doSomething(array[i]);
            unchecked { i++; } 
        }
    }

    function doSomething(uint256 value) internal {
        // Implementation of doSomething
    }
}

contract Nestmap {

    //nestped mapping
    mapping(uint256=>mapping(string=>uint256)) public User;
    function adduser(uint256 _id, string memory _name, uint256 _age) public {
        User[_id][_name] = _age;
    }

    //function to get information of the user
    function getUser (uint256 _id, string memory _name ) public view returns (uint256) {
        return User[_id][_name];
    }

}



