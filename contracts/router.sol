

contract router{
    struct Dispute{
        address token;
        uint64 identifier;
    }
    mapping(uint=>Dispute) public Disputes;
    uint256 totalDisputes;
    constructor(){
        Disputes[1]=Dispute(0xdCad3a6d3569DF655070DEd06cb7A1b2Ccd1D3AF,1);
        totalDisputes=1;
    }
    function addDispute(address token,uint64 id) public {
        Disputes[totalDisputes]=Dispute(token,id);        
    }
     function getDisputeParams(uint256 id) external view returns(address m,uint64 _id){
        return (Disputes[id].token,Disputes[id].identifier);
    }
}