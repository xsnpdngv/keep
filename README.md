Keep files safe with PGP
========================

This is a Makefile project for basic PGP (Pretty Good Privacy) operations
(keygen, export/import, encrypt/decrypt) utilizing the GnuPG (GNU Privacy Guard)
implementation in order to easily encrypt and decrypt files with sensitive
content.



Prerequisites
-------------

Install GnuPG package on Debian/Ubuntu machine:

```bash
sudo apt-get install gnupg2
```

or for other OS download from GnuPG's site and install:

[https://www.gnupg.org/download/index.en.html](https://www.gnupg.org/download/index.en.html)


Usage
-----

### Generate Key Pair

Generate private/public key pair interactively if there are no such yet

```bash
make keys
```

Keys are going to be stored under `~/.gnupg` in a key database protected
with the password given through the process of generation.

### Export/Import Keys

Keys might need to be ported to other systems. In order to port the whole key
database it is enough to copy the `~/.gnupg` directory to the target system.

To port only the keys of interest exporting and importing them is needed.
To do so set the `UID` in the Makefile to the one whose keys are to be
ported and `make export`. On the target machine with the same Makefile and
the exported keys along `make import`.

### Encrypting/Decrypting Files

To encrypt a file with the name `filename` (and optionally delete the
plain one after encryption):

```bash
make filename.asc
```

To decrypt an encrypted file with the name `filename.asc` and get back the
original one:

```bash
make filename
```
