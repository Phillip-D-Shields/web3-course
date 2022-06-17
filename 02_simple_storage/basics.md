## function visiblity specifiers

- > public - visible externally and internally, auto creates getter function
- > private - only visible in the current contract
- > external - only visbile externally, can only be message called
- > internal - only visible internally

- > view - read state from contract, only views data
- > pure - cant read  state, operates without any state or data

## access and store var data (6 places)

1. stack - not for var
2. memory - temp var that CAN be modified
3. storage - perm var than CAN be modified
4. calldata - temp var that CANT be modified
5. code - not for var
6. logs - not for var