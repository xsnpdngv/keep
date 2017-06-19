# =============================================================================
# @file    Makefile
# @brief   GnuPG key handling, encryption and decryption
# @author  Tamas Dezso <dezso.t.tamas@gmail.com>
# @date    March 21, 2017
# =============================================================================

PGP = gpg2
EDITOR ?= vi
#UID = "Tamas Dezso"

.PHONY: help keys export import Makefile

# help
help:
	@echo "make keys      Generate key pair"
	@echo "make export    Export key pair to ascii files"
	@echo "make import    Import public_key.asc and private_key.asc"
	@echo "make file.asc  Encrypt file <file> to self"
	@echo "make file      Decrypt file <file.asc> and open result in $(EDITOR)"

# keygen
keys:
	$(PGP) --full-generate-key

# export public and private keys
export:
	$(PGP) --export --armor -o public_key.asc $(UID)
	umask 077; $(PGP) --export-secret-key --armor -o private_key.asc $(UID)

# import public and private keys
import: public_key.asc private_key.asc
	$(PGP) --import public_key.asc
	$(PGP) --import private_key.asc

# encrypt
%.asc:: %
	$(PGP) --encrypt --default-recipient-self --armor -o $@ $< && ./sdel.sh $<

# decrypt
%:: %.asc
	umask 077; $(PGP) --decrypt -o $@ $<
	$(EDITOR) $@
