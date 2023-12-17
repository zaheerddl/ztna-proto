// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


contract SimpleContract {
    // Storage variables
    address public admin;
    mapping(address => bool) public whitelisted; // Public for easier access

    // Modifiers
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function.");
        _;
    }
    modifier onlyWhitelisted() {
        require(whitelisted[msg.sender], "Only whitelisted users can call this function.");
        _;
    }
    
    event UserAddedToWhitelist(address indexed user);
    event UserRemovedFromWhitelist(address indexed user);
    event AdminChanged(address indexed oldAdmin, address indexed newAdmin);


    // Functions
    function addToWhitelist(address _user) public onlyAdmin {
        whitelisted[_user] = true;
        emit UserAddedToWhitelist(_user);
    }

    function removeFromWhitelist(address _user) public onlyAdmin {
        delete whitelisted[_user]; // Consider gas cost in large whitelists
        emit UserRemovedFromWhitelist(_user);
    }

    function grantAdminRole(address _user) public onlyAdmin {
        address oldAdmin = admin;
        admin = _user; // Note: Single admin model
        emit AdminChanged(oldAdmin, _user);
    }

    function doSomething1() public onlyAdmin {
        // Admin-specific functionality (modify storage variables if needed)
    }

    function doSomething2() public onlyWhitelisted {
        // Whitelisted user functionality (modify storage variables if needed)
    }

    // Additional suggested optimizations:
    // - Use separate events to log whitelist/admin changes (optional)
    // - Implement upgradeable logic (advanced feature)
}

