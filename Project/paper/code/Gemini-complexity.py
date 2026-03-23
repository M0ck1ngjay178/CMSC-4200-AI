# -----------------------CONSTANT TIME-----------------------------------#


def encrypt_constant_time(number, key=0xABC123):
    """
    Encrypts an integer license number in O(1) time.
    Uses XOR and a simple bit-rotation.
    """
    # Step 1: XOR with key
    shuffled = number ^ key

    # Step 2: Bitwise rotation (assuming 32-bit license)
    # Move the last 8 bits to the front
    encrypted = ((shuffled & 0xFF) << 24) | (shuffled >> 8)

    return encrypted


def decrypt_constant_time(encrypted, key=0xABC123):
    # Step 1: Reverse rotation
    reshuffled = ((encrypted >> 24) & 0xFF) | ((encrypted << 8) & 0xFFFFFFFF)

    # Step 2: XOR back
    return (reshuffled ^ key) & 0xFFFFFFFF


# -----------------------END CONSTANT TIME-----------------------------------#


def encrypt_log_time(number, key=42):
    """
    O(log N) encryption where N is the value of the number.
    The number of iterations is proportional to the bit-length.
    """
    if number == 0:
        return number ^ key

    # Logarithmic complexity: bit_length is ~log2(number)
    num_bits = number.bit_length()
    result = number

    for i in range(num_bits):
        # A simple 'round' function that changes based on bit position
        round_key = (key + i) % 256
        result = result ^ round_key
        # Circular shift left by 1
        result = ((result << 1) | (result >> (num_bits - 1))) & ((1 << num_bits) - 1)

    return result


# -----------------------LOG TIME-----------------------------------#


# Helper to handle the "ABC1234" string as an integer
def string_to_int(s):
    # Converts hex-like string to integer
    return int(s, 16)


def int_to_string(i):
    # Converts integer back to hex-like string, uppercase
    return hex(i)[2:].upper()


# --- LOG TIME DECRYPTION (Added for completeness) ---
def decrypt_log_time(encrypted, key=42):
    if encrypted == 0:
        return encrypted ^ key
    num_bits = encrypted.bit_length()
    result = encrypted
    # We must reverse the operations in exact reverse order
    for i in range(num_bits - 1, -1, -1):
        # Reverse circular shift (Right shift)
        result = ((result >> 1) | (result << (num_bits - 1))) & ((1 << num_bits) - 1)
        # Reverse XOR
        round_key = (key + i) % 256
        result = result ^ round_key
    return result


# ----------------------- MAIN -----------------------#

if __name__ == "__main__":
    test_data = "ABC1234"
    # Convert "ABC1234" to integer 180097588
    val = string_to_int(test_data)

    print(f"--- Testing License: {test_data} (Int: {val}) ---")

    # 1. Constant Time Test
    c_enc = encrypt_constant_time(val)
    c_dec = decrypt_constant_time(c_enc)
    print(f"\n[Constant Time O(1)]")
    print(f"Encrypted: {c_enc}")
    print(f"Decrypted: {int_to_string(c_dec)}")

    # 2. Log Time Test
    l_enc = encrypt_log_time(val)
    l_dec = decrypt_log_time(l_enc)
    print(f"\n[Logarithmic Time O(log n)]")
    print(f"Encrypted: {l_enc}")
    print(f"Decrypted: {int_to_string(l_dec)}")

# ----------------------- END MAIN -----------------------#
