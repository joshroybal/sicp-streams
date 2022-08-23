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
