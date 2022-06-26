// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {


        function getPrice() internal view returns(uint256) {
        // need ABI and address of chainlink data feed
        // ABI
        // address : 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        (,int256 price,,,) = priceFeed.latestRoundData();
        // ETH in terms of USD
        // 1000.00000000
        return uint256(price * 10000000000); // 1**10 == 1000000000
    }

    function getVersion() internal view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return priceFeed.version();
    }

    function getConversionPrice(uint256 ethAmount) internal view returns(uint256) {
        uint256 ethPrice = getPrice();
        // 3000_00000000000000000 = ETH / USD price
        // 1_000000000000000000 ETH
        uint256 ethAmountInUSD = (ethPrice * ethAmount) / 1000000000000000000;
        return ethAmountInUSD;
    }
}