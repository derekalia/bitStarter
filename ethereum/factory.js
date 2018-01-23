import web3 from './web3';

import CampaignFactory from './build/CampaignFactory.json'

const instance = new web3.eth.Contract(
    JSON.parse(CampaignFactory.interface),
    '0x953b9cEd5A7F117624c06FCe7bD6fB614fb387a5'
);

export default instance;
