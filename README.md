# AES
AES encryption for FPGA

This implementation is targetted for Altera devices. Hence using altera IPs. 

For HDL implementation, you need to generate memory initialization files depending on the key you are using. This is not build into the HDL code. 
So you can generate sbox.hex, roundkey.hex, key.hex and text.hex (which is the byte array you need to encrypt)

Use C helper files to generate hex files
