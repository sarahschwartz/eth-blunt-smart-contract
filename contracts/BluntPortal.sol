// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract BluntPortal {
    uint256 totalHits;
    uint256 private seed;

    event NewHit(address indexed from, uint256 timestamp, string message);

    struct Hit {
        address smoker; // The address of the user who hit the ETH blunt.
        string message; // The message the user sent.
        uint256 timestamp; // The timestamp when the user waved.
    }

    Hit[] hits;

    mapping(address => uint256) public lastHit;

    constructor() payable {
        console.log("smells like weed...");
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function smokeTheBlunt(string memory _message) public {
         require(
            lastHit[msg.sender] + 15 minutes < block.timestamp,
            "Wait 15m"
        );
        lastHit[msg.sender] = block.timestamp;
        totalHits += 1;
        console.log("%s hit the ETH blunt!", msg.sender);

        hits.push(Hit(msg.sender, _message, block.timestamp));

        seed = (block.difficulty + block.timestamp + seed) % 100;

        /*
         * Give a 42.0% chance that the user wins the prize.
         */
        if (seed <= 42) {
            console.log("%s won!", msg.sender);
            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }

        emit NewHit(msg.sender, block.timestamp, _message);
 }

    function getAllHits() public view returns (Hit[] memory) {
        return hits;
    }


    function getTotalHits() public view returns (uint256) {
        console.log("Total Hits: ", totalHits);
        return totalHits;
    }
}