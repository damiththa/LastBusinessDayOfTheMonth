LastBusinessDayOfTheMonth
=========================

I know it is confusing but this is something I had to accomplish recently. But if you really think about it, it’s very useful in many in-office applications.
Anyhow, after ample internet reading and searching, I finally figured it out
Here is how I did it. I’m sure there are plenty of ways of doing this, but to save you the trouble I’m posting it. Feel free to use and please comments thoughts, suggestions, etc.
And BTW, this snippet finds the Last Business Day of the month. With a little bit of tweaking, it’s easy to find the first business day of next month. (I actually had to find both, in two different occurrences). Here we go, Before we get into coding here is a scenario to think about. Let’s say we found what’s the last business day of the month, but what if that’s a company holiday…. aha problemo isn’t it? Not so much, if we factor that into coding.
Nowadays almost every company has a table of company holidays. This is usually managed by HR dept. and this list contains company holidays as well as national holidays.
Oh BTW, when this is running I made it pop up a cfwindow saying ‘today is the last business day of this month, do whatcha gotta do’
