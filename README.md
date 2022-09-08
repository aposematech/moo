# moo

### Usage

Basic:
```
$ curl https://api.djfav.ninja/moo
```

Advanced:
```
$ sudo apt-get update
$ sudo apt-get install -y cowsay jq

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
