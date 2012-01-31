---
title: Using Ronin and Tosa Together
layout: default
---

As you may have noticed, each Tosa entity type defines `fromId()` and
`toId()` methods, which means that they are also valid Ronin entity types.
Using Tosa entities in a Ronin app therefore requires no extra effort on
your part. For example, if you have a Tosa type called `db.mydb.Person`,
you can define a Ronin controller like:

{% highlight js %}
    package controller

    uses db.mydb.Person

    class PersonController {
      static function view(p : Person) {
        ...
      }
    }
{% endhighlight %}

Accessing the URL "`http://localhost:8080/PersonController/view?p=5`" will
automatically fetch the `Person` object whose ID is 5 from the database and
pass it to your `view()` method.

The Tosa transaction model is thread-local, so it is safe to use within a
Ronin request, since most web servers run each request in its own thread.
