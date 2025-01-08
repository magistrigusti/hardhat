import { loadFixture, ethers, expect, time, anyValue } from "./setup";
import type { Demo, Hacker } from "../typechain-types";

describe("Demo", function() {
  async function deploy() {
    const [ user1, user2 ] = await ethers.getSigners();
    
    const Factory = await ethers.getContractFactory("Demo");
    const demo: Demo = await Factory.deploy();

    const Factory2 = await ethers.getContractFactory("Hacker");
    const hacker: Hacker = await Factory2.deploy(
      demo.address,
      {value: 1000}
    );

    return { demo, hacker, user1, user2 }
  }

  it("hacks", async function() {
    const { demo, hacker user1, user2 } = await loadFixture(deploy);

    const txData = {
      to: demo.address,
      value: 1000
    };

    const hackTx = await hacker.run();
    await hackTx.wait();

    const tx1 = await user1.sendTransaction(txData);
    await tx1.wait();

    const tx2 = await user2.sendTransaction(txData);
    await tx2.wait();

    console.log(await ethers.provider.getBalance(user1.address));
    console.log(await ethers.provider.getBalance(user2.address));
    console.log(await ethers.provider.getBalance(hacker.address));
    console.log(await demo.bets(hacker.address));
    console.log(await demo.bets(user1.address));

    const txRefund = await demo.refund();
    await txRefund.wait(1);
    //await expect(txRefund).to.be.revertedWith("fail");

    console.log(await ethers.provider.getBalance(user1.address));
    console.log(await ethers.provider.getBalance(user2.address));
    console.log(await ethers.provider.getBalance(hacker.address));

  });

});