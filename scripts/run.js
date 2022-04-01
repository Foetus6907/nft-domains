// noinspection JSUnresolvedVariable,JSUnresolvedFunction
const main = async () => {
  // eslint-disable-next-line no-undef
  const [owner, randomPerson] = await hre.ethers.getSigners();
  // eslint-disable-next-line no-undef
  const domainContractFactory = await hre.ethers.getContractFactory("Domains");
  const domainContract = await domainContractFactory.deploy("kame");
  await domainContract.deployed();
  console.log("Contrat deployed to: ", domainContract.address);
  console.log("Contract deployed by: ", owner.address);

  // We're passing in a second variable - value. This is the moneyyyyyyyyyy
  // eslint-disable-next-line no-undef
  let tnx = await domainContract.register("goku", {value: hre.ethers.utils.parseEther("0.5")});
  await tnx.wait();

  const domainOwner = await domainContract.getAddress("goku");
  console.log(`Domain owner: ${domainOwner}`);

  const records = { name: "goku", link: "goku.com" };

  tnx = await domainContract
    .connect(owner)
    .setRecord("goku", JSON.stringify(records));
  await tnx.wait();

  const domainRecords = await domainContract.getRecord("goku");
  console.log(JSON.parse(domainRecords));

  // eslint-disable-next-line no-undef
  const balance = await hre.ethers.provider.getBalance(domainContract.address);
  // eslint-disable-next-line no-undef
  console.log("Contract balance:", hre.ethers.utils.formatEther(balance));
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
