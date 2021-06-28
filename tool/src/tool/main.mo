import SHA224 "mo:sha224/SHA224";
import Nat8 "mo:base/Nat8";
import Char "mo:base/Char";
import Array "mo:base/Array";
import Blob "mo:base/Blob";
import Principal "mo:base/Principal";
import CRC32 "./crc32";

actor Tool {
    let symbols = [
        '0', '1', '2', '3', '4', '5', '6', '7',
        '8', '9', 'a', 'b', 'c', 'd', 'e', 'f',
    ];
    let base : Nat8 = 0x10;

    /// Account Identitier type.   
    type AccountIdentifier = {
        hash: [Nat8];
    };

    // Convert a byte to hex string.
    // E.g `255` to "ff"
    func nat8ToText(u8: Nat8) : Text {
        let c1 = symbols[Nat8.toNat((u8/base))];
        let c2 = symbols[Nat8.toNat((u8%base))];
        return Char.toText(c1) # Char.toText(c2);
    };

    // Convert bytes array to hex string.       
    // E.g `[255,255]` to "ffff"
    func encode(array : [Nat8]) : Text {
        Array.foldLeft<Nat8, Text>(array, "", func (accum, u8) {
            accum # nat8ToText(u8);
        });
    };

    // Return the account identifier of the Principal.
    func principalToAccount(p : Principal) : AccountIdentifier {
        let digest = SHA224.Digest();
        digest.write([10, 97, 99, 99, 111, 117, 110, 116, 45, 105, 100]:[Nat8]); // b"\x0Aaccount-id"
        let blob = Principal.toBlob(p);
        digest.write(Blob.toArray(blob));
        digest.write(Array.freeze<Nat8>(Array.init<Nat8>(32, 0 : Nat8))); // sub account
        let hash_bytes = digest.sum();

        return {hash=hash_bytes;}: AccountIdentifier;
    };

    // Return the Text of the account identifier.
    func accountToText(p : AccountIdentifier) : Text {
        let crc = CRC32.crc32(p.hash);
        let aid_bytes = Array.append<Nat8>(crc, p.hash);

        return encode(aid_bytes);
    };

    public query func principalToAccountText(p: Principal) : async Text {
        let a = principalToAccount(p);
        return accountToText(a);
    };
};