#-----------------------CONSTANT TIME-----------------------------------#
import hashlib

def encrypt_constant_time(license_number: str) -> str:
    # Hash input
    digest = hashlib.sha256(license_number.encode()).digest()
    # Take first 8 bytes for constant‑size output
    return digest[:8].hex()



def run_constantTime():
    plate_num = "ABC1234"
    encrypted_plate = encrypt_constant_time(plate_num)
    print("----CONSTANT TIME----")
    print("Encrypted:", encrypted_plate)
    print("---------------------\n")
#-----------------------END CONSTANT TIME-----------------------------------#

#-----------------------LOG TIME---------------------------------------#

def base36_to_int(s: str) -> int:
    return int(s, 36)

def encrypt_log_time(license_number: str) -> int:
    # Convert license to integer
    x = base36_to_int(license_number.upper())

    # Public exponent and modulus (toy example – for demo only)
    e = 65537
    mod = 2**64 - 59  # a large-ish prime-like modulus

    # pow(x, e, mod) uses fast exponentiation → O(log e)
    return pow(x, e, mod)

def run_logTime():
    plate_num = "ABC1234"
    encrypted_plate = encrypt_log_time(plate_num)
    print("----LOG TIME----")
    print("Encrypted:", encrypted_plate)
    print("---------------------\n")
#-----------------------END lOG TIME-----------------------------------#



#-----MAIN-------#
def main():
    run_constantTime()
    run_logTime()

if __name__ == "__main__":
    main()
#-----------------#