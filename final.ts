import { ethers } from "ethers";
import MerkleTreeExampleABI from './MerkleTreeExample.json'; // ABI JSON 文件

// 合约地址和Provider设置
const CONTRACT_ADDRESS = "YOUR_CONTRACT_ADDRESS_HERE";
const provider = new ethers.JsonRpcProvider("https://YOUR_RPC_URL");
const signer = new ethers.Wallet("YOUR_PRIVATE_KEY", provider);
const contract = new ethers.Contract(CONTRACT_ADDRESS, MerkleTreeExampleABI.abi, signer);

// 用户调用：提交Merkle Proof，更新自己的latestUser
export async function updateLatestUser(proof: string[]) {
  try {
    const tx = await contract.updateLatestUser(proof);
    await tx.wait();
    console.log("Successfully updated latestUser.");
  } catch (err) {
    console.error("Error updating latestUser:", err);
  }
}

// 合约拥有者调用：更新Merkle Root（例如来自链下重新生成）
export async function updateMerkleRoot(newRoot: string) {
  try {
    const tx = await contract.updateMerkleRoot(newRoot);
    await tx.wait();
    console.log("Merkle root updated to:", newRoot);
  } catch (err) {
    console.error("Error updating Merkle Root:", err);
  }
}