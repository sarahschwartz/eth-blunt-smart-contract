const main = async () => {
  const bluntContractFactory = await hre.ethers.getContractFactory('BluntPortal');
  const bluntContract = await bluntContractFactory.deploy({
    value: hre.ethers.utils.parseEther('0.1'),
  });
  await bluntContract.deployed();
  console.log('Contract address:', bluntContract.address);

  let contractBalance = await hre.ethers.provider.getBalance(
    bluntContract.address
  );
  console.log(
    'Contract balance:',
    hre.ethers.utils.formatEther(contractBalance)
  );

  /*
   * Let's try two hits now
   */
  const hitTxn = await bluntContract.smokeTheBlunt('This is hit #1');
  await hitTxn.wait();

  const hitTxn2 = await bluntContract.smokeTheBlunt('This is hit #2');
  await hitTxn2.wait();

  contractBalance = await hre.ethers.provider.getBalance(bluntContract.address);
  console.log(
    'Contract balance:',
    hre.ethers.utils.formatEther(contractBalance)
  );

  let allHits = await bluntContract.getAllHits();
  console.log(allHits);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();