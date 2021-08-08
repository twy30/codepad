---
Version: 2021-Aug-08 02:16:14
---

This folder contains the "Reviewer" tools and tests.

# The `Version` Property

The `Version` property is the last review's timestamp; i.e.,

```YAML
Version: yyyy-MMM-dd HH:mm:ss
```

# Dependencies

As of commit `65a2277149f3b2ae13afe40c25cdd3d4b6fa3363`, the Reviewer
tools depend on these programs:

* `aspell`
* `basename`
* `bash`
* `dirname`
* `echo`
* `find`
* `grep`
* `head`
* `od`
* `sha512sum`
* `sort`
* `tail`

The Reviewer tests depend on these programs:

* `git`
* `ls`
* `rm`
