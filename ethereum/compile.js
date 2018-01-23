const path = require('path');
const solc = require('solc');
const fs = require('fs-extra');

//delete entire 'build' folder
//Read Campaign.sol from the contracts folder
//Compile both contracts with solidity compiler
//Write output to the 'build' directory

const buildPath = path.resolve(__dirname, 'build');

//looks at a folder and it deletes it
fs.removeSync(buildPath);

const campaignPath = path.resolve(__dirname, 'contracts', 'Campaign.sol');
const source = fs.readFileSync(campaignPath, 'utf8');
const output = solc.compile(source, 1).contracts;

//check to see if that dir exsits if not create it
fs.ensureDirSync(buildPath);

for (let contract in output) {
  fs.outputJsonSync(path.resolve(buildPath, contract.replace(':', '') + '.json'), output[contract]);
}
