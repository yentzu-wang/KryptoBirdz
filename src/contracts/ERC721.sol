// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "./ERC165.sol";
import "./interfaces/IERC721.sol";

contract ERC721 is ERC165, IERC721 {
    mapping(uint256 => address) private _tokenOwner;
    mapping(address => uint256) private _ownedTokensCount;
    mapping(uint256 => address) private _tokenApprovals;

    constructor() {
        _registerInterface(
            bytes4(
                keccak256("balanceOf(address)") ^
                    keccak256("ownerOf(uint256)") ^
                    keccak256("transferFrom(address,address,uint256)") ^
                    keccak256("approve(address,uint256))")
            )
        );
    }

    function balanceOf(address _owner) public view returns (uint256) {
        require(_owner != address(0), "Owner query for zero address");

        return _ownedTokensCount[_owner];
    }

    function ownerOf(uint256 _tokenId) public view returns (address) {
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

    function _transferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) internal {
        require(_to != address(0), "Transfer to the zero address");
        require(ownerOf(_tokenId) == _from, "Address does not own the token");

        _ownedTokensCount[_from] -= 1;
        _ownedTokensCount[_to] += 1;
        _tokenOwner[_tokenId] = _to;

        emit Transfer(_from, _to, _tokenId);
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) external payable {
        isApprovedOrOwner(msg.sender, _tokenId);

        _transferFrom(_from, _to, _tokenId);
    }

    function approve(address _to, uint256 tokenId) external payable {
        address owner = ownerOf(tokenId);

        require(_to != owner, "Approval to the same address");
        require(msg.sender == owner, "Not allow");

        _tokenApprovals[tokenId] = _to;

        emit Approval(owner, _to, tokenId);
    }

    function isApprovedOrOwner(address spender, uint256 tokenId)
        public
        view
        returns (bool)
    {
        require(_exists(tokenId), "ERC721: non-existent token");

        address owner = ownerOf(tokenId);
        return spender == owner || getApproved(tokenId) == spender;
    }

    function getApproved(uint256 tokenId) public view returns (address) {}
}
