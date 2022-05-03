// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "./ERC721Connector.sol";

contract KryptoBirdz is ERC721Connector {
    string[] public kryptoBirdz;

    constructor() ERC721Connector("KryptoBirdz", "KBIRDS") {}

    function mint(string calldata _kryptoBird) public {
        kryptoBirdz.push(_kryptoBird);
        uint256 _id = kryptoBirdz.length - 1;

        _mint(msg.sender, _id);
    }
}
