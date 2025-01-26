pragma solidity >=0.5.0 <0.6.0;

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {

  modifier aboveLevel(uint _level, uint _zombieId) {
    require(zombies[_zombieId].level >= _level);
    _;
  }

  function changeName(uint _zombieId, string calldata _newName) external aboveLevel(2, _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    zombies[_zombieId].name = _newName;
  }

  function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    zombies[_zombieId].dna = _newDna;
  }

  function getZombiesByOwner(address _owner) external view returns(uint[] memory) {
    uint[] memory result = new uint[](ownerZombieCount[_owner]);
    
    // Declare a uint called counter and set it equal to 0.
    uint counter = 0;
    
    // Declare a for loop that starts from uint i=0 and goes up through i < zombies.length.
    for (uint i = 0; i < zombies.length; i++) {
        
        // Make an if statement that checks if zombieToOwner[i] is equal to _owner.
        // This will compare the two addresses to see if there is a match.
        if (zombieToOwner[i] == _owner) {
            result[counter] = i; 
            counter++;
        }
    }
    
    // The function should now return all the zombies owned by _owner without spending any gas.
    return result;
  }

}
