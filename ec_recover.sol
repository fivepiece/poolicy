pragma solidity ^0.4.15;

// https://ethereum.stackexchange.com/questions/710/how-can-i-verify-a-cryptographic-signature-that-was-produced-by-an-ethereum-addr

library verifySig {

    // https://ethereum.stackexchange.com/questions/4170/how-to-convert-a-uint-to-bytes-in-solidity
    function toBytes(uint256 x) internal returns (bytes b) {
        b = new bytes(32);
        assembly { mstore(add(b, 32), x) }
    }

    function pub2addr(bytes pubkey) returns (bytes32){
        return (keccak256(pubkey) & 0x00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF);
    }

    function validate(bytes32 z, bytes p, bytes32 r, bytes32 s) returns (bool, address) {
        address recaddr;
        bytes32 pubhash = pub2addr(p);
        for (uint8 v = 0x1b; v < 0x1f; v++){
            recaddr = ecrecover(z, v, r, s);
            if (recaddr == address(pubhash)){
                return (true , recaddr);
            }
        }
        return (false, address(pubhash));
    }
}

contract verifyTest{

    function exampleSig() returns (bool, address) {
        // bytes32 d = 0xeab5f6141b4c66877f178f8b87c804d380af6d5404edc249d2c388dbcc542977; // privkey
        bytes32 z = 0x58e2f335bbd6f2b0da93eae19342e7309654fbfeed9a214a1e5d835ac09cc226; // msg
        bytes32 r = 0x0b7effb7704f726bc64139753dc2d0a3929af2309dd2930ad7a722f5b214cf6e; // r
        bytes32 s = 0x73a461ce418e9e483f13a98c0cba5cddf07f647ea1d6ba2e88d494dfcd411c9c; // s
        // address addr = 0x0031031df1d95a84fc21e80922ccdf83971f3e755b; // expected address
        bytes memory pub = hex"6421F6ECA2EF7A43CE0AF4A150B933AFB3CF0764323B8FF9EBFD4935FD86D4366EB03B61EDC46EC777306E352CB9ACC21DBAE5BDE543733A0DAA531A54BD40C3";
        return verifySig.validate(z, pub, r, s);
    }

    function mySig() returns (bool, address) {
        // bytes32 d = 0x19F9022974862EB4EE36ACEBBD325B9D7EF39C099C63885145D3FE4FA9ED272A; // privkey
        bytes32 z = 0xF7F83A18DFE29A4E5341C12F354E2B82A6210777B94E224B44FB89233BD58987; // msg
        bytes32 r = 0x0b7effb7704f726bc64139753dc2d0a3929af2309dd2930ad7a722f5b214cf6e; // r
        bytes32 s = 0x73a461ce418e9e483f13a98c0cba5cddf07f647ea1d6ba2e88d494dfcd411c9c; // s
        // address addr = 0x00e0d24f1e0b13cc68b1bce89bc0ecc1886cfe02f0; // expected address
        bytes memory pub = hex"9AD3BAB4B5DCD51D3E9AD0B773775EF5AAC64B0ABBC1B26230A574F41A1592016DC7BAB580A4CA42544C20F6117810BBA3E244CA89B77ED0291BC4EEB88AE541";
        return verifySig.validate(z, pub, r, s);
    }

    function smallSig() returns (bool, address) {

        bytes32 z = 0xF7F83A18DFE29A4E5341C12F354E2B82A6210777B94E224B44FB89233BD58987;
        bytes32 r = 0x0000000000000000000000000000000000000000000000000000000000000007;
        bytes32 s = 0x6A75737420736F6D652033322072616E646F6D20627974657320666F7220730A;
        // bytes memory pub = hex"A0DB96FE5D0AD5E6B104CA4819BB915F1E3B6796B2001655C15B5991DAA04405FDC58257525D089B3A5B1C6BA4006457117A2770945A78634CEB452BC40ACB7F";
        bytes memory pub = hex"3786B513739C7FB42AFA8892F30C6C01140499CAA26D7E56E36AE9F260780CB0FA010C6D8F1268F6BA6CBD18E25F90F22E6E8D9994455D34E99DF11682BA172F";
        return verifySig.validate(z, pub, r, s);
    }
}
