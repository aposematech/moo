# cowsay-quotes

### Usage

Basic: `curl https://quotes.djfav.ninja`

Advanced: `curl -s -XPOST "http://quotes.djfav.ninja" -d '{}' | jq .body.quote | tr -d '"' | cowsay`

```
 ________________________________________
/ You must have chaos within you to give \
\ birth to a dancing star.               /
 ----------------------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
```
