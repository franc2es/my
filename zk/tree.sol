// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

contract MerkleTreeExample is Ownable {
    bytes32 public merkleRoot;
    address public latestUser;

    bytes32[] public leaves;
    bytes32[] public nodes;

    constructor(address[] memory addresses, address _initialUser) Ownable(msg.sender) {
        for (uint256 i = 0; i < addresses.length; i++) {
            leaves.push(keccak256(abi.encodePacked(addresses[i])));
        }

        // 将 _initialUser 加入叶子节点
        leaves.push(keccak256(abi.encodePacked(_initialUser)));
        latestUser = _initialUser;

        buildMerkleTree();
    }

    function updateMerkleRoot(bytes32 newRoot) external onlyOwner {
        merkleRoot = newRoot;
    }

    function updateLatestUser(bytes32[] calldata proof) external {
        bytes32 leaf = keccak256(abi.encodePacked(msg.sender));
        require(verifyProof(proof, leaf), "Invalid Merkle Proof");
        latestUser = msg.sender;
    }

    function buildMerkleTree() internal {
        nodes = leaves;
        while (nodes.length > 1) {
            uint256 n = nodes.length;
            uint256 newLength = (n + 1) / 2;
            bytes32[] memory newLevel = new bytes32[](newLength);

            for (uint256 i = 0; i < n; i += 2) {
                if (i + 1 < n) {
                    newLevel[i / 2] = keccak256(abi.encodePacked(nodes[i], nodes[i + 1]));
                } else {
                    newLevel[i / 2] = nodes[i];
                }
            }
            nodes = newLevel;
        }
        merkleRoot = nodes[0];
    }

    function verifyProof(bytes32[] memory proof, bytes32 leaf) public view returns (bool) {
        bytes32 computedHash = leaf;
        for (uint256 i = 0; i < proof.length; i++) {
            bytes32 proofElement = proof[i];
            if (computedHash < proofElement) {
                computedHash = keccak256(abi.encodePacked(computedHash, proofElement));
            } else {
                computedHash = keccak256(abi.encodePacked(proofElement, computedHash));
            }
        }
        return computedHash == merkleRoot;
    }

    function getLeaf(uint256 index) public view returns (bytes32) {
        require(index < leaves.length, "Index out of range");
        return leaves[index];
    }

    function getLeafCount() public view returns (uint256) {
        return leaves.length;
    }
} 
