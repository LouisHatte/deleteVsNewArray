// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {Test, console2} from "@forge-std/Test.sol";

import {DeployDelete} from "script/DeployDelete.s.sol";
import {Delete} from "src/Delete.sol";

contract TestDelete is Test {
    uint256 SLOT = 0;

    uint256 DELETE_EMPTY_ARRAY_COST = 985;
    uint256 NEW_ARRAY_EMPTY_ARRAY_COST = 1210;

    uint256 DELETE_ARRAY_COST = 1137;
    uint256 NEW_ARRAY_ARRAY_COST = 1362;

    Delete private s_deleteContract;

    modifier addOneElement() {
        uint8[] memory array = new uint8[](1);
        array[0] = 1;
        s_deleteContract.addNumbers(array);
        _;
    }

    modifier addTwoElements() {
        uint8[] memory array = new uint8[](2);
        array[0] = 1;
        array[1] = 2;
        s_deleteContract.addNumbers(array);
        _;
    }

    modifier addThreeElements() {
        uint8[] memory array = new uint8[](3);
        array[0] = 1;
        array[1] = 2;
        array[2] = 3;
        s_deleteContract.addNumbers(array);
        _;
    }

    function setUp() external {
        DeployDelete deployer = new DeployDelete();
        s_deleteContract = deployer.run();
    }

    function testAddNumbers() external addThreeElements {
        uint8[] memory numbers = s_deleteContract.getNumbers();
        uint256 length = s_deleteContract.getNumbersLength();
        assertEq(numbers[0], 1);
        assertEq(numbers[1], 2);
        assertEq(numbers[2], 3);
        assertEq(length, 3);
    }

    function testUseDeleteKeywordWithArrayLenghtZero() external {
        uint256 oldLength = s_deleteContract.getNumbersLength();

        uint256 startingGas = gasleft();
        s_deleteContract.useDeleteKeyword();
        uint256 endingGas = gasleft();

        uint256 gasUsed = startingGas - endingGas;
        checkValuesAndLength(oldLength);
        assertEq(gasUsed, DELETE_EMPTY_ARRAY_COST);
    }

    function testUseDeleteKeywordWithArrayLenghtOne() external addOneElement {
        uint256 oldLength = s_deleteContract.getNumbersLength();

        uint256 startingGas = gasleft();
        s_deleteContract.useDeleteKeyword();
        uint256 endingGas = gasleft();

        uint256 gasUsed = startingGas - endingGas;
        checkValuesAndLength(oldLength);
        assertEq(gasUsed, DELETE_ARRAY_COST);
    }

    function testUseDeleteKeywordWithArrayLenghtTwo() external addTwoElements {
        uint256 oldLength = s_deleteContract.getNumbersLength();

        uint256 startingGas = gasleft();
        s_deleteContract.useDeleteKeyword();
        uint256 endingGas = gasleft();

        uint256 gasUsed = startingGas - endingGas;
        checkValuesAndLength(oldLength);
        assertEq(gasUsed, DELETE_ARRAY_COST);
    }

    function testUseDeleteKeywordWithArrayLenghtThree()
        external
        addThreeElements
    {
        uint256 oldLength = s_deleteContract.getNumbersLength();

        uint256 startingGas = gasleft();
        s_deleteContract.useDeleteKeyword();
        uint256 endingGas = gasleft();

        uint256 gasUsed = startingGas - endingGas;
        checkValuesAndLength(oldLength);
        assertEq(gasUsed, DELETE_ARRAY_COST);
    }

    function testUseNewArrayWithArrayLenghtZero() external {
        uint256 oldLength = s_deleteContract.getNumbersLength();

        uint256 startingGas = gasleft();
        s_deleteContract.useNewArray();
        uint256 endingGas = gasleft();

        uint256 gasUsed = startingGas - endingGas;
        checkValuesAndLength(oldLength);
        assertEq(gasUsed, NEW_ARRAY_EMPTY_ARRAY_COST);
    }

    function testUseNewArrayWithArrayLenghtOne() external addOneElement {
        uint256 oldLength = s_deleteContract.getNumbersLength();

        uint256 startingGas = gasleft();
        s_deleteContract.useNewArray();
        uint256 endingGas = gasleft();

        uint256 gasUsed = startingGas - endingGas;
        checkValuesAndLength(oldLength);
        assertEq(gasUsed, NEW_ARRAY_ARRAY_COST);
    }

    function testUseNewArrayWithArrayLenghtTwo() external addTwoElements {
        uint256 oldLength = s_deleteContract.getNumbersLength();

        uint256 startingGas = gasleft();
        s_deleteContract.useNewArray();
        uint256 endingGas = gasleft();

        uint256 gasUsed = startingGas - endingGas;
        checkValuesAndLength(oldLength);
        assertEq(gasUsed, NEW_ARRAY_ARRAY_COST);
    }

    function testUseNewArrayWithArrayLenghtThree() external addThreeElements {
        uint256 oldLength = s_deleteContract.getNumbersLength();

        uint256 startingGas = gasleft();
        s_deleteContract.useNewArray();
        uint256 endingGas = gasleft();

        uint256 gasUsed = startingGas - endingGas;
        checkValuesAndLength(oldLength);
        assertEq(gasUsed, NEW_ARRAY_ARRAY_COST);
    }

    function checkValuesAndLength(uint256 oldLength) private view {
        bytes32 base = keccak256(abi.encode(SLOT));
        uint256 length = s_deleteContract.getNumbersLength();

        for (uint256 i = 0; i < oldLength; i++) {
            bytes32 element = vm.load(
                address(s_deleteContract),
                bytes32(uint256(base) + i)
            );
            assertEq(uint256(element), 0);
        }
        assertEq(length, 0);
    }
}
