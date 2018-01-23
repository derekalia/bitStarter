import factory from '../ethereum/factory';
import React from 'react';

class CampaignIndex extends React.Component {
  static async getInitialProps() {
    let campaigns = await factory.methods.getDeployedCampaigns().call();
    return { campaigns };
  }

  async componentDidMount() {
    //do some stuff here
  }

  render() {
    return <div>campaigns {this.props.campaigns[0]}</div>;
  }
}

export default CampaignIndex;
