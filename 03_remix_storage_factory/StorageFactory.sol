// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; 

import './SimpleStorage.sol'; // compiler versions should not conflict

contract StorageFactory {

    // create an array of SimpleStorage contract addresses
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        // contract, variable name = new contract instance
        SimpleStorage simpleStorage = new SimpleStorage();
        // add new contract instance to array
        simpleStorageArray.push(simpleStorage);
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        // two necessary components to interact with a contract
        // address
        // ABI - ABI is included with contract imports
        // contract , var name = contract address from array
        // SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];
        // call store() method from contract var above
        // simpleStorage.store(_simpleStorageNumber);

        // a better way
        simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber);

    }

    // get function to retrieve favorite number from a contract in address array
    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256) {
        // create local instance using array index
        // SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];
        // call retrieveFavNumber() from local contract instance created above
        // return simpleStorage.retrieveFavNumber();
    
        // a better way
        return simpleStorageArray[_simpleStorageIndex].retrieveFavNumber();    
    }
}