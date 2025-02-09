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

