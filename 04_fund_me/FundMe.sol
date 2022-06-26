// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PriceConverter.sol";

// upgrade = use const and immutable to save gas

error NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MIN_USD = 50 * 1e18;
    // array of addresses of users that fund this contract
    address[] public funders;

    // mapping of funders and their fund amount
    mapping(address => uint256) public addressToFundingAmount;

    address public immutable i_owner;

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        //set min fund amount in USD
        // require(msg.value >= 1e18, "did not send enough"); // 1e18 = 1 * 10 ** 18 == 1000000000000000000
        // require(getConversionRate(msg.value) >= minUSD, "did not send enough gas");
        // using library
        require(msg.value.getConversionPrice() >= MIN_USD, "not enough gas");
        funders.push(msg.sender);
    }

    function withdraw() public onlyOwner {
        // for loop
        // for(startIndex, endIndex, stepAmount)
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToFundingAmount[funder] = 0;
        }
        // reset array
        funders = new address[](0);

        // transfer - returns error if tsx fails
        // msg.sender = type address , payable(msg.sender = type payable
        // payable(msg.sender.transfer(address(this).balance));

        // send - no error if tsx fails, only bool
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "send failed");

        // call - recommended way 
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "call failed");
    }

    modifier onlyOwner {
        // require(msg.sender == owner, "must be the contract owner to do this");
        if(msg.sender != i_owner) {
            revert NotOwner();
        }
        _;
    }

    // what happens if someone sends eth without using the fund() function
    // receive()
    receive() external payable {
        fund();
    }
    // fallback()
    fallback() external payable {
        fund();
    }
}