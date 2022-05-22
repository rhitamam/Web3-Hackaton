pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Land is ERC721{

    uint public cost = 1 ether;
    uint public  max_supply = 5;
    uint public total_supply = 0;

    struct Building{
        string name;
        address owner;
        int256 posX;
        int256 posY;
        int256 posZ;
        uint256 sizeX;
        uint256 sizeY;
        uint256 sizeZ;


    }

    Building[] public buildings;

    constructor(string memory _name, string memory _symbol, uint  _cost) ERC721(_name,_symbol){
        cost = _cost;
        buildings.push(
            Building("City_hall", address(0x0), 0,0,0,10,10,10)
        );
        buildings.push(
            Building("Stad", address(0x0), 0,10,0,10,5,3)
        );
        buildings.push(
            Building("University", address(0x0), 0,-10,0,10,5,3)
        );
        buildings.push(
            Building("Shopping plaza 1", address(0x0), 10,0,0,5,25,3)
        );
        buildings.push(
            Building("Sopping plaza 2", address(0x0), -10,0,0,5,25,3)
        );





    }

    function  mint(uint256 _id) public payable {
        uint256 supply= total_supply;
        require(supply<= max_supply);
        require(buildings[_id -1].owner==address(0x0));
        require(msg.value>=1 ether);

        buildings[_id-1].owner = msg.sender;
        total_supply+=1;
        _safeMint(msg.sender, _id);

    }
    
    function transferFrom(
        address from,
        address to,
        uint256 tokenId)public override{

            require(_isApprovedOrOwner(_msgSender(), tokenId),
            "ERC721: not owner nor approved"
            );

            buildings[tokenId-1].owner = to;
            _transfer(from, to, tokenId);
        } // transorm land
    
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes memory data
    )public override{

            require(_isApprovedOrOwner(_msgSender(), tokenId),
            "ERC721: not owner nor approved"
            );
            // updates building ownership
            buildings[tokenId-1].owner = to;
            _safeTransfer(from, to, tokenId,data) ;
        } // transorm land

    function getBuildings()public view returns(Building[] memory) {
        return buildings;
    }

    function getBuilding(uint256 _id)public view returns(Building memory) {
        return buildings[_id-1]; 
    }

}


