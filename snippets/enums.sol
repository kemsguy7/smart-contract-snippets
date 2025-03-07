// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Enum {
  //enum representing shippng status
  enum Status {
    Pending,
    Shipped,
    Accepted,
    Rejected,
    Cancelled
  }

  Status public status;

  function get() public view returns (Status) {
    return status;
  }

  // update status by passing uint into input
  function updateStatus(Status _status) public {
    status = _status;
  }

  //update status to cancelled
  function cancel() public {
    status = Status.Cancelled;
  }

  function reset() public {
    delete status;
  }
}
