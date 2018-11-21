# =============================================================================
# @file    Makefile
# @brief   GnuPG key handling, encryption and decryption
# @author  Tamas Dezso <dezso.t.tamas@gmail.com>
# @date    March 21, 2017
# =============================================================================

PGP = gpg2
ASC = $(wildcard *.asc)
SEC = $(filter-out $(ASC) $(PROJECT),$(wildcard *))
PROJECT = Makefile README.md sdel
#UID = "Tamas Dezso"

.PHONY: help keys export import plain clean Makefile

# help
help:
	@echo -e "Usage:\n\
    make file.asc  Encrypt: file -> file.asc\n\
    make file      Decrypt: file.asc -> file\n\
    make clean     Encrypt plain files if needed, then remove originals\n\
    make plain     Decrypt *.asc\n\
    make keys      Generate key pair\n\
    make export    Export keys to public_key.asc, private_key.asc\n\
    make import    Import keys from public_key.asc and private_key.asc"

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

# encrypt: file -> file.asc
%.asc:: %
	@$(PGP) --encrypt --default-recipient-self --armor -o $@ $<
	@./sdel $<

# decrypt: file.asc -> file
%:: %.asc
	@umask 077; $(PGP) --decrypt -o $@ $<
	@touch -r $? $@ # to be no newer than the encrypted one

# decrypt *.asc
plain: $(basename $(ASC))

# if file is present as .asc too, and is no newer than that, then
# it is simply removed, otherwise it is encrypted before
clean:
	$(MAKE) $(SEC:=.asc)
	@./sdel -f $(SEC)
