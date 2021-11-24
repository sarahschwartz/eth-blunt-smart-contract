const main = async () => {
  const bluntContractFactory = await hre.ethers.getContractFactory('BluntPortal');
  const bluntContract = await bluntContractFactory.deploy({
    value: hre.ethers.utils.parseEther('0.001'),
  });

  await bluntContract.deployed();

  console.log('BluntPortal address: ', bluntContract.address);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
};

runMain();