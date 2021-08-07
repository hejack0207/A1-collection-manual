[]{#migration .anchor-link}[Migrating from 0.7.x to 0.8](#migration) {#migrating-from-0.7.x-to-0.8 .anchor-heading}
--------------------------------------------------------------------

0.8 is our first (and hopefully last) release with a
non-backwards-compatible wire protocol, ZooKeeper layout, and on-disk
data format. This was a chance for us to clean up a lot of cruft and
start fresh. This means performing a no-downtime upgrade is more painful
than normal---you cannot just swap in the new code in-place.

### []{#migration_steps .anchor-link}[Migration Steps](#migration_steps) {#migration-steps .anchor-heading}

1.  Setup a new cluster running 0.8.
2.  Use the 0.7 to 0.8 [migration tool](tools.html) to mirror data from
    the 0.7 cluster into the 0.8 cluster.
3.  When the 0.8 cluster is fully caught up, redeploy all data
    *consumers* running the 0.8 client and reading from the 0.8 cluster.
4.  Finally migrate all 0.7 producers to 0.8 client publishing data to
    the 0.8 cluster.
5.  Decommission the 0.7 cluster.
6.  Drink.
