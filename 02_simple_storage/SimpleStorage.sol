// SPDX-License-Identifier: MIT
pragma solidity 0.8.8; // declare compiler version to use

contract SimpleStorage {
    // bool, uint, int, address, bytes
    // bool hasFavoriteNumber = true;
    // uint256 favoriteNumber00 = 123;
    // int256 favoriteNumber01 = 123; // can be positive negative
    // string favoriteNumberInText = "five";
    // address myAddress = 0xc4A7fA8C3e6bC0d8aC9696320A19A9FF0c40e702;
    // bytes32 favoriteBytes = "cat"; // letters work as byte objects
    uint256 favoriteNumber; // init defaults to 0

    // mapping, creates hashtable
    mapping(string => uint256) public nameToFavoriteNumber;

    // struct, similiar to a custom type
    struct People {
        uint256 favoriteNumber;
        string name;
    }

    // array of People struct, public, named 'people'
    // array size can be defined People[3]
    People[] public people;

    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
        // retrieveFavNumber(); // view function called in other function will cost gas
    }

    // pure and view functions cost no gas
    function retrieveFavNumber() public view returns(uint256) {
        return favoriteNumber;
    }

    // need to define data location 'memory' for struct, arrays, and mappings
    // strings are secretly arrays
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        // People memory newPerson = People({favoriteNumber: _favoriteNumber, name: _name});
        // people.push(newPerson);
        // add entry people array
        people.push(People(_favoriteNumber, _name));
        // add entry to hashtable
        nameToFavoriteNumber[_name] = _favoriteNumber;
    
    }

}