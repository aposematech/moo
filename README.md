# moo
```
$ sudo apt-get update
$ sudo apt-get install -y curl jq cowsay

$ curl -s https://api.djfav.ninja/moo | jq -r .quote | cowsay -d
 ________________________________________
/ You must have chaos within you to give \
\ birth to a dancing star.               /
 ----------------------------------------
        \   ^__^
         \  (xx)\_______
            (__)\       )\/\
             U  ||----w |
                ||     ||
```
# put-item
```
$ sudo apt-get update
$ sudo apt-get install -y uuid

$ ./scripts/put-item.sh \
-r "us-east-1" \
-t "moo" \
-n "Zarathustra" \
-q "You must have chaos within you to give birth to a dancing star."
```
# aws
![diagram](./moo.drawio.png)
