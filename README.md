# sicp-streams
SICP style streams implemented in Common Lisp.<br>
Special thanks to Abelson, the Sussmans, Eli Bendersky, and jcs at irreal.org.<br>
I ported the SICP code from MIT Scheme to CL, but periodically checked how badly<br>
I had gone astray at https://eli.thegreenplace.net/2007/11/05/sicp-sections-351-352<br>
and https://irreal.org/blog/?p=3632 .<br>
So far I have finding the nth prime and nth twin-prime pair as demos.<br>
Many more that have not been uploaded as of now.<br>
Usage: sbcl --script nth-prime.lisp n<br>
Usage: sbcl --script nth-twin-prime-pair.lisp n<br>
Usage: sbcl --script nth-triangular.lisp n<br>
Below yields prime-factorization of n.<br>
Usage: sbcl --script prime-factorization.lisp n<br>
Below yields prime-factorizations of first n composite numbers.<br>
Usage: sbcl --script prime-factorizations.lisp n<br>
Below yields first n semiprimes and their prime-factorization.<br>
Usage: sbcl --script semiprimes.lisp n<br>
Example runs:
<pre>
sbcl --script nth-prime.lisp 4000
37813
</pre>
<br>
<pre>
sbcl --script nth-twin-prime-pair.lisp 4000
(424769. 424771)
</pre>
<br>
<pre>
sbcl --script nth-triangular.lisp 4000
 8002000
</pre>
<br>
<pre>
sbcl --script prime-factorization.lisp 281474976710619
(3 3 1187 26347933793)
</pre>
<br>
<pre>
sbcl --script prime-factorizations.lisp 20
 4 (2 2)
 6 (2 3)
 8 (2 2 2)
 9 (3 3)
 10 (2 5)
 12 (2 2 3)
 14 (2 7)
 15 (3 5)
 16 (2 2 2 2)
 18 (2 3 3)
 20 (2 2 5)
 21 (3 7)
 22 (2 11)
 24 (2 2 2 3)
 25 (5 5)
 26 (2 13)
 27 (3 3 3)
 28 (2 2 7)
 30 (2 3 5)
 32 (2 2 2 2 2)
</pre>
<br>
<pre>
sbcl --script semiprimes.lisp 20
 4 (2 2)
 6 (2 3)
 9 (3 3)
 10 (2 5)
 14 (2 7)
 15 (3 5)
 21 (3 7)
 22 (2 11)
 25 (5 5)
 26 (2 13)
 33 (3 11)
 34 (2 17)
 35 (5 7)
 38 (2 19)
 39 (3 13)
 46 (2 23)
 49 (7 7)
 51 (3 17)
 55 (5 11)
 57 (3 19)
</pre>
