Adaencrypt
==========
Wrote the encryption stuff in Ada. There are two flags. 'encrypt' and 'decrypt'.
The shortands are 'e', 'd' respectively. The input is read from stdin. The
output is printed in stdout. For example you can do the following:

    echo "Get out of here stalker" | ./adaencrypt e

and you can decrypt by giving the alphabetic string like this

    echo "Hfu pvu pg ifsf tubmlfs" | ./adaencrypt d

You can also sanity check by doing this:

   echo 'My MIND!!' | ./adaencrypt e | ./adaencrypt d

Compile with

    mkdir -p obj && gnatmake adaencrypt.adb -D obj

