// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract Delete {
    uint8[] private s_numbers;

    function addNumbers(uint8[] memory numbers) external {
        for (uint256 i = 0; i < numbers.length; i++) {
            s_numbers.push(numbers[i]);
        }
    }

    // +5055 gas used per element reset (excluding len(0))
    // len(0):  2557
    // len(1):  10412
    // len(2):  15467
    // len(3):  20522
    function useDeleteKeyword() external {
        delete s_numbers;
    }

    // + 5055 gas used per element reset (excluding len(0))
    // len(0):  2671
    // len(1):  10526
    // len(2):  15581
    // len(3):  20636
    function useNewArray() external {
        s_numbers = new uint8[](0);
    }

    function getNumbers() external view returns (uint8[] memory) {
        return s_numbers;
    }

    function getNumbersLength() external view returns (uint256) {
        return s_numbers.length;
    }
}
