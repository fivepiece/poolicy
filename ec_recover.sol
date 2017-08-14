pragma solidity ^0.4.5;

contract VerifySignature {

    // I think this is needed?
    address owner;

    function VerifySignature() {
        owner = msg.sender;
    }
    // ...public static void main string[] ARGH!!


//    How can I store a public key in a variable so I can pass it to this function?
//    function pub2addr(bytes pubkey) constant returns (unit address){
//        return (uint(keccak256(pubkey)) & 0x00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF);
//    }

    function exampleSig() returns (bytes32, bytes32, bytes32, address) {
        // bytes32 d = 0xeab5f6141b4c66877f178f8b87c804d380af6d5404edc249d2c388dbcc542977; // privkey
        bytes32 z = 0x58e2f335bbd6f2b0da93eae19342e7309654fbfeed9a214a1e5d835ac09cc226; // msg
        bytes32 r = 0x0b7effb7704f726bc64139753dc2d0a3929af2309dd2930ad7a722f5b214cf6e; // r
        bytes32 s = 0x73a461ce418e9e483f13a98c0cba5cddf07f647ea1d6ba2e88d494dfcd411c9c; // s
        address a = 0x0031031df1d95a84fc21e80922ccdf83971f3e755b; // expected address
        return (z, r, s, a);
    }

    // recid.. is this the only one applicable?
    function v() returns(uint8) {
        return (0x20 - 0x04);
    }

    function verify(address p, bytes32 hash, bytes32 r, bytes32 s) constant returns(bool) {
        // -----
        // Note: this only verifies that signer is correct.
        // You'll also need to verify that the hash of the data
        // is also correct.
        // https://ethereum.stackexchange.com/questions/710/how-can-i-verify-a-cryptographic-signature-that-was-produced-by-an-ethereum-addr
        // -----
        // hehehehe :)
        return ecrecover(hash, v(), r, s) == p;
    }

    function testVerify() returns(bool) {

        var (thash, tr, ts, ta) = exampleSig();
        return verify(ta, thash, tr, ts);
    }

    // again.. not sure, is this needed?
    function kill(){
        if (msg.sender == owner) suicide(msg.sender);
    }
    // avenge me...!
}
