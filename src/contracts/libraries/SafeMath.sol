// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

library SafeMath {
    function add(uint256 x, uint256 y) internal pure returns (uint256) {
        uint256 r = x + y;
        require(r >= x, "SaveMath: Addition overflow");

        return r;
    }

    function sub(uint256 x, uint256 y) internal pure returns (uint256) {
        require(y <= x, "SafeMath: Subtraction overflow");

        uint256 r = x - y;

        return r;
    }
}
