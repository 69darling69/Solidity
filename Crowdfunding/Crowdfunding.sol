// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract Crowdfunding {

    address public producer;
    mapping(address => uint256) public investments;
    uint256 public goal;
    uint public deadline;

    constructor(address producer_, uint256 goal_, uint deadline_) {
        producer = producer_;
        goal = goal_;
        deadline = deadline_;
    }

    function totalInvestmentsPercents() public view  returns(uint256) {
        return address(this).balance * 100 / goal;
    }

    function invest() external payable {
        require (block.timestamp < deadline, "Deadline crossed");

        investments[msg.sender] += msg.value;
    }

    function getBenefits() external {
        require(msg.sender == producer, "Only producer can get benefits");
        require(address(this).balance >= goal, "Goal not yet reached");

        payable(producer).transfer(address(this).balance);
    }

    function returnInvestments() external {
        require(investments[msg.sender] > 0, "You do not have any investments");
        require(block.timestamp > deadline, "Deadline not yet crossed");
        require(address(this).balance < goal, "Goal reached");

        payable(msg.sender).transfer(investments[msg.sender]);
    }

}
