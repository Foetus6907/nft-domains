// noinspection JSUnresolvedVariable,JSUnresolvedFunction
const main = async () => {
  // eslint-disable-next-line no-undef
  const domainContractFactory = await hre.ethers.getContractFactory("Domains");
  const domainContract = await domainContractFactory.deploy();
  await domainContract.deployed();
  // eslint-disable-next-line no-console
  console.log("Contrat deployed to: ", domainContract.address);
};

const runMain = async () => {
  try {
    await main();
    // eslint-disable-next-line @typescript-eslint/ban-ts-comment
    // @ts-ignore
    process.exit(0);
  } catch (error) {
    // eslint-disable-next-line no-console
    console.error("Error runing main :", error);
    // eslint-disable-next-line @typescript-eslint/ban-ts-comment
    // @ts-ignore
    process.exit(1);
  }
};

runMain();