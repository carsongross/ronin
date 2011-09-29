---
title: Background Tasks
layout: default
---

A common need for web applications is to schedule background processes to run at certain
intervals.  Ronin provides a simple API for this purpose, based on the popular Quartz
library.

## Scheduling Tasks

To schedule a task you can use the `schedule()` method available in your `RoninConfig`
class when setting up your Ronin application.  Here is a simple example:

{% highlight js %}
	schedule( :atHour = 1, :task = \-> scrubTempDirectory() )
{% endhighlight %}

This would schedule the `scrubTempDirectory()` method to be run every day at 1AM.  Of course the
body of the block can be any arbitrary expression, so a more complicated job might be encapsulated
in a class and invoked:

{% highlight js %}
	schedule( :atHour = 1, :task = \-> new TempDirScrubber().run() )
{% endhighlight %}

Or not.

If you wanted to schedule a job for midnight and 12 pm you could use the `:atHours` argument instead,
which takes a list of hours to run at:

{% highlight js %}
	schedule( :atHours = {0, 12}, :task = \-> scrubTempDirectory() )
{% endhighlight %}

Your scheduling can get quite elaborate, if necessary:

{% highlight js %}
	schedule( :atSecond = 30, :atMinutes = {15, 45}, :atHours = 1..12,
              :onDays = {MONDAY, LAST_WEDNESDAY}, :task = \-> doIt() )
{% endhighlight %}

This example would run at the thirty second mark of the fifteenth and fourty-fifth minute of every hour
from 1 am to 12 pm, on every Monday and the last Wednesday of the month.  Insane, but that's what
it would do.

There are some cron-like options that are not available via the simplified arguments of
`schedule()`.  You can pass a [raw Quartz cron string] (http://www.quartz-scheduler.org/documentation/quartz-1.x/tutorials/crontrigger)
if you need these more exotic options by using the `:cronString` parameter:

{% highlight js %}
	schedule( :cronString = "0 15 10 ? * 6L 2002-2005", :task = \-> doIt() )
{% endhighlight %}

According to the Quartz documentation linked to above, this means "Fire at 10:15am on every last 
friday of every month during the years 2002, 2003, 2004 and 2005"

## Why Such An Old Version Of Quartz?

We use version 1.5.2 of Quartz because it doesn't have any dependencies, in stark contrast to the 
newer versions, and the functionality provided by the newer versions isn't particularly compelling.
