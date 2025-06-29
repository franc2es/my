import { ethers } from "hardhat";

async function main() {
  // 获取部署者账号 Owner
  const [deployer] = await ethers.getSigners();
  
  // 合约地址（填入你实际的合约地址）
  const contractAddress = "0xYourContractAddressHere";

  // 获取已部署的合约
  const MerkleTreeExample = await ethers.getContractFactory("MerkleTreeExample");
  const merkleContract = MerkleTreeExample.attach(contractAddress);

  // 新的 Merkle Root
  const newMerkleRoot = ethers.utils.keccak256(ethers.utils.toUtf8Bytes("newRootData"));

  // 执行 setMerkleRoot() 函数（只有 Owner 可以执行）
  console.log("Calling setMerkleRoot() from", deployer.address);
  const tx = await merkleContract.setMerkleRoot(newMerkleRoot);

  // 等待交易被矿工打包
  console.log("Transaction sent:", tx.hash);
  await tx.wait();
  console.log("Merkle Root updated to:", newMerkleRoot);
}

// 调用 main 函数并处理错误
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
