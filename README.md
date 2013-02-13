ramnode-aup
===========

monitoring of ramnode.com's privacy and acceptable use policies.

history logged to the `data` branch:

    $ git checkout data
    $ git whatchanged

hook up with `crontab -e`:

    0 *  *   *   *     cd /path/to/ramnode-aup && sh update.sh data push
