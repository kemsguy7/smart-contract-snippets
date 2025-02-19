// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.26;

// Array - Dynamic or Fixed Size

// Initialization 
// Inser (push), get, update ,delete, pop, length
// Creating array in Memory
// Returning array from function 

contract FunctionOutputs   { 

    

    uint[] public nums = [1, 2, 3];

    function example() external pure  {
        // create an array in memory
        uint[] memory a = new uint[](5);
        a[1] = 123;
    }

    function returnArray() external view returns (uint[] memory) {
        return nums;
    }

} 


contract ArrayShift { 
    uint[] public arr;

    function example() public {
        arr = [1, 2, 3];
        delete arr[1]; // [1, 0, 3]

        function remove (uint _index) public {
            require(_index < arr.length, "index out of bounds");

            for(uint i = _index; i < arr.length - 1; i++) {
                arr[i] = arr[i + 1];
            }
            arr.pop();
        }

        function testRemove() external {
            arr = [1, 2, 3, 4, 5]
            remove(2)
            //[1, 2, 3, 4, 5]
            assert(arr[0] == 1)
            assert(arr[1] == 2)
            assert(arr[2] == 4)
            assert(arr[3] == 5)
            assert(arr.length == 4)

            arr = [1];
            remove (0);

            assert(arr.length == 0)
        }

    }

    //replace last
    function replace(uint index) public {
        //replace a particular index with the last element of the array
        arr[_index] = arr[arr.length - ];
        arr.pop();
    }

    function testRemove() external  {
        arr = [1, 2, 3, 4];

        remove(1); 

        // [1, 4, 3]
         assert(arr.length == 3)
         assert(arr[1] == 1);
         assert(arr[2] == 4);
         assert(arr[3] == 3);

         remove(2); 

         // [1 , 4]
         assert(arr.length == 2);
         assert(arr[0] == 1);
         assert(arr[1] == 4);
    }


}

