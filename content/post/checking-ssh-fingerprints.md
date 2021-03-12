+++
title = "Checking SSH key fingerprints"
date = 2021-03-05T00:00:00+08:00
description = "Counting items of a DynamoDB table"
tags = ["SSH", "GitHub"]
showLicense = false
draft = false
+++

SSH key rotation is something real, so, sometime in the future you might get hit by a mail //kindly// asking you to rotate or recreate your SSH key. Let's note down a useful command to compare SSH keys.

<!--more--> 

So you get this notification email referring to a SSH key you have configured in your GitHub account. I usually stored multiple SSH keys for different purposes in my `~/.ssh` directory (I know, I might not be supposed to do it this way!), hence need to identify which key it is corresponding when I'm dumb enough to not properly name the key pair.

From GitHub we can see more information regarding this key, like the last time it was used <b>AND</b> the SSH key fingerprint (follows two examples retrieved in different GitHub versions):

![](/ssh-key-fingerprints0.png)
![](/ssh-key-fingerprints1.png)

Now, we can check through our `~/.ssh` folder public keys for such finger prints:

```sh
$ ssh-keygen -l -E md5 -f ~/.ssh/test-key.pub 
4096 MD5:c3:d3:6d:26:4e:be:fd:c1:dc:17:98:cd:a2:32:a2:e3 test@test.com (RSA)
$ ssh-keygen -l -f ~/.ssh/test-key.pub
4096 SHA256:u4hFc6p02ERfkdZ2tjiVpFJ/SYB7eMMOXZWrurrdRzA test@test.com (RSA)
```

 :tada: Tada! :tada: