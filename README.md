# ClipBoardSaver
Basic way to save clipboard history. Currently only works for Mac and Windows. Future versions will support Linux. You will need to have the latest version of Perl installed to run this.

I take no responsibility for any misuse of this program. I urge all users to inform others if they are using their computer with this script that it is running in the background. I also ask people to be mindful of what they type into strange computers.

Remember that this is saving stuff to a file, so be mindful of what you are copying and pasting! Keep reading if you are interested in knowing how to encrypt
phrases and information you would prefer to stay secret. :)

Note that this was designed with Unix in mind (macOS to be exact) and the Windows foo is bit of an afterthought. I plan to test that out more throughly in the future.

How To Use:

In a CLI, run `perl ClipBoardSaver.pl`.

While it is running, it will save what is in your clipboard to a file called output_clipboard.txt. I would advise tailing it in a new CLI prompt to see it fill up while it is running.

If you have things that you copy and paste that you don't want to fall in the wrong hands, make a single line file called 'salt' in this directory, 
and add in a random string of characters for a salt.

Run `perl encryptSecrets.pl`, and in the prompt, give it the phrases you want to keep secret. Hit Ctrl+D when you are done.  It will make a file called secrets.txt with encrypted versions of the phrases you want to keep secret. Be sure to have your salt file ready,
otherwise, it won't run. :)

As long as the ClipBoardSaver.pl file is using the same salt that encryptSecrets used to encrypt it, it should be able to compare, and encrypt things.

The encryption is using this: http://perldoc.perl.org/functions/crypt.html, which uses the crypt(3) function in the C library.
You can read more here: https://en.wikipedia.org/wiki/Crypt_(C)

And here: http://man7.org/linux/man-pages/man3/crypt.3.html

Note that this is pretty basic encryption. It's a one-way hash, but nothing is 100% secure, so make sure you keep this file safe. :)

Future plans:

GUI implementation: (A ways off from now, will probably re do this for Python if so.)
More flexiblity where the file can be ran. Right now, it assumes that you are running the file right in the checkout directory.
Packaging.

