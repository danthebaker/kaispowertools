kaispowertools
==============

My name is Kai.

I am not the [original Kai](http://en.wikipedia.org/wiki/Kai's_Power_Tools).

Instead I am a server Kai and my power tools are for web application servers not Photoshop.

Enjoy!

# Sublime Text

Imagine giving Beethoven [this piano](http://www.amazon.co.uk/LeapFrog-19204-Poppin-Play-Piano/dp/B00804BDE0/ref=sr_1_2?ie=UTF8&qid=1375516681&sr=8-2&keywords=toy+piano) upon which to compose the 5th.

Now - if as a programmer you do not have the BEST text editor, you might as well join the Tonka Toy club.

IMHO [Sublime Text](http://www.sublimetext.com/) is [this piano](http://georgepianoworld.blogspot.co.uk/2012/07/the-most-expensive-piano-in-world-ever.html) for your next composition.

# node.js

Pop into a coffee shop in the morning rush - the queue is 10 deep and everyone is frenzied for their caffine.

### blocking

The name of the shop is 'blocking caffine ltd' - it only EVER employs a single barrista for the whole shop.

The result?

A queue that is dealt with one request at a time - the guy at the front says 'Cappuchino' - the poor barrista turns around, froths the milks, brews the beans and 2 minutes later presents the coffee.

Meanwhile - the other 9 people behind have left and gone next door.

### non-blocking

Next door there is a shop called 'non-blocking caffine ltd' - it also only employs a single serving barrista but also has 5 brewing barristas behind them.

What 'non-blocking caffine' worked out is that for a single customer, 90% of the time was being spent brewing the coffee.

They realised that if their single serving barrista delegated the task of 'loading' the coffee to the next availiable brewer - they could turn around immediately and take the next customers order.

The result?

'blocking caffine' - taken 1 order within 5 seconds and served 1 customer within 2 mins - all the other customers had left at this point

	total = 1 customer in 2 mins

'non-blocking caffine' - taken 9 orders within 45 seconds and served 5 customers within 2 mins and the other 4 in the next 2 mins.

	total = 5 customers in 2 mins
					4 customers in 2 mins

### back to putas

Your databases and your hard-disks are the coffee machines - loading things from them takes 90% the time of your request.

Whilst we are waiting for the network and/or hard-disk - what are we doing?

In the blocking model - NOTHING

In the non-blocking model - TAKE THE NEXT ORDER

### node

[node.js](http://nodejs.org/) is a non-blocking network server that you control by writing JavaScript.

[JavaScript](http://www.crockford.com/javascript/javascript.html) runs in web browsers.

Using node - we can write the same code in browsers as on the server - and have it non-blocking.





