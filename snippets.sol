// multiple returns 

function multipleReturns() internal returns(uint a, uint b, uint c) {
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



//if a user overpad for an item, this function will refund the difference
 uint itemFee = 0.001 ether;
 msg.sender.transfer(msg.value - itemFee);


 /*******************  USING UNCHECKED FUNCTION  *******/
 // used to make loops more gas efficient

    // This is a simple example of a loop that could be made more efficient with unchecked
 uint256 length = array.length; 
    for(uint256 i = 0; i < length; i++) {
        doSomething(array[i]);
    }

unit256 length = array.length;
    for(uint256 i = 0; i < length;) {
        doSomething(array[1]);
        unchecked { i++; } 
    }