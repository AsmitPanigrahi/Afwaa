// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyContract {
    uint8[][] adjacencyList;
    int cred;
    mapping(uint => data[]) validators;
     struct Campaign {
        address owner;
        string title;
        string description;
        uint256 target;
        uint deadlin;
        uint256 amountCollected;
        string image;
        address[] donators;
        uint256[] donations;
    }
     mapping(uint256 => Campaign) public campaigns;
   
    uint256 public numberofCampaigns = 0;
    function createCampaign(
        address _owner,
        string memory _tittle,
        string memory _description,
        uint256 _target,
        uint256 _deadline,
        string memory _image
    ) public returns (uint256) {
        Campaign storage campaign1 = campaigns[numberofCampaigns];
        campaign1.owner = _owner;
        campaign1.amountCollected = 0;
        campaign1.deadlin = _deadline;
        campaign1.title = _tittle;
        campaign1.description = _description;
        campaign1.target = _target;
        campaign1.image = _image;
        numberofCampaigns++;
        return numberofCampaigns - 1;
    }
  function getCampaigns() public view returns (Campaign[] memory) {
        Campaign[] memory allCampaigns = new Campaign[](numberofCampaigns);
        for (uint256 index = 0; index < numberofCampaigns; index++) {
            Campaign storage item = campaigns[index];
            allCampaigns[index] = item;
        }
        return allCampaigns;
    }
    constructor() {
        adjacencyList.push(); // Create an empty sub-array for node 0
        //  adjacencyList[1] = [2, 4];
        // adjacencyList[2] = [1, 6, 3];
        adjacencyList.push([2, 4]); // Node 1
        adjacencyList.push([1, 6, 3]); // Node 2
        adjacencyList.push([2]); // Node 3
        adjacencyList.push([1]); // Node 4
        adjacencyList.push(); // Node 5 (empty)
        adjacencyList.push([2]); // Node 6

        
    }

    function createData(string memory name, uint8 id_l) external {
        data memory temp = data(name, 0, 0);
        validators[id_l].push(temp);
    }

    function bfs(uint8 startNode) external {
        bool[7] memory visited;
        uint8[] memory queue = new uint8[](7);
        uint8 front = 0;
        uint8 rear = 0;
        int8 level = 0;

        visited[startNode] = true;
        queue[rear++] = uint8(startNode);

        while (front < rear) {
            uint8 currentNode = queue[front++];
            validators[uint8(currentNode)][0].level = level;

            for (uint8 i = 0; i < adjacencyList[uint8(currentNode)].length; i++) {
                uint8 neighbor = adjacencyList[uint8(currentNode)][i];
                if (!visited[uint8(neighbor)]) {
                    visited[uint8(neighbor)] = true;
                    queue[rear++] = neighbor;
                }
            }
            level++;
        }
    }

    struct data {
        string name;
        int cred;
        int level;
    }
}