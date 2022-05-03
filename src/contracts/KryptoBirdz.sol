// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "./ERC721Connector.sol";

contract KryptoBirdz is ERC721Connector {
    string[] public kryptoBirdz;
    mapping(string => bool) private _kryptoBirdzExists;

    constructor() ERC721Connector("KryptoBirdz", "KBIRDS") {}

    function mint(string calldata _kryptoBird) public {
        require(
            !_kryptoBirdzExists[_kryptoBird],
            "Error - KBIRD already exists"
        );

        kryptoBirdz.push(_kryptoBird);
        uint256 _id = kryptoBirdz.length - 1;

        _mint(msg.sender, _id);
        _kryptoBirdzExists[_kryptoBird] = true;
    }
}
