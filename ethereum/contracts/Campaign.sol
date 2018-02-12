pragma solidity ^0.4.17;


contract CampaignFactory {
    address[] public deployedCampaigns;
    
    function createCampaigns(uint minimum) public {
        address newCampaign = new Campaign(minimum,msg.sender);
        deployedCampaigns.push(newCampaign);
    }
    
    function getDeployedCampaigns() public view returns (address[]){
        return deployedCampaigns;
    }
}

contract Campaign {
    struct Request {
        string description;
        uint value;
        address recipient;
        bool complete;
        uint approvalCount;
        mapping(address => bool) approvals;
    }
    
    //list of request that the manager has created
    Request[] public requests;
    
    //address of the person who is managing this campaign
    address public manager;
    
    //min donation req to be considered a contributor
    uint public minimumContribution;
    
    // list of addresses for every person who has donated money
    
    //object look of people who approvered
    mapping(address => bool) public approvers;
    
    //number of approvers
    uint public approversCount;
    
    
    modifier restricted(){
        require(msg.sender == manager); 
        _;
    }
    
    
    
    
    
    //constructor function that sets the miniumContribution and owner
    function Campaign(uint minimum, address creator) public {
        manager = creator;
        minimumContribution = minimum;
    }
    
    //called when someone wants to donate money to the campaign and become an approver
    function contribute() public payable {
        require(msg.value > minimumContribution);
        
        // approvers.push(msg.sender);
        
        approvers[msg.sender] = true;
        approversCount++;
    }
    
    //called by the manager to create a new 'spending request'
    function createRequest(string description, uint value, address recipient) public restricted {
        //create a new request
        Request memory newRequest = Request({
            description: description,
            value: value,
            recipient: recipient,
            complete: false,
            approvalCount:0
        });
        
        requests.push(newRequest);
    }
    
    function approveRequest(uint index) public {
        Request storage request = requests[index];
       
        require(approvers[msg.sender]);
        require(!request.approvals[msg.sender]);
        
        
        request.approvals[msg.sender] = true;
        request.approvalCount++;
    }
    
    function finializeRequest(uint index) public restricted {
        Request storage request = requests[index];
        
        require(request.approvalCount > (approversCount/2));
        require(!request.complete);
        
        request.recipient.transfer(request.value);
        request.complete = true;
        
    }
}








