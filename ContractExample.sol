//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// Ether payments
// Modifiers
// Visibility
// Events
// Enums


contract HotelRoom {

    enum Statuses { 
        Vacant, 
        Occupied
    }
    Statuses public currentStatus;

    event Occupy(address _occupant, uint _value);

    address public owner;

    constructor(){
        owner = payable (msg.sender);
        currentStatus = Statuses.Vacant;
    }

    modifier OnlyWhileVacant {
        require(currentStatus == Statuses.Vacant, "Currently occupied");
        _;
    }

    modifier costs(uint _amount){
        require(msg.value >= _amount, "Not enough ether provided");
        _;
    }
    

    function bookHotelRoom()public payable OnlyWhileVacant costs(2 ether){
        currentStatus = Statuses.Occupied;
        //owner.transfer(msg.value); OR:
        (bool sent, bytes memory data) = owner.call{value: msg.value}("");
        require(true);

        emit Occupy(msg.sender, msg.value);
    }

}