// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract ERC721 {
    mapping(uint256 => address) private _tokenOwner;
    mapping(address => uint256) private _ownedTokensCount;
    mapping(uint256 => address) private _tokenApprovals;

    event Transfer(
        address indexed from,
        address indexed to,
        uint256 indexed tokenId
    );

    function balanceOf(address _owner) public view returns (uint256) {
        require(_owner != address(0), "Owner query for zero address");

        return _ownedTokensCount[_owner];
    }

    function ownerOf(uint256 _tokenId) external view returns (address) {
        address owner = _tokenOwner[_tokenId];
        require(owner != address(0), "Owner query for zero address");

        return owner;
    }

    function _exists(uint256 tokenId) internal view returns (bool) {
        address owner = _tokenOwner[tokenId];

        return owner != address(0);
    }

    function _mint(address to, uint256 tokenId) internal virtual {
        require(to != address(0), "ERC721: mint to the null address");
        require(!_exists(tokenId), "ERC721: token already minted");

        _tokenOwner[tokenId] = to;
        _ownedTokensCount[to]++;

        emit Transfer(address(0), to, tokenId);
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) external payable {}
}
