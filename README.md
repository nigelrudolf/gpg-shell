# gpg-shell
Convenient shell wrappers for common GPG operations

## Installation

Source the script in your shell:

```bash
source /path/to/gpg-shell.sh
```

To make it permanent, add this line to your `~/.bashrc` or `~/.zshrc`:

```bash
source /path/to/gpg-shell.sh
```

Or, copy the contents of `gpg-shell.sh` to your `~/.bashrc` or `~/.zshrc`.

## Prerequisites

- GPG (GnuPG) must be installed on your system
- You should have a GPG key pair generated
  - Generate one with: `gpg --full-generate-key`

## Usage

### `sign` - Sign a file

Sign a file with your GPG key. For text files, creates a clearsigned file (`.asc`). For binary files, creates a detached signature (`.asc`).

```bash
sign <file_name>
```

**Examples:**
```bash
sign document.txt        # Creates document.txt.asc (clearsigned)
sign image.png          # Creates image.png.asc (detached signature)
```

### `verify` - Verify a signature

Verify a signed file or a detached signature.

```bash
verify <file_name>
```

**Examples:**
```bash
verify document.txt.asc  # Verifies clearsigned document
verify image.png.asc     # Verifies detached signature (requires image.png in same directory)
```

### `encrypt` - Encrypt a file

Encrypt a file for a specific recipient. By default, the file is signed with your key and output in ASCII-armored format.

```bash
encrypt <recipient> <file_name> [--anonymous] [--binary]
```

**Options:**
- `--anonymous` - Encrypt without signing (anonymous)
- `--binary` - Output in binary format instead of ASCII armor (reduces file size by ~33%)

**Examples:**
```bash
encrypt alice@example.com document.txt           # Encrypt and sign for alice
encrypt bob@example.com file.pdf --anonymous     # Encrypt without signing
encrypt charlie@example.com data.bin --binary    # Encrypt in binary format
encrypt dave@example.com secret.txt --anonymous --binary  # Both flags
```

The encrypted file will have `.asc` extension (ASCII armor) or `.gpg` extension (binary).

### `decrypt` - Decrypt a file

Decrypt an encrypted file. Automatically removes `.asc` or `.gpg` extension from output filename.

```bash
decrypt <file_name>
```

**Examples:**
```bash
decrypt document.txt.asc    # Decrypts to document.txt
decrypt file.pdf.gpg        # Decrypts to file.pdf
```

## Common Workflows

### Sending an encrypted file to someone

```bash
# 1. Import recipient's public key (one-time setup)
gpg --import their-public-key.asc

# 2. Encrypt the file for them
encrypt their-email@example.com sensitive-data.txt

# 3. Send them sensitive-data.txt.asc
```

### Receiving and verifying a signed file

```bash
# 1. Import sender's public key (one-time setup)
gpg --import their-public-key.asc

# 2. Verify the signature
verify document.txt.asc

# The signature verification will show if it's valid and who signed it
```

### Creating a signed and encrypted backup

```bash
# Create archive
tar czf backup.tar.gz /path/to/important/files

# Sign it
sign backup.tar.gz

# Encrypt it for yourself
encrypt your-email@example.com backup.tar.gz
```

## Tips

- **Recipient format**: Can be email address, key ID, or fingerprint
- **ASCII armor vs Binary**: ASCII-armored files (`.asc`) are ~33% larger but can be safely pasted into emails or text editors
- **Key management**: Use `gpg --list-keys` to see available keys
- **Trust**: You may need to trust keys with `gpg --edit-key <key-id>` then `trust`

## License

See [LICENSE](LICENSE) for details.
## Support the Project

You can donate using Monero (XMR)

**Monero Address:** 
```
8AGHjrStt9EWEzKao7nvZNEGUHMHjWcJeWXts4wJsaog4eiE5Az4g2UjddiMLHLF6WPrKG2XT5rhcHrqqjTeedSo1RJZhNj
```

## Join the discussion

Matrix: https://matrix.to/#/#frontier:rxve.net
