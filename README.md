# ClipBoardSaver
Basic way to save clipboard history. Currently only works for Mac and Windows. Future versions will support Linux. You will need to have the latest version of Perl installed to run this.

I take no responsibility for any misuse of this program. I urge all users to inform others if they are using their computer with this script to inform them of it running in the background. I also remind people to be mindful of what they type into strange computers.

Remember that this is saving stuff to a file, so be mindful of what you are copying and pasting! Keep reading if you are interested in knowing how to encrypt
phrases and information you would perfer to stay secret. :)

How To Use:

In a CLI, run perl ClipBoardSaver.pl.

While it is running, it will save what is in your clipboard to a file.

If you have things that you copy and paste that you don't want to fall in the wrong hands, make a single line file called 'salt' in this directory, 
and add in a random string of characters for a salt.

Run encryptSecrets.pl, and in the prompt, give it the phrases you want to keep secret. Hit Ctrl+D when you are done.  It will make a file called secrets.txt
with encrypted versions of the phrases you want to keep secret.

As long as the ClipBoardSaver.pl file is using the same salt that encryptSecrets used to encrypt it, it should be able to compare, and encrypt things.
