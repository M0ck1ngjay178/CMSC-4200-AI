import hashlib
import time

ITERATIONS = 200000   # intentionally large
SALT = b"BankSecureSalt"

def slow_hash(data):
    h = data.encode()

    for i in range(ITERATIONS):
        h = hashlib.sha256(h + SALT).digest()

    return h.hex()

def hash_transaction_history(transactions):

    previous_hash = "GENESIS"

    ledger = []

    for tx in transactions:
        combined = tx + previous_hash
        tx_hash = slow_hash(combined)

        ledger.append({
            "transaction": tx,
            "previous_hash": previous_hash,
            "hash": tx_hash
        })

        previous_hash = tx_hash

    return ledger


transactions = [
    "TX001: Alice -> Bob $500",
    "TX002: Bob -> Carol $200",
    "TX003: Carol -> Dave $50",
    "TX004: Dave -> Bank $10"
]

start = time.time()

ledger = hash_transaction_history(transactions)

end = time.time()

for entry in ledger:
    print("----Entry", entry, "---\n")

print("\nTime taken:", end - start, "seconds")