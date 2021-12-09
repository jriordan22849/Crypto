pragma solidity ^0.4.0;
pragma experimental ABIEncoderV2;

contract Voter {

    struct OptionPos {
        uint pos;
        bool exists;
    }

    uint[] public votes;
    string[] public options;
    mapping (address => bool) votedByAddress;
    mapping (string => OptionPos) optionByPosition;

    constructor(string[] _options) public {
        options = _options;
        votes.length = options.length;

        for (uint i = 0; i < options.length; i ++ ) {
            OptionPos memory optionPos = OptionPos(i, true);
            string optionName = options[i];
            optionByPosition[optionName] = optionPos;
        }
    }

    function vote(string optionName) public {
        require(!votedByAddress[msg.sender], "Account has already voted"); 
        OptionPos memory optionPos = optionByPosition[optionName];
        require(optionPos.exists, "Invalid option name");

        votes[optionPos.pos] = votes[optionPos.pos] + 1;
        votedByAddress[msg.sender] = true;
    }

    function getOption() public view returns(string[]) {
        return options;
    }

    function getVotes() public view returns(uint[]) {
        return votes;
    }
}
