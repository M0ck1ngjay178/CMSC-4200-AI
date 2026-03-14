#-----------------------CONSTANT TIME-----------------------------------#
KEY = 73  # secret key
SHIFT = 3

def encrypt_constant(license_number):
    encrypted = []
    for c in license_number:
        val = ord(c)
        val = val ^ KEY
        val = ((val << SHIFT) & 255) | (val >> (8 - SHIFT))
        encrypted.append(chr(val))
    return ''.join(encrypted)

def decrypt_constant(cipher):
    decrypted = []

    for c in cipher:
        val = ord(c)
        val = ((val >> SHIFT) | (val << (8 - SHIFT))) & 255
        val = val ^ KEY
        decrypted.append(chr(val))
    return ''.join(decrypted)


def run_constantTime():
    plate = "ABC1234"
    enc = encrypt_constant(plate)
    print("----CONSTANT TIME----\n")
    print("Encrypted:", enc)
    dec = decrypt_constant(enc)
    print("Decrypted:", dec)
    print("---------------------\n")

#-----------------------END CONSTANT TIME-----------------------------------#

#-----------------------LOG TIME-----------------------------------#
import hashlib

class KeyNode:
    def __init__(self, key):
        self.key = key
        self.left = None
        self.right = None
class LogEncryption:

    def __init__(self):
        self.root = None

    def insert_key(self, key):
        self.root = self._insert(self.root, key)

    def _insert(self, node, key):
        if node is None:
            return KeyNode(key)
        if key < node.key:
            node.left = self._insert(node.left, key)
        else:
            node.right = self._insert(node.right, key)
        return node

    def find_key(self, value):
        node = self.root
        while node:
            if value < node.key:
                node = node.left
            elif value > node.key:
                node = node.right
            else:
                return node.key
        return self.root.key  # fallback


    def encrypt(self, license_number):
        num = int(hashlib.sha256(license_number.encode()).hexdigest(), 16)
        key = self.find_key(num % 100)
        cipher = num ^ key
        return hex(cipher)

#-----------------------END lOG TIME-----------------------------------#
def run_logTime():
    enc = LogEncryption()
    enc.insert_key(10)
    enc.insert_key(25)
    enc.insert_key(50)
    enc.insert_key(75)
    enc.insert_key(90)
    print("----LOG TIME----\n")
    print(enc.encrypt("ABC1234"))
    print("------------------\n")


#-----MAIN-------#
def main():
    run_constantTime()
    run_logTime()

if __name__ == "__main__":
    main()
#-----------------#